//
//  HomeViewModel.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Foundation
import Kingfisher
import UIKit

protocol HomeViewModelInput {
    func viewDidLoad()
    func sortedButtonTapped()
    func filterNews(searchText: String)
    func retryButton()
}

protocol HomeViewModelOutput {
    var cells: Box<[HomeViewListElements]?> { get set }
    var error: Box<Bool?> { get set }
    var model: HomeModel? { get set }
    var filteredNews: [NewPresentationModel] { get set }
    var upwardSorted: Box<Bool?> { get set }
    var searchBarVisible: Box<Bool?> { get set }
}

typealias HomeViewModel = HomeViewModelInput & HomeViewModelOutput

enum HomeViewListElements {
    case shimmer
    case newCell(id: String, imageURL: String, date: String, title: String, description: String)
    case emptyCell(title: String)
}

final class DefaultHomeViewModel: HomeViewModel {
    var cells: Box<[HomeViewListElements]?> = Box(nil)
    var model: HomeModel?
    var filteredNews: [NewPresentationModel] = []
    var upwardSorted: Box<Bool?> = Box(false)
    var searchBarVisible: Box<Bool?> = Box(false)
    var error: Box<Bool?> = Box(false)

    private var fetchNewsUseCase: FetchNewsUseCase

    init(fetchNewsUseCase: FetchNewsUseCase) {
        self.fetchNewsUseCase = fetchNewsUseCase
    }

    func viewDidLoad() {
        self.showShimmer()
        self.fetchNews()
    }

    func showShimmer() {
        var cells: [HomeViewListElements] = []

        cells.append(.shimmer)
        cells.append(.shimmer)
        cells.append(.shimmer)
        cells.append(.shimmer)

        self.cells.value = cells
    }

    func retryButton() {
        self.viewDidLoad()
    }

    func fetchNews() {
        let params = FetchNewsQuery(idQuery: "")
        fetchNewsUseCase.execute(with: params) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let news = response.news ?? []
                    var newsPresentation: [NewPresentationModel] = []

                    for new in news {
                        var description: String = new.description ?? "Esta noticia no tiene descripción"

                        if let content = new.content {
                            description = content
                        }

                        var urlImage: String = "https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807"

                        if let url = new.urlToImage {
                            if url.contains("http") {
                                urlImage = url
                            }
                        }

                        newsPresentation.append(NewPresentationModel(id: new.ID ?? "",
                                                                     title: new.title ?? "",
                                                                     description: description,
                                                                     imageURL: urlImage,
                                                                     date: new.publishedAt ?? ""))
                    }

                    self.filteredNews = newsPresentation
                    self.model = HomeModel(news: newsPresentation)
                    self.createCells()
                case .error(let error):
                    debugPrint("Error \(error)")
                    self.cells.value = []
                    self.error.value = true
                }
            }
        }
    }

    func createCells() {
        var cells: [HomeViewListElements] = []

        if !self.filteredNews.isEmpty {
            for new in self.filteredNews {
                cells.append(.newCell(id: new.id,
                                      imageURL: new.imageURL,
                                      date: new.date,
                                      title: new.title,
                                      description: new.description))
            }
        } else {
            cells.append(.emptyCell(title: "No se han encontrado noticias"))
        }

        self.cells.value = cells
    }

    func sortedButtonTapped() {
        self.upwardSorted.value = !(self.upwardSorted.value ?? false)
        self.filteredNews = self.filteredNews.sorted(by: { (self.upwardSorted.value ?? false) ? $0.date < $1.date : $0.date > $1.date })
        self.createCells()
    }

    func filterNews(searchText: String) {
        let unfilteredNews = self.model?.news ?? []

        let filteredNewsAuxiliar = unfilteredNews.filter { new in
            new.title.lowercased().contains(searchText.lowercased())
        }

        self.filteredNews = searchText.isEmpty ? unfilteredNews : filteredNewsAuxiliar

        self.createCells()
    }
}
