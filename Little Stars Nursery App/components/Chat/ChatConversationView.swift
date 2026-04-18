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
    @State private var messages = sampleMessages
    @Environment(\.dismiss) private var dismiss

    private var draftKey: String { "draft_\(person.name)" }

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

                            HStack {
                                TypingIndicator()
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                                    .cornerRadius(16)
                                    .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
                                Spacer()
                            }
                            .padding(.leading, 14)
                            .padding(.top, 4)

                            Color.clear.frame(height: 1).id("bottom")
                        }
                        .padding(.horizontal, 14)
                        .padding(.bottom, 16)
                    }
                }
                .background(Color.Theme.background)
                .onAppear {
                    messageText = UserDefaults.standard.string(forKey: draftKey) ?? ""
                    proxy.scrollTo("bottom", anchor: .bottom)
                }
            }

            ChatBottom(messageText: $messageText, onSend: sendMessage)
                .onChange(of: messageText) { draft in
                    UserDefaults.standard.set(draft, forKey: draftKey)
                }
        }
        .background(Color.Theme.background.ignoresSafeArea())
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }

    func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newMsg = ChatMessage(text: messageText, time: formattedTime(), isFromMe: true)
        withAnimation { messages.append(newMsg) }
        messageText = ""
        UserDefaults.standard.removeObject(forKey: draftKey)
    }

    private func formattedTime() -> String {
        let f = DateFormatter()
        f.dateFormat = "h:mm a"
        return f.string(from: Date())
    }
}

struct TypingIndicator: View {
    @State private var animate = false

    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .fill(Color.Theme.primary.opacity(0.7))
                    .frame(width: 7, height: 7)
                    .scaleEffect(animate ? 1.0 : 0.5)
                    .opacity(animate ? 1.0 : 0.3)
                    .animation(
                        .easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(i) * 0.2),
                        value: animate
                    )
            }
        }
        .onAppear { animate = true }
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
        messageSummary: "Nethan had a great morning at nursery today!",
        isUnread: true,
        unreadCount: 2,
        avatar: "image1"
    ))
}
