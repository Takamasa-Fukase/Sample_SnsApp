//
//  MockDataSource.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 25/11/24.
//

import Foundation

struct MockDataSource {
    static let users: [User] = [
        .init(
            id: 0,
            name: "関崎ナポリタン",
            iconUrl: "https://cdn.macaro-ni.jp/image/summary/32/32145/d642febe8bc7c7d31cc0b002ae327473.jpg?p=1x1",
            description: "名前はナポリタンですがローマ料理の方が好きです"
        ),
        .init(
            id: 1,
            name: "カルボナーラ伊藤",
            iconUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC74P5Y1lSq0q-38xX-TB6CzhX_79CAEyP3A&s",
            description: "キャルぼ〜〜〜ふう〜〜\nよろぴこ"
        ),
        .init(
            id: 2,
            name: "カプレーゼマン",
            iconUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsV6BmIOP3qg5IyYOGuiRvYrnIq3Ksd946zw&s",
            description: "よろしく〜"
        ),
        .init(
            id: 3,
            name: "マルゲリータ部長",
            iconUrl: "https://pizzeria-lorca.net/_img/ja/article/1603/image/770_510_2_ffffff//",
            description: "やっぱシンプルがいいね！"
        )
    ]
    
    static let posts: [Post] = [
        .init(
            id: 0,
            userId: 0,
            userName: "関崎ナポリタン",
            userIconUrl: "https://cdn.macaro-ni.jp/image/summary/32/32145/d642febe8bc7c7d31cc0b002ae327473.jpg?p=1x1",
            postImageUrl: "https://s.widget-club.com/images/YyiR86zpwIMIfrCZoSs4ulVD9RF3/ae24314c9ca1372d388ab649f8429351/72c38d965cab91c079ddb83c8a8aa3ff.jpg?q=70&w=500",
            description: "初投稿です！宜しくお願い致します！初投稿です！宜しくお願い致します！初投稿です！宜しくお願い致します！初投稿です！宜しくお願い致します！",
            likesCount: 26,
            createdAt: "2024/11/25"
        ),
        .init(
            id: 1,
            userId: 1,
            userName: "カルボナーラ伊藤",
            userIconUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC74P5Y1lSq0q-38xX-TB6CzhX_79CAEyP3A&s",
            postImageUrl: "https://i.pinimg.com/736x/d7/8a/dc/d78adc6804229bcb7ddf742dba06d205.jpg",
            description: "説明文〜",
            likesCount: 722,
            createdAt: "2024/11/11"
        ),
        .init(
            id: 2,
            userId: 2,
            userName: "カプレーゼマン",
            userIconUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsV6BmIOP3qg5IyYOGuiRvYrnIq3Ksd946zw&s",
            postImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSCnYDQ9GXyZiTZimdUyjWoL1Pkw2jpDJ_hCAkeGona66yNKeAVmHxiEGOayUZCjkxj6o&usqp=CAU",
            description: "ピザ食べたい🍕\nパスタもいいね",
            likesCount: 992,
            createdAt: "2024/11/25"
        ),
        .init(
            id: 3,
            userId: 3,
            userName: "マルゲリータ部長",
            userIconUrl: "https://pizzeria-lorca.net/_img/ja/article/1603/image/770_510_2_ffffff//",
            postImageUrl: "https://m.media-amazon.com/images/I/81Pa+Z11R1L._CR350,10,540,960_SY854_CR0,50,480,800_.jpg",
            description: "イタリアまた行きたいです〜",
            likesCount: 2,
            createdAt: "2024/11/25"
        )
    ]
    
    static let notifications: [NotificationEntity] = Array(0..<15).map { index in
        var userId: Int = 0
        var userName = ""
        var userIconUrl = ""
        var postId: Int = 0
        var postImageUrl = ""
        
        switch index % 4 {
        case 0:
            userId = MockDataSource.users[0].id
            userName = MockDataSource.users[0].name
            userIconUrl = MockDataSource.users[0].iconUrl
            postId = MockDataSource.posts[0].id
            postImageUrl = MockDataSource.posts[0].postImageUrl
        case 1:
            userId = MockDataSource.users[1].id
            userName = MockDataSource.users[1].name
            userIconUrl = MockDataSource.users[1].iconUrl
            postId = MockDataSource.posts[1].id
            postImageUrl = MockDataSource.posts[1].postImageUrl
        case 2:
            userId = MockDataSource.users[2].id
            userName = MockDataSource.users[2].name
            userIconUrl = MockDataSource.users[2].iconUrl
            postId = MockDataSource.posts[2].id
            postImageUrl = MockDataSource.posts[2].postImageUrl
        case 3:
            userId = MockDataSource.users[3].id
            userName = MockDataSource.users[3].name
            userIconUrl = MockDataSource.users[3].iconUrl
            postId = MockDataSource.posts[3].id
            postImageUrl = MockDataSource.posts[3].postImageUrl
        default:
            userId = MockDataSource.users[0].id
            userName = MockDataSource.users[0].name
            userIconUrl = MockDataSource.users[0].iconUrl
            postId = MockDataSource.posts[0].id
            postImageUrl = MockDataSource.posts[0].postImageUrl
        }
        return .init(
            id: index,
            userId: userId,
            userName: userName,
            userIconUrl: userIconUrl,
            title: "コメントをもらいました",
            message: "いいですね！！！",
            postId: postId,
            postImageUrl: postImageUrl
        )
    }
}
