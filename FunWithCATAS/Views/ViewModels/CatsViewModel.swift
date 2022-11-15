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
    @Published private var cats: Cats = [] {
        didSet {
            displayableCats = cats
        }
    }

    @Published private var displayableCats: Cats = []
    private let apiClient = APIClient()
    private var skip: Int { cats.count }
    private let limit = 15
    private var bag = Set<AnyCancellable>()
    private var isRequesting = false

    var imageUrls: [URL] {
        displayableCats.compactMap { URL(string: "https://cataas.com/cat/\($0.id)") }
    }

    init() {
        fetchCats()
    }

    func reset() {
        displayableCats = cats
        isRequesting = false
    }

    func filerCats(by tag: String) {
        displayableCats = cats.filter { $0.tags.contains(tag) }
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
