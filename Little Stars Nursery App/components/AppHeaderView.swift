//
//  AppHeaderView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-26.
//
import SwiftUI

struct AppHeaderView: View {

    @State private var showNotifications = false

    var body: some View {
        ZStack(alignment: .top) {

            HStack {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.Theme.iconBg)
                            .frame(width: 46, height: 46)
                        if UIImage(named: "profilePic") != nil {
                            Image("profilePic")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 46, height: 46)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(Color.Theme.primary.opacity(0.20))
                                .frame(width: 46, height: 46)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(Color.Theme.secondary)
                                )
                        }
                    }
                    Text("NurseryConnect")
                        .font(.system(size: 19, weight: .bold))
                        .foregroundColor(Color.Theme.secondary)
                }

                Spacer()

                Button(action: {
                    showNotifications = true
                }) {
                    ZStack(alignment: .topTrailing) {
                        Circle()
                            .fill(Color.Theme.iconBg)
                            .frame(width: 44, height: 44)
                        Image(systemName: "bell.fill")
                            .font(.system(size: 18))
                            .foregroundColor(Color.Theme.secondary)
                            .frame(width: 44, height: 44)

                        Circle()
                            .fill(Color.Theme.notificationDot)
                            .frame(width: 9, height: 9)
                            .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
                            .offset(x: 1, y: 1)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 10)
            .background(Color.Theme.background)
        }
    }
}

#Preview {
    AppHeaderView()
}
