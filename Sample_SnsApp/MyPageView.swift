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
}

#Preview {
    MyPageView(
        user: MockDataSource.users.first!
    )
}
