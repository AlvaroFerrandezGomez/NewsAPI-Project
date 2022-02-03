//
//  Response.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Foundation

typealias Response<Value> = ((Result<Value, NSError>) -> Void)

enum Result<T, U> {
    case success(T)
    case error(U)
}
