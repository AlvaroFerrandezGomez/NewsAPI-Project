//
//  NewsModel.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

import Foundation

final class NewsModel {
    var status: String?
    var totalResults: Int?
    var news: [NewModel]?

    internal init(status: String? = "", totalResults: Int? = 0, news: [NewModel]?) {
        self.status = status
        self.totalResults = totalResults
        self.news = news
    }
}
