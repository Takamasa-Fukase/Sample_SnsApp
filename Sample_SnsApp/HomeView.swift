//
//  HomeView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct HomeView: View {
    private let colors: [Color] = [.orange, .yellow, .green, .blue, .purple, .pink, .brown]
    @State private var topTabButtonAlpha: (recommendedButtonAlpha: CGFloat, followingButtonAlpha: CGFloat) = (0.0, 0.0)
    
    var body: some View {
        NavigationStack {
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
                    .background {
                        GeometryReader { geometry in
                            Color.clear.onChange(of: geometry.frame(in: .global)) { _, newFrame in
                                topTabButtonAlpha = topTabButtonAlpha(frame: newFrame)
                            }
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            
                        }, label: {
                            Text("おすすめ")
                                .font(.system(size: 14, weight: .medium))
                        })
                        .frame(width: 84, height: 32)
                        .background(.white.opacity(topTabButtonAlpha.recommendedButtonAlpha))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Spacer().frame(width: 0)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            
                        }, label: {
                            Text("フォロー中")
                                .font(.system(size: 14, weight: .medium))
                        })
                        .frame(width: 92, height: 32)
                        .background(.white.opacity(topTabButtonAlpha.followingButtonAlpha))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "envelope")
                                .resizable()
                                .frame(width: 32, height: 24)
                        })
                        .padding(.trailing, 8)
                    }
                }
            })
            .ignoresSafeArea(edges: [.top])
        }
        .tint(Color(.label))
    }
    
    private func verticalPostList(colors: [Color], geometry: GeometryProxy) -> some View {
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
    
    private func topTabButtonAlpha(frame: CGRect) -> (recommendedButtonAlpha: CGFloat, followingButtonAlpha: CGFloat) {
        let scrollProgress = frame.minX / (frame.width / 2)
        let maxButtonColorAlpha = 0.3
        let recommendedButtonAlpha = -(-1 - scrollProgress) * maxButtonColorAlpha
        let followingButtonAlpha = -(scrollProgress * maxButtonColorAlpha)
        return (recommendedButtonAlpha: recommendedButtonAlpha, followingButtonAlpha: followingButtonAlpha)
    }
}

#Preview {
    HomeView()
}
