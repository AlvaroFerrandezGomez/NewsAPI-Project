//
//  FetchNewsRepository.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

protocol FetchNewsRepository {
    func fetchNews(with query: FetchNewsQuery, _ completion: @escaping Response<NewsModel>)
}
