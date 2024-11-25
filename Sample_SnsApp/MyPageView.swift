//
//  MyPageView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct MyPageView: View {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader(content: { geometry in
                ScrollView(.vertical) {
                    profileView()
                    postListGridView(geometry: geometry)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    toolBarContent(
                        onTapMailIcon: {
                            
                        },
                        onTapMyListIcon: {
                            
                        },
                        onTapSettingsIcon: {
                            
                        }
                    )
                }
            })
        }
        .tint(Color(.label))
        .onWillAppear {
            let naviBarAppearance = UINavigationBarAppearance()
            naviBarAppearance.configureWithTransparentBackground()
            naviBarAppearance.backgroundColor = .systemBackground
            UINavigationBar.appearance().standardAppearance = naviBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = naviBarAppearance
        }
    }
    
    @ToolbarContentBuilder
    private func toolBarContent(
        onTapMailIcon: @escaping (() -> Void),
        onTapMyListIcon: @escaping (() -> Void),
        onTapSettingsIcon: @escaping (() -> Void)
    ) -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: onTapMailIcon, label: {
                Image(systemName: "envelope")
                    .resizable()
                    .frame(width: 28, height: 20)
            })
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: onTapMyListIcon, label: {
                Image(systemName: "text.badge.star")
                    .resizable()
                    .frame(width: 28, height: 24)
            })
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: onTapSettingsIcon, label: {
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .frame(width: 28, height: 28)
            })
        }
    }
    
    func profileView() -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
                Spacer().frame(height: 8)
                Text(user.description)
                    .font(.system(size: 12))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 8)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 4, trailing: 12))
    }
    
    func postListGridView(geometry: GeometryProxy) -> some View {
        //
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
    MyPageView(
        user: MockDataSource.users.first!
    )
}
