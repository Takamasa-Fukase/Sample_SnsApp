//
//  Post.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 25/11/24.
//

import Foundation

struct Post: Identifiable, Hashable {
    let id: Int
    let userId: Int
    let userName: String
    let userIconUrl: String?
    let postImageUrl: String
    let description: String
    let likesCount: Int
    let createdAt: String // TODO: Date型にしたいが一旦急ぎなのでStringにしている
}
