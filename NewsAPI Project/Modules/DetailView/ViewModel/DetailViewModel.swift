//
//  DetailViewModel.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Foundation
import UIKit

protocol DetailViewModelInput {
    func viewDidLoad()
}

protocol DetailViewModelOutput {
    var cells: Box<[DetailViewListElements]?> { get set }
}

typealias DetailViewModel = DetailViewModelInput & DetailViewModelOutput

enum DetailViewListElements {
    case titleCell(title: String)
    case dateCell(dateString: String)
    case imageCell(imageURL: String)
    case bodyDescriptionCell(descriptionString: String)
}

final class DefaultDetailViewModel: DetailViewModel {
    var cells: Box<[DetailViewListElements]?> = Box(nil)
    var newSelected: NewPresentationModel

    init(newSelected: NewPresentationModel) {
        self.newSelected = newSelected
    }

    func viewDidLoad() {
        createCell()
    }

    // MARK: - CreateCells method

    private func createCell() {
        var cells: [DetailViewListElements] = []

        cells.append(.titleCell(title: newSelected.title))
        cells.append(.imageCell(imageURL: newSelected.imageURL))
        cells.append(.dateCell(dateString: newSelected.date))
        cells.append(.bodyDescriptionCell(descriptionString: newSelected.description))

        self.cells.value = cells
    }
}
