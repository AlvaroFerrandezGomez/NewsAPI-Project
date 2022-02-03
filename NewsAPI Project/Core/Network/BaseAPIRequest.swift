//
//  BaseAPIRequest.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Foundation

protocol BaseAPIRequest: Encodable {
    associatedtype Response: Decodable

    var url: String { get }
}
