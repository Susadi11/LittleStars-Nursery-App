//
//  AppHeaderView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-26.
//

import SwiftUI

struct AppHeaderView: View {
    var childEmoji: String = "🧒"
    var onNotificationTap: (() -> Void)? = nil
    
    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)
    private let bgColor        = Color(red: 0.97, green: 0.98, blue: 0.98)
    private let iconBg         = Color(red: 0.68, green: 0.90, blue: 0.88)
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(iconBg)
                        .frame(width: 46, height: 46)
                    
                    if let _ = UIImage(named: "profilePic") {
                        Image("profilePic")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 46, height: 46)
                            .clipShape(Circle())
                    } else {
                        Text(childEmoji)
                            .font(.system(size: 26))
                    }
                }
                
                Text("NurseryConnect")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(secondaryColor)
            }
            
            Spacer()

            Button(action: { onNotificationTap?() }) {
                ZStack {
                    Circle()
                        .fill(iconBg)
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: "bell.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.65)) 
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 10)
        .background(bgColor)
    }
}

#Preview {
    AppHeaderView()
}
