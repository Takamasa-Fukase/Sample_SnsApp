//
//  PostDetailView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct PostDetailView: View {
    private let postId: Int
    @State private var post: Post?
    
    init(
        postId: Int,
        post: Post? = nil
    ) {
        self.postId = postId
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
        .background {
            NetworkImageView(
                url: post?.postImageUrl ?? "",
                placeHolderView: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 160, height: 160)
                },
                contentMode: .fill
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        // postEntityが取得されるまでの間、スケルトン表示をする
        .redacted(reason: post == nil ? .placeholder : [])
        .onAppear {
            Task {
                do {
                    // デバッグ用の遅延処理
                    try await Task.sleep(nanoseconds: 1500000000)
                    
                    // PostEntityが受け渡されている場合（投稿一覧）はそれを表示
                    if let post = post {
                        self.post = post
                    }
                    // PostEntityが受け渡されていない場合はpostIdを使って取得して表示
                    else {
                        guard let post = MockDataSource.posts.first(where: { $0.id == postId }) else { return }
                        self.post = post
                    }
                }catch {
                    print("error: \(error)")
                }
            }
        }
    }
    
    var descriptionView: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text(post?.userName ?? "")
                        .font(.system(size: 16, weight: .bold))
                    Text(post?.createdAt ?? "")
                        .font(.system(size: 12))
                }
            }
            Spacer().frame(height: 8)
            Text(post?.description ?? "")
                .font(.system(size: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame(height: 8)
        }
    }
    
    var rightButtonsView: some View {
        VStack(spacing: 20) {
            rightCountButton(imageName: "heart", count: post?.likesCount ?? 0) {
                
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
    PostDetailView(postId: 0)
}
