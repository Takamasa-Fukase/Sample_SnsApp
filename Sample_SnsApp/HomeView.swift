//
//  HomeView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct HomeView: View {
    let colors: [Color] = [.orange, .yellow, .green, .blue, .purple, .pink, .brown]

    var body: some View {
        GeometryReader(content: { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(0..<2, id: \.self) { id in
                        verticalPostList(
                            colors: id == 0 ? colors : colors.reversed(),
                            geometry: geometry
                        )
                    }
                }
            }
            .scrollTargetBehavior(.paging)
        })
    }
    
    func verticalPostList(colors: [Color], geometry: GeometryProxy) -> some View {
        return ScrollView(.vertical) {
            LazyVStack(spacing: 0, content: {
                ForEach(colors, id: \.self) { color in
                    PostDetailView(backgroundColor: color)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                }
            })
        }
        .scrollTargetBehavior(.paging)
    }
}

#Preview {
    HomeView()
}
