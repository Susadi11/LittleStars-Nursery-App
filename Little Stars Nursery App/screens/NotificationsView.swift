//
//  NotificationsView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-01.
//

import SwiftUI

struct NotificationsView: View {
    @Binding var isPresented: Bool

    private let bgColor        = Color(red: 0.97, green: 0.98, blue: 0.98)
    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    var body: some View {
        ZStack(alignment: .top) {
            bgColor.ignoresSafeArea()

            VStack(spacing: 0) {

                HStack(spacing: 14) {
                    Button(action: {
                        isPresented = false
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.91, green: 0.92, blue: 0.93))
                                .frame(width: 38, height: 38)
                            Image(systemName: "chevron.left")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(secondaryColor)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())

                    Text("Notifications")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))

                    Spacer()

                    ZStack(alignment: .topTrailing) {
                        Circle()
                            .fill(Color(red: 0.91, green: 0.92, blue: 0.93))
                            .frame(width: 38, height: 38)
                        Image(systemName: "bell.fill")
                            .font(.system(size: 16))
                            .foregroundColor(secondaryColor)
                            .frame(width: 38, height: 38)

                        Circle()
                            .fill(Color(red: 0.92, green: 0.28, blue: 0.25))
                            .frame(width: 9, height: 9)
                            .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
                            .offset(x: 1, y: 1)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 12)
                .background(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(Array(sampleNotifications.enumerated()), id: \.element.id) { index, notification in
                            NotificationListRow(notification: notification)
                            if index < sampleNotifications.count - 1 {
                                Divider()
                                    .padding(.leading, 78)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 100)
                }
            }
        }
        .transition(.move(edge: .trailing))
    }
}

struct NotificationListRow: View {
    let notification: AppNotification

    var body: some View {
        HStack(alignment: .top, spacing: 14) {

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(notification.type.bgColor)
                    .frame(width: 46, height: 46)
                Image(systemName: notification.type.icon)
                    .font(.system(size: 20))
                    .foregroundColor(notification.type.color)
            }
            .padding(.top, 2)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notification.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
                        .lineLimit(1)
                    Spacer()
                    Text(notification.time)
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.60, green: 0.63, blue: 0.66))
                }

                Text(notification.message)
                    .font(.system(size: 13))
                    .foregroundColor(Color(red: 0.42, green: 0.45, blue: 0.48))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            if notification.isUnread {
                Circle()
                    .fill(Color(red: 0.18, green: 0.77, blue: 0.71))
                    .frame(width: 9, height: 9)
                    .padding(.top, 6)
            } else {
                Spacer().frame(width: 9)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            notification.isUnread
            ? Color(red: 0.96, green: 0.99, blue: 0.99)
            : Color.white
        )
    }
}

#Preview {
    NotificationsView(isPresented: .constant(true))
}
