//
//  Post.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 25/11/24.
//

import Foundation

struct Post: Identifiable {
    let id: Int
    let userId: Int
    let user: User
    let postImageUrl: String
    let description: String
    let likesCount: Int
    let createdAt: String // TODO: Date型にしたいが一旦急ぎなのでStringにしている
}
