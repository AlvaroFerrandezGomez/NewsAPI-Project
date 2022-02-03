//
//  FetchNewsDataRepository.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

import Foundation

final class FetchNewsDataRepository: FetchNewsRepository {
    private let dataSource: CloudFetchNewsDataSourceDelegate

    init(dataSource: CloudFetchNewsDataSourceDelegate) {
        self.dataSource = dataSource
    }

    func fetchNews(with query: FetchNewsQuery, _ completion: @escaping Response<NewsModel>) {
        self.dataSource.fetchNews(with: query) { result in
            switch result {
            case .success(let response):
                completion(.success(response.toDomain()))
            case .error:
                self.dataSource.fetchNewsFromRealm { result in
                    switch result {
                    case .success(let responseRealm):
                        completion(.success(NewsModel(news: responseRealm.compactMap { $0.toDomain() })))
                    case .error(let error):
                        completion(.error(error))
                    }
                }
            }
        }
    }
}
