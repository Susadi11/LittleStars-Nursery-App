//
//  ChatView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-28.
//
import SwiftUI

struct MessagesStructure: Identifiable {
    let id = UUID()
    var name: String
    var timestamp: String
    var messageSummary: String
    var isUnread: Bool
    var unreadCount: Int
    var avatar: String
}

struct ChatView: View {
    let messages: [MessagesStructure] = [
        MessagesStructure(
            name: "Ayesha (KeyWorker)",
            timestamp: "9:00 AM",
            messageSummary: "Nethan had a great morning at nursery today!",
            isUnread: true,
            unreadCount: 2,
            avatar: "keyworker"
        ),
        MessagesStructure(
            name: "Admin Office",
            timestamp: "8:30 AM",
            messageSummary: "Reminder: school trip is scheduled for tomorrow.",
            isUnread: false,
            unreadCount: 0,
            avatar: "keyworker"
        )
    ]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.Theme.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    AppHeaderView()

                    ScrollView(showsIndicators: false) {
                        if messages.isEmpty {
                            ChatEmptyState()
                                .padding(.horizontal, 16)
                                .padding(.top, 16)
                        } else {
                            VStack(spacing: 0) {
                                ForEach(messages) { item in
                                    NavigationLink(destination: ChatConversationView(person: item)) {
                                        VStack(spacing: 0) {
                                            HStack(alignment: .center, spacing: 12) {

                                                if UIImage(named: item.avatar) != nil {
                                                    Image(item.avatar)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 52, height: 52)
                                                        .clipShape(Circle())
                                                } else {
                                                    Circle()
                                                        .fill(Color.Theme.primary.opacity(0.18))
                                                        .frame(width: 52, height: 52)
                                                        .overlay(
                                                            Text(String(item.name.prefix(1)))
                                                                .font(.system(size: 20, weight: .bold))
                                                                .foregroundColor(Color.Theme.secondary)
                                                        )
                                                }

                                                VStack(alignment: .leading, spacing: 3) {
                                                    Text(item.name)
                                                        .font(.system(size: 16, weight: .semibold))
                                                        .foregroundColor(.primary)

                                                    Text(item.messageSummary.isEmpty ? "No messages yet" : item.messageSummary)
                                                        .font(.system(size: 14))
                                                        .foregroundColor(.gray)
                                                        .lineLimit(1)
                                                }

                                                Spacer()

                                                VStack(alignment: .trailing, spacing: 5) {
                                                    Text(item.timestamp)
                                                        .font(.system(size: 12))
                                                        .foregroundColor(item.isUnread ? Color.Theme.primary : .gray)

                                                    if item.unreadCount > 0 {
                                                        ZStack {
                                                            Circle()
                                                                .fill(Color.Theme.primary)
                                                                .frame(width: 20, height: 20)
                                                            Text("\(item.unreadCount)")
                                                                .font(.system(size: 11, weight: .bold))
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 12)

                                            Divider()
                                                .padding(.leading, 80)
                                        }
                                        .background(Color.white)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ChatEmptyState: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 48))
                .foregroundColor(Color.Theme.primary.opacity(0.5))
            Text("No Conversations Yet")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color.Theme.labelPrimary)
            Text("Your messages from Nethan's keyworker and nursery admin will appear here.")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    ChatView()
}
