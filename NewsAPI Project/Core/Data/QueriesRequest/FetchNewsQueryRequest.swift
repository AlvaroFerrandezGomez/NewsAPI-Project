//
//  FetchNewsQueryRequest.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

import Foundation

struct FetchNewsQueryRequest: BaseAPIRequest {
    typealias Response = NewsEntity

    var url: String {
        return Endpoints.fetch_news
    }

    init() {}
}
