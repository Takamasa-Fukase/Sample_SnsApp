//
//  NotificationsView.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 25/11/24.
//

import SwiftUI

struct NotificationsView: View {
    @State private var notifications: [NotificationEntity] = []
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0, content: {
                ForEach(notifications) { notification in
                    listItem(notification: notification)
                }
            })
        }
//        .redacted(reason: notifications.isEmpty ? .placeholder : [])
        .onAppear {
            Task {
                do {
                    try await Task.sleep(nanoseconds: 1500000000)
                    notifications = MockDataSource.notifications
                    
                }catch {
                    print(error)
                }
            }
        }
    }
    
    func listItem(notification: NotificationEntity) -> some View {        
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                // ユーザー詳細への遷移トリガー
                NavigationLink(value: HomeNavigationItem.userProfile(userId: notification.userId)) {
                    NetworkImageView(
                        state: NetworkImageViewState(url: notification.userIconUrl ?? ""),
                        placeHolderView: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        },
                        contentMode: .fill
                    )
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                }
                
                Spacer().frame(width: 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(notification.userName)から\(notification.title)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color(.label))
                    if let message = notification.message {
                        Spacer().frame(height: 4)
                        Text("「\(message)」")
                            .font(.system(size: 18))
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(width: 8)
                
                // 投稿詳細への遷移トリガー
                NavigationLink(value: HomeNavigationItem.postDetail(postId: notification.postId)) {
                    NetworkImageView(
                        state: NetworkImageViewState(url: notification.postImageUrl),
                        placeHolderView: {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        },
                        contentMode: .fill
                    )
                    .frame(width: 30, height: 53)
                    .clipped()
                }
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
            Color(.label)
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .opacity(0.2)
        }
    }
}

#Preview {
    NotificationsView()
}
