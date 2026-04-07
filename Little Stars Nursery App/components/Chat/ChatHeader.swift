//
//  ChatHeader.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-04.
//
import SwiftUI

struct ChatHeader: View {
    var onBack: () -> Void

    var body: some View {
        HStack(spacing: 12) {

            Button(action: onBack) {
                ZStack {
                    Circle()
                        .fill(Color.Theme.primary.opacity(0.12))
                        .frame(width: 38, height: 38)
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color.Theme.secondary)
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
                            .fill(Color.Theme.primary.opacity(0.18))
                            .frame(width: 46, height: 46)
                        Text("👩‍🏫")
                            .font(.system(size: 26))
                    }
                }

                Circle()
                    .fill(Color.green)
                    .frame(width: 11, height: 11)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("Ayesha")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.Theme.labelPrimary)

                HStack(spacing: 4) {
                    Text("KEYWORKER")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(Color.Theme.secondary)
                        .kerning(0.6)
                    Text("•")
                        .font(.system(size: 11))
                        .foregroundColor(.green)
                    Text("ONLINE")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.green)
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

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.Theme.primary.opacity(0.12))
                .frame(width: 38, height: 38)
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundColor(Color.Theme.secondary)
        }
    }
}
