//
//  CatsFilterView.swift
//  FunWithCATAS
//
//  Created by Stefan Progovac on 11/15/22.
//

import SwiftUI

struct CatsFilterView: View {
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
                                            .fill(Color.purple.opacity(0.2))
                                    )
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
        }, label: {
            Text("Cancel")
                .padding()
        })
    }

    private var saveButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Save")
                .padding()
        })
    }
}

struct CatsFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CatsFilterView()
    }
}
