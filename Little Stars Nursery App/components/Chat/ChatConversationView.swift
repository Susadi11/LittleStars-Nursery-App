//
//  ChatConversationView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-04.
//
import SwiftUI

struct ChatConversationView: View {
    let person: MessagesStructure

    @State private var messageText = ""
    @State private var messages    = sampleMessages
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ChatHeader(onBack: { dismiss() })

            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        DateSeparator(label: "TODAY")
                            .padding(.top, 14)
                            .padding(.bottom, 10)

                        VStack(spacing: 6) {
                            ForEach(messages) { msg in
                                ChatBubble(message: msg)
                                    .id(msg.id)
                            }
                            Color.clear.frame(height: 1).id("bottom")
                        }
                        .padding(.horizontal, 14)
                        .padding(.bottom, 16)
                    }
                }
                .background(Color.Theme.background)
                .onAppear {
                    proxy.scrollTo("bottom", anchor: .bottom)
                }
            }

            ChatBottom(messageText: $messageText, onSend: sendMessage)
        }
        .background(Color.Theme.background.ignoresSafeArea())
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }

    func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newMsg = ChatMessage(text: messageText, time: "Now", isFromMe: true)
        withAnimation { messages.append(newMsg) }
        messageText = ""
    }
}

struct DateSeparator: View {
    let label: String

    var body: some View {
        HStack {
            Spacer()
            Text(label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color.Theme.labelSubtitle)
                .kerning(1.2)
                .padding(.horizontal, 18)
                .padding(.vertical, 6)
                .background(Color.Theme.iconBg)
                .cornerRadius(20)
            Spacer()
        }
    }
}


#Preview {
    ChatConversationView(person: MessagesStructure(
        name: "Ayesha (Teacher)",
        timestamp: "9:00 AM",
        messageSummary: "Liam had a great morning at nursery today!",
        isUnread: true,
        unreadCount: 2,
        avatar: "image1"
    ))
}
