//
//  ChatView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-28.
//

import SwiftUI

struct ChatView: View {
    @Binding var selectedTab: Int
    private let bgColor = Color(red: 0.96, green: 0.97, blue: 0.97)

    @State private var messageText = ""
    @State private var messages    = sampleMessages

    var body: some View {
        VStack(spacing: 0) {

            ChatHeaderView(onBack: { selectedTab = 0 })

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

            ChatInputBar(messageText: $messageText, onSend: sendMessage)
        }
        .background(bgColor.ignoresSafeArea())
        .navigationBarHidden(true)
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

struct ChatHeaderView: View {
    var onBack: () -> Void
    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    var body: some View {
        HStack(spacing: 12) {

            Button(action: onBack) {
                ZStack {
                    Circle()
                        .fill(Color(red: 0.93, green: 0.97, blue: 0.97))
                        .frame(width: 38, height: 38)
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(secondaryColor)
                }
            }

            ZStack(alignment: .bottomTrailing) {
                if UIImage(named: "keyworker") != nil {
                    Image("keyworker")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 46, height: 46)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                } else {
                    ZStack {
                        Circle()
                            .fill(primaryColor.opacity(0.18))
                            .frame(width: 46, height: 46)
                        Text("👩‍🏫")
                            .font(.system(size: 26))
                    }
                }

                Circle()
                    .fill(Color(red: 0.20, green: 0.78, blue: 0.35))
                    .frame(width: 11, height: 11)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("Sarah J.")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))

                HStack(spacing: 4) {
                    Text("KEYWORKER")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(secondaryColor)
                        .kerning(0.6)
                    Text("•")
                        .font(.system(size: 11))
                        .foregroundColor(Color(red: 0.20, green: 0.78, blue: 0.35))
                    Text("ONLINE")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(Color(red: 0.20, green: 0.78, blue: 0.35))
                        .kerning(0.6)
                }
            }

            Spacer()

            HStack(spacing: 10) {
                HeaderActionButton(icon: "video.fill")
                HeaderActionButton(icon: "info.circle.fill")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white)
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }
}

struct HeaderActionButton: View {
    let icon: String
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.93, green: 0.97, blue: 0.97))
                .frame(width: 38, height: 38)
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundColor(secondaryColor)
        }
    }
}

struct ChatBubble: View {
    let message: ChatMessage
    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    var body: some View {
        VStack(alignment: message.isFromMe ? .trailing : .leading, spacing: 2) {

            HStack(alignment: .bottom, spacing: 0) {
                if message.isFromMe { Spacer(minLength: 50) }

                VStack(alignment: message.isFromMe ? .trailing : .leading, spacing: 4) {

                    if let imgName = message.imageName, !imgName.isEmpty {
                        if UIImage(named: imgName) != nil {
                            Image(imgName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                        } else {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(primaryColor.opacity(0.15))
                                .frame(width: 200, height: 180)
                                .overlay(
                                    VStack(spacing: 6) {
                                        Image(systemName: "photo")
                                            .font(.system(size: 28))
                                            .foregroundColor(primaryColor)
                                        Text(imgName)
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                )
                        }
                    }

                    if !message.text.isEmpty {
                        Text(message.text)
                            .font(.system(size: 15))
                            .foregroundColor(
                                message.isFromMe
                                ? Color(red: 0.10, green: 0.30, blue: 0.28)
                                : Color(red: 0.13, green: 0.15, blue: 0.18)
                            )
                            .padding(.horizontal, 14)
                            .padding(.vertical, 11)
                            .background(
                                message.isFromMe
                                ? primaryColor.opacity(0.25)
                                : Color.white
                            )
                            .cornerRadius(18)
                            .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
                    }
                }

                if !message.isFromMe { Spacer(minLength: 50) }
            }

            HStack(spacing: 3) {
                Text(message.time)
                    .font(.system(size: 10))
                    .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.65))
                if message.isFromMe {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 10))
                        .foregroundColor(primaryColor)
                }
            }
            .padding(.horizontal, 4)
        }
        .padding(.vertical, 3)
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

            Text("Sarah J. is typing...")
                .font(.system(size: 12))
                .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.65))
        }
    }
}

struct ChatInputBar: View {
    @Binding var messageText: String
    var onSend: () -> Void
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color(red: 0.90, green: 0.92, blue: 0.93))
                    .frame(width: 42, height: 42)
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(red: 0.45, green: 0.50, blue: 0.55))
            }

            TextField("Type a message...", text: $messageText)
                .font(.system(size: 15))
                .padding(.horizontal, 16)
                .padding(.vertical, 11)
                .background(Color(red: 0.92, green: 0.94, blue: 0.95))
                .cornerRadius(24)

            Button(action: onSend) {
                ZStack {
                    Circle()
                        .fill(secondaryColor)
                        .frame(width: 44, height: 44)
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .offset(x: 1)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.white)
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: -2)
    }
}

#Preview {
    ChatView(selectedTab: .constant(2))
}
