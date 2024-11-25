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
                ScrollViewReader { scrollProxy in
                    ContentFrameTrackableScrollView(
                        scrollDirections: .horizontal,
                        showsIndicator: false,
                        content: {
                            HStack(spacing: 0) {
                                ForEach(0..<2, id: \.self) { id in
                                    verticalPostList(
                                        colors: id == 0 ? colors : colors.reversed(),
                                        geometry: geometry
                                    )
                                    .id(id)
                                }
                            }
                        },
                        onScroll: { contentFrame in
                            topTabButtonAlpha = getTopTabButtonAlpha(frame: contentFrame)
                        }
                    )
                    .scrollTargetBehavior(.paging)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                withAnimation {
                                    scrollProxy.scrollTo(0)
                                }
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
                                withAnimation {
                                    scrollProxy.scrollTo(1)
                                }
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
                                    .frame(width: 28, height: 20)
                            })
                            .padding(.trailing, 8)
                        }
                    }
                }
            })
            .ignoresSafeArea(edges: [.top])
        }
        .tint(Color(.label))
        .onWillAppear {
            let naviBarAppearance = UINavigationBarAppearance()
            naviBarAppearance.configureWithTransparentBackground()
            naviBarAppearance.backgroundColor = .clear
            UINavigationBar.appearance().standardAppearance = naviBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = naviBarAppearance
        }
        .onWillDisappear {
            let naviBarAppearance = UINavigationBarAppearance()
            naviBarAppearance.configureWithOpaqueBackground()
            naviBarAppearance.backgroundColor = .systemBackground
            UINavigationBar.appearance().standardAppearance = naviBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = naviBarAppearance
        }
    }
    
    private func verticalPostList(colors: [Color], geometry: GeometryProxy) -> some View {
        return ScrollView(
            .vertical,
            showsIndicators: false
        ) {
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
    
    private func getTopTabButtonAlpha(frame: CGRect) -> (recommendedButtonAlpha: CGFloat, followingButtonAlpha: CGFloat) {
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
