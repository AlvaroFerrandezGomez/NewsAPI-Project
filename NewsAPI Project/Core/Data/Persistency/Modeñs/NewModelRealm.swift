//
//  NewModelRealm.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 3/2/22.
//

import Foundation
import RealmSwift

class NewModelRealm: Object {
    @Persisted var sourceID: String?
    @Persisted var sourceName: String?
    @Persisted var author: String = ""
    @Persisted var title: String = ""
    @Persisted var descriptionString: String = ""
    @Persisted var url: String = ""
    @Persisted var urlToImage: String = ""
    @Persisted var publishedAt: String = ""
    @Persisted var content: String = ""

    override init() {}

    internal init(from model: NewEntity) {
        self.sourceID = model.source?.id ?? ""
        self.sourceName = model.source?.name ?? ""
        self.author = model.author ?? ""
        self.title = model.title ?? ""
        self.descriptionString = model.description ?? ""
        self.url = model.url ?? ""
        self.urlToImage = model.urlToImage ?? ""
        self.publishedAt = model.publishedAt ?? ""
        self.content = model.content ?? ""
    }
}

extension NewModelRealm {
    func toDomain() -> NewModel {
        return NewModel(source: SourceModel(id: sourceID, name: sourceName),
                        author: author,
                        title: title,
                        description: descriptionString,
                        url: url,
                        urlToImage: urlToImage,
                        publishedAt: publishedAt,
                        content: content)
    }
}
