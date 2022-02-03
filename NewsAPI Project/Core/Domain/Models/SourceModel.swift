//
//  SourceModel.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

import Foundation

final class SourceModel {
    var id: String?
    var name: String?

    internal init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}
