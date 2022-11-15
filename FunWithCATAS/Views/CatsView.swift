//
//  CatsView.swift
//  FunWithCATAS
//
//  Created by Stefan Progovac on 11/14/22.
//

import SDWebImageSwiftUI
import SwiftUI
import SwiftUIPager

struct CatsView: View {
    @State private var page: Int = 0
    @StateObject private var viewModel = CatsViewModel()
    @State private var isFilterViewPresented = false
    @State private var filterTag: String?

    private let fakeUrl = URL(string: "https://www.fake.com")!

    var body: some View {
        NavigationView {
            GeometryReader { _ in
                Pager(page: $page, data: viewModel.imageUrls + [fakeUrl], id: \.absoluteURL) { url in
                    if url != fakeUrl {
                        AnimatedImage(url: url, options: [.progressiveLoad]) // Progressive Load
                            .onFailure { error in
                                print("[Fun with Cats Animated Loading Image Error] : \(error)")
                            }
                            .onSuccess { _, _, _ in
                            }
                            .resizable()
                            .placeholder {
                                Color.purple.opacity(0.1)
                            } // Placeholder Image
                            .indicator(SDWebImageActivityIndicator.whiteLarge) // Activity Indicator
                            .transition(.fade) // Fade Transition
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        ProgressView("Loading more cute cats ...")
                    }
                }
                .itemSpacing(16)
                .vertical()
                .interactive(0.8)
                .alignment(.justified)
                .itemAspectRatio(16 / 9)
                .swipeInteractionArea(.allAvailable)
                .padding()
                .onPageChanged { newPage in
                    guard newPage == viewModel.imageUrls.count - 1 else { return }
                    viewModel.fetchCats()
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarTitle("Cats!", displayMode: .inline)
            .navigationBarItems(trailing: filterButton)
        }
        .sheet(isPresented: $isFilterViewPresented,
               onDismiss: {
                   // TODO: implement filtering
               },
               content: {
                   CatsFilterView()
               })
    }

    private var isFilterSelected: Bool {
        filterTag != nil
    }

    private var filterButton: some View {
        Button(action: { isFilterViewPresented.toggle() }, label: {
            Image(systemName: isFilterSelected ? "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle")
                .resizable()
                .frame(width: 25, height: 25)
                .padding()
                .foregroundColor(.black)
                .font(Font.body.weight(.light))
        })
    }
}

struct CatsView_Previews: PreviewProvider {
    static var previews: some View {
        CatsView()
    }
}
