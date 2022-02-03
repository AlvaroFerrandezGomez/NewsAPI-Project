//
//  APIClient.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Alamofire
import Foundation

protocol APIClientProtocol {
    func execute<T: BaseAPIRequest>(_ request: T, _ completion: @escaping Response<T.Response>)
}

class NetworkClient: APIClientProtocol {
    func execute<T>(_ request: T, _ completion: @escaping Response<T.Response>) where T: BaseAPIRequest {
        AF.request(request.url).validate().responseData { response in
            guard let data = response.data else {
                let err = NSError(domain: "Data not parsed correctly", code: 404, userInfo: [:])
                completion(.error(err))
                return
            }

            do {
                let parsedResponse = try JSONDecoder().decode(T.Response.self, from: data)
                debugPrint("RESPONSE for: \(request.url) -> \n\(parsedResponse)")
                completion(.success(parsedResponse))
            } catch {
                let err = NSError(domain: "Error decoding data", code: 401, userInfo: [:])
                completion(.error(err))
            }
        }
    }
}
