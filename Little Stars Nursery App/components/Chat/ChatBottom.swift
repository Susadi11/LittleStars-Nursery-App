//
//  ChatBottom.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-04.
//
import SwiftUI

struct ChatBottom: View {
    @Binding var messageText: String
    var onSend: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color.Theme.iconBg)
                    .frame(width: 42, height: 42)
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color.Theme.labelAsh)
            }

            TextField("Type a message...", text: $messageText)
                .font(.system(size: 15))
                .padding(.horizontal, 16)
                .padding(.vertical, 11)
                .background(Color.Theme.tagBg)
                .cornerRadius(24)

            Button(action: onSend) {
                ZStack {
                    Circle()
                        .fill(Color.Theme.secondary)
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
