//
//  NewsEntity.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

struct NewsEntity: Codable {
    let status: String?
    let totalResults: Int?
    let news: [NewEntity]?

    private enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case news = "articles"
    }
}

extension NewsEntity {
    func toDomain() -> NewsModel {
        return NewsModel(status: status,
                         totalResults: totalResults,
                         news: news?.compactMap { $0.toDomain() })
    }
}
