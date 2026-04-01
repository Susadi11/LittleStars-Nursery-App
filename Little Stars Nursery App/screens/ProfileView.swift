//
//  ProfileView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-01.
//
import SwiftUI

struct ProfileView: View {
    private let bgColor        = Color(red: 0.97, green: 0.98, blue: 0.98)
    private let primaryColor   = Color(red: 0.18, green: 0.77, blue: 0.71)
    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    var body: some View {
        ZStack(alignment: .top) {
            bgColor.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    AppHeaderView()

                    VStack(spacing: 10) {
                        ZStack(alignment: .bottomTrailing) {
                            if UIImage(named: "profilePic") != nil {
                                Image("profilePic")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .clipShape(RoundedRectangle(cornerRadius: 24))
                                    .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 3)
                            } else {
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(primaryColor.opacity(0.15))
                                    .frame(width: 90, height: 90)
                            }
                            ZStack {
                                Circle()
                                    .fill(secondaryColor)
                                    .frame(width: 24, height: 24)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                Image(systemName: "pencil")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .offset(x: 3, y: 3)
                        }
                        .padding(.top, 20)

                        Text("Sarah Mitchell")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))

                        Text("Primary Guardian • Leo's Mom")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)

                        HStack(spacing: 5) {
                            Circle()
                                .fill(primaryColor)
                                .frame(width: 6, height: 6)
                            Text("Verified Account")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(secondaryColor)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(primaryColor.opacity(0.10))
                        .cornerRadius(20)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 24)

                    VStack(spacing: 12) {

                        ProfileInfoCard(
                            iconName: "staroflife.fill",
                            iconColor: Color(red: 0.85, green: 0.20, blue: 0.20),
                            iconBg: Color(red: 0.98, green: 0.93, blue: 0.93),
                            title: "Emergency Contacts"
                        ) {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack(spacing: 8) {
                                    Text("David Mitchell")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
                                    Text("FATHER")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(Color(red: 0.50, green: 0.54, blue: 0.58))
                                        .padding(.horizontal, 7)
                                        .padding(.vertical, 3)
                                        .background(Color(red: 0.91, green: 0.92, blue: 0.93))
                                        .cornerRadius(6)
                                }
                                Text("+44 7700 900123")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                        }

                        ProfileInfoCard(
                            iconName: "cross.case.fill",
                            iconColor: primaryColor,
                            iconBg: primaryColor.opacity(0.12),
                            title: "Medical Information"
                        ) {
                            VStack(alignment: .leading, spacing: 6) {
                                ProfileBullet(text: "Asthma inhaler (Blue)")
                                ProfileBullet(text: "Blood Type: O Positive")
                            }
                        }

                        ProfileInfoCard(
                            iconName: "fork.knife",
                            iconColor: primaryColor,
                            iconBg: primaryColor.opacity(0.12),
                            title: "Dietary Preferences"
                        ) {
                            HStack(spacing: 8) {
                                ProfileTag(label: "No Dairy")
                                ProfileTag(label: "Egg Allergy")
                                ProfileTag(label: "Vegetarian")
                            }
                        }

                        ProfileInfoCard(
                            iconName: "person.2.fill",
                            iconColor: primaryColor,
                            iconBg: primaryColor.opacity(0.12),
                            title: "Collection Auth"
                        ) {
                            VStack(alignment: .leading, spacing: 6) {
                                HStack(spacing: -10) {
                                    ForEach(["grand_mom", "grand_father"], id: \.self) { name in
                                        Group {
                                            if UIImage(named: name) != nil {
                                                Image(name)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 34, height: 34)
                                                    .clipShape(Circle())
                                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                            } else {
                                                Circle()
                                                    .fill(primaryColor.opacity(0.22))
                                                    .frame(width: 34, height: 34)
                                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                            }
                                        }
                                    }
                                    ZStack {
                                        Circle()
                                            .fill(primaryColor.opacity(0.18))
                                            .frame(width: 34, height: 34)
                                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        Text("+1")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(secondaryColor)
                                    }
                                }
                                Text("3 people authorised to collect Leo.")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal, 16)

                    VStack(alignment: .leading, spacing: 0) {
                        Text("ACCOUNT SETTINGS")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.65))
                            .kerning(1.2)
                            .padding(.horizontal, 16)
                            .padding(.top, 28)
                            .padding(.bottom, 10)

                        VStack(spacing: 0) {
                            ProfileSettingsRow(icon: "lock.fill", label: "Privacy & Security", isDestructive: false, showChevron: true)
                            Divider()
                            ProfileSettingsRow(icon: "creditcard.fill", label: "Billing & Subscriptions", isDestructive: false, showChevron: true)
                            Divider()
                            ProfileSettingsRow(icon: "rectangle.portrait.and.arrow.right.fill", label: "Sign Out", isDestructive: true, showChevron: false)
                        }
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
                        .padding(.horizontal, 16)
                    }

                    Spacer().frame(height: 110)
                }
            }
        }
    }
}

struct ProfileInfoCard<Content: View>: View {
    let iconName: String
    let iconColor: Color
    let iconBg: Color
    let title: String
    let content: () -> Content

    private let secondaryColor = Color(red: 0.11, green: 0.56, blue: 0.53)

    init(iconName: String, iconColor: Color, iconBg: Color, title: String, @ViewBuilder content: @escaping () -> Content) {
        self.iconName  = iconName
        self.iconColor = iconColor
        self.iconBg    = iconBg
        self.title     = title
        self.content   = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(iconBg)
                        .frame(width: 40, height: 40)
                    Image(systemName: iconName)
                        .font(.system(size: 17))
                        .foregroundColor(iconColor)
                }
                Spacer()
                Button(action: {}) {
                    Text("Edit")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(secondaryColor)
                }
            }
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
            content()
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
    }
}

struct ProfileBullet: View {
    let text: String
    private let primaryColor = Color(red: 0.18, green: 0.77, blue: 0.71)

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(primaryColor)
                .frame(width: 6, height: 6)
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.20, green: 0.22, blue: 0.25))
        }
    }
}

struct ProfileTag: View {
    let label: String

    var body: some View {
        Text(label)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(Color(red: 0.25, green: 0.28, blue: 0.30))
            .padding(.horizontal, 11)
            .padding(.vertical, 6)
            .background(Color(red: 0.91, green: 0.93, blue: 0.93))
            .cornerRadius(20)
    }
}

struct ProfileSettingsRow: View {
    let icon: String
    let label: String
    var isDestructive: Bool = false
    var showChevron: Bool = true

    private let ashColor = Color(red: 0.45, green: 0.48, blue: 0.52)
    private let redColor = Color(red: 0.85, green: 0.18, blue: 0.18)

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 17))
                .foregroundColor(isDestructive ? redColor : ashColor)
                .frame(width: 22)
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(isDestructive ? redColor : Color(red: 0.10, green: 0.12, blue: 0.15))
            Spacer()
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .foregroundColor(Color(red: 0.75, green: 0.77, blue: 0.80))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
    }
}

#Preview {
    ProfileView()
}
