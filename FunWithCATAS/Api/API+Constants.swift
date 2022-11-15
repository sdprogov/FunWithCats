//
//  API+Constants.swift
//  FunWithCATAS
//
//  Created by Stefan Progovac on 11/14/22.
//

import Foundation

extension APIClient {
    private enum ImageSize: String {
        case original = "or"
        case small = "sm"
        case medium = "md"
        case square = "sq"
    }

    enum Endpoint {
        private enum Params {
            static let limit = "limit"
            static let skip = "skip"
            static let size = "size"
        }

        var host: String { "https://cataas.com" }

        case cats(skip: Int, limit: Int)
        case tags

        var path: String {
            switch self {
            case .cats:
                return "/api/cats"
            case .tags:
                return "/api/tags"
            }
        }

        var params: [URLQueryItem] {
            switch self {
            case let .cats(skip, limit):
                return [
                    URLQueryItem(name: Params.skip, value: "\(skip)"),
                    URLQueryItem(name: Params.limit, value: "\(limit)"),
                ]
            case .tags:
                return []
            }
        }

        var urlRequest: URLRequest {
            var urlComponents = URLComponents(string: host + path)!
            urlComponents.queryItems = params
            let request = URLRequest(url: urlComponents.url!)
            return request
        }
    }
}
