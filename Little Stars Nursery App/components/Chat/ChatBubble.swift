//
//  ChatBubble.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-04.
//
import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage

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
                                .fill(Color.Theme.primary.opacity(0.15))
                                .frame(width: 200, height: 180)
                                .overlay(
                                    VStack(spacing: 6) {
                                        Image(systemName: "photo")
                                            .font(.system(size: 28))
                                            .foregroundColor(Color.Theme.primary)
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
                                ? Color.Theme.secondary
                                : Color.Theme.labelPrimary
                            )
                            .padding(.horizontal, 14)
                            .padding(.vertical, 11)
                            .background(
                                message.isFromMe
                                ? Color.Theme.primary.opacity(0.25)
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
                    .foregroundColor(Color.Theme.labelCaption)
                if message.isFromMe {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 10))
                        .foregroundColor(Color.Theme.primary)
                }
            }
            .padding(.horizontal, 4)
        }
        .padding(.vertical, 3)
    }
}
