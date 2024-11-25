//
//  NetworkImageView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 25/11/24.
//

import SwiftUI

struct NetworkImageView: View {
    private let url: String
    private let placeHolderImage: Image
    private let contentMode: ContentMode
    
    @State private var fetchedImage: UIImage?
    
    init(
        url: String,
        placeHolderImage: Image,
        contentMode: ContentMode
    ) {
        self.url = url
        self.placeHolderImage = placeHolderImage
        self.contentMode = contentMode
    }
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .onAppear {
                Task {
                    do {
                        fetchedImage = try await getImage(from: URL(string: url)!)
                        
                    } catch {
                        print("error: \(error)")
                    }
                }
            }
    }
    
    private var image: Image {
        if let fetchedImage = fetchedImage {
            return Image(uiImage: fetchedImage)
        }else {
            return placeHolderImage
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
        placeHolderImage: Image(systemName: "photo"),
        contentMode: .fit
    )
    .frame(width: 200, height: 200)
}
