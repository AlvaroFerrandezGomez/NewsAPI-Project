//
//  Endpoints.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Foundation

enum Endpoints {
    public static var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "API_KEY", ofType: "plist") else {
            fatalError("Couldn't find file 'API_KEY.plist'.")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'API_KEY.plist'.")
        }
        return value
    }

    static let fetch_news: String = "https://newsapi.org/v2/top-headlines?country=mx&apiKey=\(apiKey)"
}
