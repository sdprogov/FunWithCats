//
//  CatsFilterView.swift
//  FunWithCATAS
//
//  Created by Stefan Progovac on 11/15/22.
//

import SwiftUI

struct CatsFilterView: View {
    @Binding var filterTag: String?
    @State private var selectedTag: String? = nil
    @State private var tagsPage = 0
    @StateObject private var viewModel = CatsFilterViewModel()

    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                List {
                    Section(header: Text("Tags")) {
                        if viewModel.tags.isEmpty {
                            ProgressView("Loading Tags")
                        } else {
                            FlexibleView(
                                availableWidth: proxy.size.width,
                                data: viewModel.tags.filter { $0.count > 0 },
                                spacing: 15,
                                alignment: .leading
                            ) { item in
                                Text(verbatim: item)
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill((selectedTag == item) ? Color.gray.opacity(0.2) : Color.purple.opacity(0.2))
                                    )
                                    .onTapGesture {
                                        selectedTag = item
                                    }
                            }
                            .padding(.horizontal, 2.0)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(.zero))
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle("Filters", displayMode: .inline)
            .navigationBarItems(leading: cancelButton,
                                trailing: saveButton)
        }
    }

    private var cancelButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
            filterTag = nil
        }, label: {
            Text("Clear")
                .padding()
        })
    }

    private var saveButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
            filterTag = selectedTag
        }, label: {
            Text("Save")
                .padding()
        })
    }
}

struct CatsFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CatsFilterView(filterTag: .constant(nil))
    }
}
