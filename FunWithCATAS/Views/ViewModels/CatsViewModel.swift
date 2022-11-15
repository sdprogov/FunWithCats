//
//  CatsViewModel.swift
//  FunWithCATAS
//
//  Created by Stefan Progovac on 11/14/22.
//

import Combine
import Foundation
import SwiftUI

class CatsViewModel: ObservableObject {
    @Published private var cats: Cats = []
    private let apiClient = APIClient()
    private var skip: Int { cats.count }
    private let limit = 15
    private var bag = Set<AnyCancellable>()
    private var isRequesting = false

    var imageUrls: [URL] {
        cats.compactMap { URL(string: "https://cataas.com/cat/\($0.id)") }
    }

    init() {
        fetchCats()
    }

    func reset() {
        cats = []
        isRequesting = false
    }

    func fetchCats() {
        guard !isRequesting else { return }
        isRequesting = true
        let cancellable = apiClient
            .send(.cats(skip: skip, limit: limit))
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [unowned self] _ in
                self.isRequesting = false
            })
            .map { [unowned self] in
                self.cats + $0
            }
            .assign(to: \.cats, on: self)
        bag.insert(cancellable)
    }
}
