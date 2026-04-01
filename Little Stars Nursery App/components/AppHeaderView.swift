//
//  AppHeaderView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-26.
//
import SwiftUI

struct AppHeaderView: View {

    @State private var showNotifications = false

    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)
    private let bgColor        = Color(red: 0.97, green: 0.98, blue: 0.98)
    private let iconBg         = Color(red: 0.91, green: 0.92, blue: 0.93)

    var body: some View {
        ZStack(alignment: .top) {

            HStack {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(iconBg)
                            .frame(width: 46, height: 46)
                        if UIImage(named: "profilePic") != nil {
                            Image("profilePic")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 46, height: 46)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(primaryColor.opacity(0.20))
                                .frame(width: 46, height: 46)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(secondaryColor)
                                )
                        }
                    }
                    Text("NurseryConnect")
                        .font(.system(size: 19, weight: .bold))
                        .foregroundColor(secondaryColor)
                }

                Spacer()

                Button(action: {
                    showNotifications = true
                }) {
                    ZStack(alignment: .topTrailing) {
                        Circle()
                            .fill(iconBg)
                            .frame(width: 44, height: 44)
                        Image(systemName: "bell.fill")
                            .font(.system(size: 18))
                            .foregroundColor(secondaryColor)
                            .frame(width: 44, height: 44)

                        Circle()
                            .fill(Color(red: 0.92, green: 0.28, blue: 0.25))
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
            .background(bgColor)
        }
        .fullScreenCover(isPresented: $showNotifications) {
            NotificationsView(isPresented: $showNotifications)
        }
    }
}

#Preview {
    AppHeaderView()
}
