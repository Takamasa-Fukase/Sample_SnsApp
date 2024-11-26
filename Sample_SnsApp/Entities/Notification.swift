//
//  Notification.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 25/11/24.
//

import Foundation

struct NotificationEntity: Identifiable, Hashable {
    let id: Int
    let userId: Int
    let userName: String
    let userIconUrl: String?
    let title: String
    let message: String?
    let postImageUrl: String
}
