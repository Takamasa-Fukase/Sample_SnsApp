//
//  ContentView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("You")
                }
        }
    }
}

#Preview {
    ContentView()
}
