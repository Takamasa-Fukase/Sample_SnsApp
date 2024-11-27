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
        Task {
            do {
                guard let url = URL(string: url) else { return }
                let image = try await getImage(from: url)
                
                // UIの更新を発火させるpublishingのみメインスレッドで実行
                // MEMO: この書き方をすれば、わざわざ個別のメソッドに切り出してMainActorを付与しなくて済む
                await MainActor.run {
                    self.fetchedImage = image
                }
                
            } catch {
                print("error: \(error)")
            }
        }
    }
    
    private func getImage(from url: URL) async throws -> UIImage {
        let session = URLSession(configuration: .default)
        let (data, _) = try await session.data(from: url)
        return UIImage(data: data) ?? UIImage()
    }
}

struct NetworkImageView<PlaceHolderView: View>: View {
    @ObservedObject private var state: NetworkImageViewState
    private let placeHolderView: PlaceHolderView
    private let contentMode: ContentMode
        
    init(
        state: NetworkImageViewState = .init(url: ""),
        @ViewBuilder placeHolderView: () -> PlaceHolderView,
        contentMode: ContentMode
    ) {
        self.state = state
        self.placeHolderView = placeHolderView()
        self.contentMode = contentMode
    }
    
    var body: some View {
        baseView
    }
    
    private var baseView: some View {
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
        state: NetworkImageViewState(url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsV6BmIOP3qg5IyYOGuiRvYrnIq3Ksd946zw&s"),
        placeHolderView: {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        },
        contentMode: .fit
    )
    .frame(width: 200, height: 200)
}
