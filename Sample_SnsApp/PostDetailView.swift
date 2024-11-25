//
//  PostDetailView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(alignment: .bottom) {
                descriptionView
                rightButtonsView
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 4))
            }
            Spacer().frame(height: 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.all, 12)
        .foregroundStyle(.white)
//        .background(
//
//        )
    }
    
    var descriptionView: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text(post.user.name)
                        .font(.system(size: 16, weight: .bold))
                    Text(post.createdAt)
                        .font(.system(size: 12))
                }
            }
            Spacer().frame(height: 8)
//            Text(post.description)
            Text(Array(repeating: post.description, count: 1).joined())
                .font(.system(size: 12))
            Spacer().frame(height: 8)
        }
    }
    
    var rightButtonsView: some View {
        VStack(spacing: 20) {
            rightCountButton(imageName: "heart", count: post.likesCount) {
                
            }
            rightCountButton(imageName: "ellipsis.bubble", count: 0) {
                
            }
            rightCountButton(imageName: "arrowshape.turn.up.right") {
                
            }
            rightCountButton(imageName: "flag") {
                
            }
        }
    }
    
    func rightCountButton(imageName: String, count: Int? = nil, action: @escaping (() -> Void)) -> some View {
        VStack {
            Button(action: {
                action()
            }, label: {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 28, height: 28)
            })
            if let count = count {
                Text("\(count)")
                    .font(.system(size: 12))
            }else {
                Spacer()
                    .frame(height: 12)
            }
        }
    }
}

#Preview {
    PostDetailView(
        post: MockDataSource.posts.first!
    )
}
