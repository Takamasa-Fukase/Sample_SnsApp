//
//  User.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 25/11/24.
//

import Foundation

struct User: Identifiable, Hashable {
    let id: Int
    let name: String
    let iconUrl: String
    let description: String
}
