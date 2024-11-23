//
//  PostDetailView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 23/11/24.
//

import SwiftUI

struct PostDetailView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                descriptionView
                rightButtonsView
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 4))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.all, 12)
        .foregroundStyle(.white)
        .background(Color(.blue))
    }
    
    var descriptionView: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
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
    }
    
    var rightButtonsView: some View {
        VStack(spacing: 20) {
            rightCountButton(imageName: "heart", count: 16) {
                
            }
            rightCountButton(imageName: "ellipsis.bubble", count: 19) {
                
            }
            rightCountButton(imageName: "arrowshape.turn.up.right") {
                
            }
            rightCountButton(imageName: "flag") {
                
            }
        }
    }
    
    func rightCountButton(imageName: String, count: Int? = nil, action: @escaping (() -> Void)) -> some View {
        VStack {
            Button(action: {
                action()
            }, label: {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 28, height: 28)
            })
            if let count = count {
                Text("\(count)")
                    .font(.system(size: 12))
            }else {
                Spacer()
                    .frame(height: 12)
            }
        }
    }
}

#Preview {
    PostDetailView()
}
