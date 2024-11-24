//
//  PostCreateTopView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 24/11/24.
//

import SwiftUI

struct PostCreateTopView: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                Button(action: {
                    
                }, label: {
                    ZStack(alignment: .center) {
                        VStack(spacing: 0) {
                            Image(systemName: "film")
                                .resizable()
                                .frame(width: 48, height: 48)
                            Spacer().frame(height: 24)
                            Text("投稿を作成")
                                .font(.system(size: 20, weight: .semibold))
                            Spacer().frame(height: 16)
                            Text("投稿を作成して、みんなと共有しましょう。動画や写真を組み合わせることもできます。")
                                .font(.system(size: 14))
                                .padding([.leading, .trailing], 32)
                        }
                        .frame(
                            width: geometry.size.width - 64,
                            height: 200
                        )
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                })
            }
        }
        .tint(Color(.label))
    }
}

#Preview {
    PostCreateTopView()
}
