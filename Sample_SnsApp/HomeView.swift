//
//  HomeView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct HomeView: View {
    let recommendedPosts: [Post]
    let followingPosts: [Post]
    @State private var topTabButtonAlpha: (recommendedButtonAlpha: CGFloat, followingButtonAlpha: CGFloat) = (0.0, 0.0)
    
    init(
        recommendedPosts: [Post], 
        followingPosts: [Post]
    ) {
        self.recommendedPosts = recommendedPosts
        self.followingPosts = followingPosts
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader(content: { geometry in
                ScrollViewReader { scrollProxy in
                    ContentFrameTrackableScrollView(
                        scrollDirections: .horizontal,
                        showsIndicator: false,
                        content: {
                            HStack(spacing: 0) {
                                ForEach(Array([recommendedPosts, followingPosts].enumerated()), id: \.offset) { index, posts in
                                    verticalPostList(
                                        posts: posts,
                                        geometry: geometry
                                    )
                                    .id(index)
                                }
                            }
                        },
                        onScroll: { contentFrame in
                            topTabButtonAlpha = getTopTabButtonAlpha(frame: contentFrame)
                        }
                    )
                    .scrollTargetBehavior(.paging)
                    .toolbar {
                        toolBarContent(
                            onTapRecommenedButton: {
                                withAnimation {
                                    scrollProxy.scrollTo(0)
                                }
                            },
                            onTapFollowingButton: {
                                withAnimation {
                                    scrollProxy.scrollTo(1)
                                }
                            },
                            onTapMailIcon: {
                                
                            }
                        )
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
    
    @ToolbarContentBuilder
    private func toolBarContent(
        onTapRecommenedButton: @escaping (() -> Void),
        onTapFollowingButton: @escaping (() -> Void),
        onTapMailIcon: @escaping (() -> Void)
    ) -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: onTapRecommenedButton, label: {
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
            Button(action: onTapFollowingButton, label: {
                Text("フォロー中")
                    .font(.system(size: 14, weight: .medium))
            })
            .frame(width: 92, height: 32)
            .background(.white.opacity(topTabButtonAlpha.followingButtonAlpha))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: onTapMailIcon, label: {
                Image(systemName: "envelope")
                    .resizable()
                    .frame(width: 28, height: 20)
            })
            .padding(.trailing, 8)
        }
    }
    
    private func verticalPostList(posts: [Post], geometry: GeometryProxy) -> some View {
        return ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            LazyVStack(spacing: 0, content: {
                ForEach(posts, id: \.self) { post in
                    PostDetailView(post: post)
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
    HomeView(recommendedPosts: MockDataSource.posts, followingPosts: MockDataSource.posts.reversed())
}
