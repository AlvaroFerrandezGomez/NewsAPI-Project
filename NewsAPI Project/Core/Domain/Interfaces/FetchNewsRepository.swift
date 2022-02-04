//
//  FetchNewsRepository.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

protocol FetchNewsRepository {
    func fetchNews(_ completion: @escaping Response<NewsModel>)
}
