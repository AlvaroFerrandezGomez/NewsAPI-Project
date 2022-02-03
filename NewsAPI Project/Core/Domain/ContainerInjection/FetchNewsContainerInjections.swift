//
//  FetchNewsContainerInjections.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

import Foundation

final class FetchNewsContainerInjections {
    static func provideFetchNewsUseCase() -> FetchNewsUseCase {
        let repository = provideFetchNewsRepository()
        return DefaultFetchNewsUseCase(repository: repository)
    }

    static func provideFetchNewsRepository() -> FetchNewsRepository {
        let dataSource = provideDataSource()
        return FetchNewsDataRepository(dataSource: dataSource)
    }

    static func provideDataSource() -> CloudFetchNewsDataSourceDelegate {
        let apiClient = NetworkClient()
        return CloudFetchNewsDataSource(apiClient: apiClient)
    }
}
