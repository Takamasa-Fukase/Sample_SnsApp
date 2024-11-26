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
        .onAppear {
            notifications = MockDataSource.notifications
        }
    }
    
    func listItem(notification: NotificationEntity) -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                NavigationLink(value: HomeNavigationItem.userProfile(notification.user)) {
                    NetworkImageView(
                        url: notification.user.iconUrl,
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
                    Text("\(notification.user.name)から\(notification.title)")
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
                NetworkImageView(
                    url: notification.user.iconUrl,
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
