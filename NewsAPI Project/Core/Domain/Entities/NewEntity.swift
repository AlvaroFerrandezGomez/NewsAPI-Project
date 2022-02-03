//
//  NewEntity.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

import Foundation

struct NewEntity: Codable {
    var source: SourceEntity?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    private enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

extension NewEntity {
    func toDomain() -> NewModel {
        return NewModel(source: source?.toDomain(),
                        author: author,
                        title: title,
                        description: description,
                        url: url,
                        urlToImage: urlToImage,
                        publishedAt: publishedAt,
                        content: content)
    }
}
