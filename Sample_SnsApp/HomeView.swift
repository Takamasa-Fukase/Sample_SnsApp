//
//  HomeView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<2, id: \.self) { _ in
                    PostDetailView()
                        .frame(width: UIApplication.shared.screen.bounds.width, height: UIApplication.shared.screen.bounds.height)
                }
            }
        }
        .scrollTargetBehavior(.paging)
    }
}

#Preview {
    HomeView()
}
