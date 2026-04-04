//
//  ChatConversationView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-04.
//
import SwiftUI

struct ChatConversationView: View {
    let person: MessagesStructure
    private let bgColor = Color(red: 0.96, green: 0.97, blue: 0.97)

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

                            HStack(alignment: .center, spacing: 6) {
                                TypingIndicator()
                                Spacer()
                            }
                            .padding(.leading, 14)
                            .padding(.top, 6)
                            .id("bottom")
                        }
                        .padding(.horizontal, 14)
                        .padding(.bottom, 16)
                    }
                }
                .background(bgColor)
                .onAppear {
                    proxy.scrollTo("bottom", anchor: .bottom)
                }
            }

            ChatBottom(messageText: $messageText, onSend: sendMessage)
        }
        .background(bgColor.ignoresSafeArea())
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
                .foregroundColor(Color(red: 0.50, green: 0.54, blue: 0.58))
                .kerning(1.2)
                .padding(.horizontal, 18)
                .padding(.vertical, 6)
                .background(Color(red: 0.90, green: 0.92, blue: 0.93))
                .cornerRadius(20)
            Spacer()
        }
    }
}

struct TypingIndicator: View {
    private let primaryColor = Color(red: 0.18, green: 0.77, blue: 0.71)
    @State private var animate = false

    var body: some View {
        HStack(spacing: 6) {
            HStack(spacing: 4) {
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .fill(primaryColor.opacity(0.6))
                        .frame(width: 7, height: 7)
                        .offset(y: animate ? -4 : 0)
                        .animation(
                            .easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(Double(i) * 0.15),
                            value: animate
                        )
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
            .onAppear { animate = true }

            Text("Ayesha is typing...")
                .font(.system(size: 12))
                .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.65))
        }
    }
}

#Preview {
    ChatConversationView(person: MessagesStructure(
        name: "Sarah (Teacher)",
        timestamp: "9:00 AM",
        messageSummary: "Liam had a great morning at nursery today!",
        isUnread: true,
        unreadCount: 2,
        avatar: "image1"
    ))
}
