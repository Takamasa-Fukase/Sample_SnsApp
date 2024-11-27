//
//  ContentView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTabIndex: Int = 0
    
    init() {
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().unselectedItemTintColor = .secondaryLabel
    }
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            Group {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: selectedTabIndex == 0 ? "house.fill" : "house")
                            .environment(\.symbolVariants, .none)
                    }
                    .tag(0)
                PostCreateTopView()
                    .tabItem {
                        Label("Create", systemImage: selectedTabIndex == 1 ? "plus.app.fill" : "plus.app")
                            .environment(\.symbolVariants, .none)
                    }
                    .tag(1)
                MyPageView(user: MockDataSource.users.first!)
                    .tabItem {
                        Label("You", systemImage: selectedTabIndex == 2 ? "person.fill" : "person")
                            .environment(\.symbolVariants, .none)
                    }
                    .tag(2)
            }
            // MEMO: SwiftUI専用の新しい下記のAPIを使うべきだが、非選択のTabBarのtintColorを設定するすべがまだ無く、
            // 併用するとUITabBar.appearanceが無効になるので両方設定したい場合は、
            // 現状はまだappearanceを使うしかない模様
//            .toolbarBackground(.background, for: .tabBar)
//            .toolbarBackground(.visible, for: .tabBar)
        }
        // MEMO: UITabBar.appearance().tintColorが機能しないのでこちらを使用する必要がある
        .tint(Color(.label))
    }
}

#Preview {
    ContentView()
}
