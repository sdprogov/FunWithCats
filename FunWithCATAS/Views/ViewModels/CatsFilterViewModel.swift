//
//  CatsFilterViewModel.swift
//  FunWithCATAS
//
//  Created by Stefan Progovac on 11/15/22.
//

import Combine
import SwiftUI

class CatsFilterViewModel: ObservableObject {
    @Published var tags: [String] = [] {
        didSet {
            print(tags)
        }
    }

    private var bag = Set<AnyCancellable>()

    private let apiClient = APIClient()

    init() {
        fetchTags()
    }

    private func fetchTags() {
        let cancellable = apiClient
            .send(.tags)
            .receive(on: DispatchQueue.main)
            .assign(to: \.tags, on: self)
        bag.insert(cancellable)
    }
}
