//
//  ProfileView.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-04-01.
//
import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.Theme.background.ignoresSafeArea()

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
                                    .fill(Color.Theme.primary.opacity(0.15))
                                    .frame(width: 90, height: 90)
                            }
                            ZStack {
                                Circle()
                                    .fill(Color.Theme.secondary)
                                    .frame(width: 24, height: 24)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                Image(systemName: "pencil")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .offset(x: 3, y: 3)
                        }
                        .padding(.top, 20)

                        Text("Nathali Perera")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color.Theme.labelPrimary)

                        Text("Primary Guardian • Nethan's Mom")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)

                        HStack(spacing: 5) {
                            Circle()
                                .fill(Color.Theme.primary)
                                .frame(width: 6, height: 6)
                            Text("Verified Account")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color.Theme.secondary)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color.Theme.primary.opacity(0.10))
                        .cornerRadius(20)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 24)

                    VStack(spacing: 12) {

                        ProfileInfoCard(
                            iconName: "staroflife.fill",
                            iconColor: Color.Theme.destructive,
                            iconBg: Color.Theme.destructiveBg,
                            title: "Emergency Contacts"
                        ) {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack(spacing: 8) {
                                    Text("Nadan Perera")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color.Theme.labelPrimary)
                                    Text("FATHER")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(Color.Theme.labelSubtitle)
                                        .padding(.horizontal, 7)
                                        .padding(.vertical, 3)
                                        .background(Color.Theme.iconBg)
                                        .cornerRadius(6)
                                }
                                Text("+94 7141 51567")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                        }

                        ProfileInfoCard(
                            iconName: "cross.case.fill",
                            iconColor: Color.Theme.primary,
                            iconBg: Color.Theme.primary.opacity(0.12),
                            title: "Medical Information"
                        ) {
                            VStack(alignment: .leading, spacing: 6) {
                                ProfileBullet(text: "Asthma inhaler (Blue)")
                                ProfileBullet(text: "Blood Type: O Positive")
                            }
                        }

                        ProfileInfoCard(
                            iconName: "fork.knife",
                            iconColor: Color.Theme.primary,
                            iconBg: Color.Theme.primary.opacity(0.12),
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
                            iconColor: Color.Theme.primary,
                            iconBg: Color.Theme.primary.opacity(0.12),
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
                                                    .fill(Color.Theme.primary.opacity(0.22))
                                                    .frame(width: 34, height: 34)
                                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                            }
                                        }
                                    }
                                    ZStack {
                                        Circle()
                                            .fill(Color.Theme.primary.opacity(0.18))
                                            .frame(width: 34, height: 34)
                                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        Text("+1")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(Color.Theme.secondary)
                                    }
                                }
                                Text("3 people authorised to collect Nethan.")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal, 16)

                    VStack(alignment: .leading, spacing: 0) {
                        Text("ACCOUNT SETTINGS")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color.Theme.labelCaption)
                            .kerning(1.2)
                            .padding(.horizontal, 16)
                            .padding(.top, 28)
                            .padding(.bottom, 10)

                        VStack(spacing: 0) {
                            ProfileSettingsRow(icon: "lock.fill", label: "Privacy & Security", isDestructive: false, showChevron: true)
                            Divider()
                            ProfileSettingsRow(icon: "gear", label: "Settings", isDestructive: false, showChevron: true)
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
                        .foregroundColor(Color.Theme.secondary)
                }
            }
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color.Theme.labelPrimary)
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

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(Color.Theme.primary)
                .frame(width: 6, height: 6)
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(Color.Theme.labelBody)
        }
    }
}

struct ProfileTag: View {
    let label: String

    var body: some View {
        Text(label)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(Color.Theme.tagText)
            .padding(.horizontal, 11)
            .padding(.vertical, 6)
            .background(Color.Theme.tagBg)
            .cornerRadius(20)
    }
}

struct ProfileSettingsRow: View {
    let icon: String
    let label: String
    var isDestructive: Bool = false
    var showChevron: Bool = true

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 17))
                .foregroundColor(isDestructive ? Color.Theme.destructive : Color.Theme.labelAsh)
                .frame(width: 22)
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(isDestructive ? Color.Theme.destructive : Color.Theme.labelPrimary)
            Spacer()
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .foregroundColor(Color.Theme.labelChevron)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
    }
}

#Preview {
    ProfileView()
}
