//
//  NetworkImageView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 25/11/24.
//

import SwiftUI

struct NetworkImageView<PlaceHolderView: View>: View {
    private let url: String
    private let placeHolderView: PlaceHolderView
    private let contentMode: ContentMode
    
    @State private var fetchedImage: UIImage?
    
    init(
        url: String,
        @ViewBuilder placeHolderView: () -> PlaceHolderView,
        contentMode: ContentMode
    ) {
        self.url = url
        self.placeHolderView = placeHolderView()
        self.contentMode = contentMode
    }
    
    var body: some View {
        baseView
            .onAppear {
                Task {
                    do {
                        guard let url = URL(string: url) else { return }
                        self.fetchedImage = try await getImage(from: url)
                        
                    } catch {
                        print("error: \(error)")
                    }
                }
            }
    }
    
    private var baseView: some View {
        // MEMO: 異なる型のビューを返却するためにGroupでまとめている
        return Group {
            if let fetchedImage = fetchedImage {
                Image(uiImage: fetchedImage)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else {
                placeHolderView
            }
        }
    }
    
    private func getImage(from url: URL) async throws -> UIImage {
        let session = URLSession(configuration: .default)
        let (data, _) = try await session.data(from: url)
        return UIImage(data: data) ?? UIImage()
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
