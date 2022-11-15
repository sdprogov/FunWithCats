//
//  APIClient.swift
//  FunWithCATAS
//
//  Created by Stefan Progovac on 11/14/22.
//

import Combine
import Foundation

class APIClient {
    var error: FailureReason?

    enum FailureReason: Error {
        case sessionFailed(error: URLError)
        case decodingFailed
        case other(Error)
    }

    func send<Element: Decodable>(_ endpoint: APIClient.Endpoint) -> AnyPublisher<[Element], Never> {
        URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .map { $0.data }
            .decode(type: [Element].self, decoder: JSONDecoder())
            .catch { error in
                print("[FunWithCats API error] - \(error)")
                switch error {
                case is Swift.DecodingError:
                    self.error = FailureReason.decodingFailed
                case let urlError as URLError:
                    self.error = FailureReason.sessionFailed(error: urlError)
                default:
                    self.error = FailureReason.other(error)
                }
                return Just<[Element]>([]).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
