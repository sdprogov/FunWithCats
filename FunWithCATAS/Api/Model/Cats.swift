//
//  Cats.swift
//  FunWithCATAS
//
//  Created by Stefan Progovac on 11/14/22.
//

import Foundation

typealias Cats = [Cat]

struct Cat: Decodable {
    var id: String
    var owner: String?
    var createdAt: String
    var updatedAt: String
    var tags: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case owner, createdAt, updatedAt, tags
    }
}
