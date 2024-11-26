//
//  UserProfileView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 26/11/24.
//

import SwiftUI

struct UserProfileView: View {
    private let userId: Int
    @State private var user: User?
    
    init(userId: Int) {
        self.userId = userId
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                profileView()
                postListGridView(geometry: geometry)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            if let user = MockDataSource.users.first(where: { $0.id == userId }) {
                self.user = user
            }
        }
    }
    
    func profileView() -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    NetworkImageView(
                        url: user?.iconUrl ?? "",
                        placeHolderView: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        },
                        contentMode: .fill
                    )
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(user?.name ?? "")
                            .font(.system(size: 16, weight: .bold))
                    }
                }
                Spacer().frame(height: 8)
                Text(user?.description ?? "")
                    .font(.system(size: 12))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 8)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 4, trailing: 12))
    }
    
    func postListGridView(geometry: GeometryProxy) -> some View {
        let columns = Array(
            repeating: GridItem(
                // 縦方向Gridの場合はこれがグリッドコンテンツの横幅の指定となる
                // MEMO: 実際のコンテンツのwidthは指定する必要がなくて、
                // 指定する場合はこれよりも小さな値にしないと表示がバグる
                .fixed(
                    // 3個並べるので2回余白が入る（2 x 2 = 4）が、
                    // 一番右側のコンテンツが4px右側に見切れてしまうのでその分を差し引く
                    geometry.size.width / 3 - (4 / 3)
                ),
                // 横方向のコンテンツ間の余白
                spacing: 2
            ),
            // 縦方向Gridの場合は、GridItemの数が横方向のコンテンツの数になる
            count: 3
        )
        return LazyVGrid(
            columns: columns,
            alignment: .leading,
            // 縦方向のGridに対してのspacingなので縦方向のコンテンツ間の余白
            spacing: 2
        ) {
            ForEach((0..<16), id: \.self) { _ in
                Text("hoge")
                    .frame(
                        height: (geometry.size.width / 3) * 1.78
                    )
                    .frame(maxWidth: .infinity)
                    .background(.gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    UserProfileView(userId: 0)
}
