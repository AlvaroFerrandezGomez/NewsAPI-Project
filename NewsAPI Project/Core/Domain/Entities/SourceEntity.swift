//
//  SourceEntity.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

import Foundation

struct SourceEntity: Codable {
    var id: String?
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

extension SourceEntity {
    func toDomain() -> SourceModel {
        return SourceModel(id: id,
                           name: name)
    }
}
