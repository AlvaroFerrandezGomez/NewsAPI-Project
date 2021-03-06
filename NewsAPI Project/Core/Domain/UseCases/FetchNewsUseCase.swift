//
//  FetchNews+UseCase.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

protocol FetchNewsUseCase {
    func execute(_ completion: @escaping Response<NewsModel>)
}

final class DefaultFetchNewsUseCase: FetchNewsUseCase {
    private let repository: FetchNewsRepository

    init(repository: FetchNewsRepository) {
        self.repository = repository
    }

    func execute(_ completion: @escaping Response<NewsModel>) {
        repository.fetchNews() { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
