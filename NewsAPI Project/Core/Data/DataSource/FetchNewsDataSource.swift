//
//  FetchNewsDataSource.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

import Foundation
import SwiftUI

protocol CloudFetchNewsDataSourceDelegate {
    func fetchNews(with query: FetchNewsQuery, _ completion: @escaping Response<NewsEntity>)
    func fetchNewsFromRealm(_ completion: @escaping Response<[NewModelRealm]>)
}

final class CloudFetchNewsDataSource: CloudFetchNewsDataSourceDelegate {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchNews(with query: FetchNewsQuery, _ completion: @escaping Response<NewsEntity>) {
        let request = FetchNewsQueryRequest()

        apiClient.execute(request) { result in
            switch result {
            case .success(let response):
                for new in response.news ?? [] {
                    RealmManager.addNew(model: NewModelRealm(from: new))
                }
                completion(.success(response))
            case .error(let error):
                completion(.error(error))
            }
        }
    }

    func fetchNewsFromRealm(_ completion: @escaping Response<[NewModelRealm]>) {
        RealmManager.retrieveNews { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
