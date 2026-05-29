//
//  ProfileCardViews.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-05-29.
//

import SwiftUI

struct ProfileInfoCard<Content: View>: View {
    let title: String
    var editAction: (() -> Void)? = nil
    let content: () -> Content

    init(title: String, editAction: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title      = title
        self.editAction = editAction
        self.content    = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                if let editAction {
                    Button(action: editAction) {
                        Text("Edit")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color.Theme.secondary)
                    }
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

struct ProfileSettingsRow: View {
    let icon: String
    let label: String
    var isDestructive: Bool = false
    var showChevron: Bool   = true

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

struct ProfileAccountSettingsCard: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("ACCOUNT SETTINGS")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(Color.Theme.labelCaption)
                .kerning(1.2)
                .padding(.horizontal, 16)
                .padding(.top, 28)
                .padding(.bottom, 10)

            VStack(spacing: 0) {
                ProfileSettingsRow(icon: "lock.fill",                               label: "Privacy & Security", isDestructive: false, showChevron: true)
                Divider()
                ProfileSettingsRow(icon: "gear",                                    label: "Settings",           isDestructive: false, showChevron: true)
                Divider()
                ProfileSettingsRow(icon: "rectangle.portrait.and.arrow.right.fill", label: "Sign Out",           isDestructive: true,  showChevron: false)
            }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
            .padding(.horizontal, 16)
        }
    }
}
