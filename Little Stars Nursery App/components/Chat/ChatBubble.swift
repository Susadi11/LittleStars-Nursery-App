//
//  ChatBubble.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-04.
//
import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage
    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)

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
