//
//  NetworkImageView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 25/11/24.
//

import SwiftUI

final class NetworkImageViewState: ObservableObject {
    @Published var fetchedImage: UIImage?
    
    init(url: String) {
        print("state.init url: \(url)")
        fetch(url: url)
    }
    
    private func getImage(from url: URL) async throws -> UIImage {
        let session = URLSession(configuration: .default)
        let (data, _) = try await session.data(from: url)
        return UIImage(data: data) ?? UIImage()
    }
    
    private func fetch(url: String) {
        print("fetch: \(url)")
        Task { @MainActor in
            do {
                guard let url = URL(string: url) else { return }
                let image = try await getImage(from: url)
                print("取得した: \(image)")
                DispatchQueue.main.async {
                    self.fetchedImage = image
                    print("代入した: \(self.fetchedImage)")
                }
                
            } catch {
                print("error: \(error)")
            }
        }
    }
}

struct NetworkImageView<PlaceHolderView: View>: View {
    @ObservedObject private var state: NetworkImageViewState
    
    private let url: String
    private let placeHolderView: PlaceHolderView
    private let contentMode: ContentMode
    
//    @State private var fetchedImage: UIImage?
    
    init(
        state: NetworkImageViewState = .init(url: ""),
        url: String,
        @ViewBuilder placeHolderView: () -> PlaceHolderView,
        contentMode: ContentMode
    ) {
        self.state = state
        self.url = url
        self.placeHolderView = placeHolderView()
        self.contentMode = contentMode
    }
    
    var body: some View {
        baseView
    }
    
    private var baseView: some View {
        print("baseView fetchedImage: \(state.fetchedImage)")
        // MEMO: 異なる型のビューを返却するためにGroupでまとめている
        return Group {
            if let fetchedImage = state.fetchedImage {
                Image(uiImage: fetchedImage)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else {
                placeHolderView
            }
        }
    }
}

#Preview {
    NetworkImageView(
        url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsV6BmIOP3qg5IyYOGuiRvYrnIq3Ksd946zw&s",
        placeHolderView: {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        },
        contentMode: .fit
    )
    .frame(width: 200, height: 200)
}
