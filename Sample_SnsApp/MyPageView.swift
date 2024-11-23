//
//  MyPageView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text("ウルトラ深瀬")
                                .font(.system(size: 16, weight: .bold))
                            Text("2024/11/11")
                                .font(.system(size: 12))
                        }
                    }
                    Spacer().frame(height: 8)
                    Text("歌ってみました！\n最初のところのリズム取るの難しすぎワロタ。お手柔らかに宜しくお願い致します！")
                        .font(.system(size: 12))
                    Spacer().frame(height: 8)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray)
        }
        .tint(.clear)
        .navigationTitle("MyPage")
    }
}

#Preview {
    MyPageView()
}
