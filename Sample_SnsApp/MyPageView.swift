//
//  MyPageView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct MyPageView: View {
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
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "envelope.badge")
                                .resizable()
                                .frame(width: 32, height: 24)
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "text.badge.star")
                                .resizable()
                                .frame(width: 28, height: 28)
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "ellipsis.circle")
                                .resizable()
                                .frame(width: 28, height: 28)
                        })
                    }
                }
            })
        }
        .tint(Color(.label))
    }
    
    func profileView() -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading) {
                        Text("ウルトラ深瀬")
                            .font(.system(size: 16, weight: .bold))
                        Text("2024/11/11")
                            .font(.system(size: 12))
                    }
                }
                Spacer().frame(height: 8)
                Text("歌ってみました！\n最初のところのリズム取るの難しすぎワロタ。お手柔らかに宜しくお願い致します！")
                    .font(.system(size: 12))
                Spacer().frame(height: 8)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 16, trailing: 12))
    }
    
    func postListGridView(geometry: GeometryProxy) -> some View {
        //
        let columns = Array(
            repeating: GridItem(
                // 縦方向Gridの場合はこれがグリッドコンテンツの横幅の指定となる
                // MEMO: これとは別に実際のコンテンツでもframeでwidthを指定をするとバグるので指定しないこと
                // そもそもwidthは指定する必要がなくて、指定する場合はこれよりも小さな値にしないと表示がバグる
                .fixed(geometry.size.width / 3 - 10)
            ),
            // 縦方向Gridの場合は、GridItemの数が横方向のコンテンツの数になる
            count: 3
        )
        return LazyVGrid(
            columns: columns,
            // 縦方向のGridに対してのspacingなので縦方向のコンテンツ間の余白
            spacing: 2
        ) {
            ForEach((0..<16), id: \.self) { _ in
                Color(.gray)
                    .frame(
//                        width: geometry.size.width / 3 - 10,
                        height: (geometry.size.width / 3) * 1.78
                    )
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MyPageView()
}
