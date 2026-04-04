//
//  ChatView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-28.
//
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
    private let bgColor = Color(red: 0.97, green: 0.98, blue: 0.98)
    private let teal    = Color(red: 0.18, green: 0.70, blue: 0.65)

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
                bgColor.ignoresSafeArea()

                VStack(spacing: 0) {

                    AppHeaderView()

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(messages) { item in
                                NavigationLink(destination: ChatConversationView(person: item)) {
                                    VStack(spacing: 0) {
                                        HStack(alignment: .center, spacing: 12) {

                                            Image(item.avatar)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 52, height: 52)
                                                .clipShape(Circle())

                                            VStack(alignment: .leading, spacing: 3) {
                                                Text(item.name)
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(.primary)

                                                Text(item.messageSummary)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.gray)
                                                    .lineLimit(1)
                                            }

                                            Spacer()

                                            VStack(alignment: .trailing, spacing: 5) {
                                                Text(item.timestamp)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(item.isUnread ? teal : .gray)

                                                if item.unreadCount > 0 {
                                                    ZStack {
                                                        Circle()
                                                            .fill(teal)
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
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ChatView()
}
