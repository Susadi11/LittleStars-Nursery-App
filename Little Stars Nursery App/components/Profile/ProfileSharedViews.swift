//
//  ProfileSharedViews.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-05-29.
//

import SwiftUI

struct ProfileSectionLabel: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(Color.Theme.labelCaption)
                .kerning(1.2)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.bottom, 2)
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
    var bgColor: Color   = Color.Theme.tagBg
    var textColor: Color = Color.Theme.tagText

    var body: some View {
        Text(label)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(textColor)
            .padding(.horizontal, 11)
            .padding(.vertical, 6)
            .background(bgColor)
            .cornerRadius(20)
    }
}
