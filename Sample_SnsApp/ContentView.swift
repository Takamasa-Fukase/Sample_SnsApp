//
//  ContentView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().unselectedItemTintColor = .secondaryLabel
    }
    
    var body: some View {
        TabView {
            Group {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                MyPageView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("You")
                    }
                    .tint(.green)
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
