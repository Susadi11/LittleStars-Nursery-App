//
//  ProfileRowViews.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-05-29.
//

import SwiftUI

struct ProfileDetailRow: View {
    let label: String
    let value: String
    let icon: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.Theme.primary.opacity(0.10))
                    .frame(width: 32, height: 32)
                Image(systemName: icon)
                    .font(.system(size: 13))
                    .foregroundColor(Color.Theme.secondary)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Color.Theme.labelCaption)
                    .kerning(0.4)
                Text(value)
                    .font(.system(size: 14))
                    .foregroundColor(Color.Theme.labelBody)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
    }
}

struct ProfileEditField: View {
    let label: String
    @Binding var value: String
    let icon: String

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.Theme.primary.opacity(0.10))
                    .frame(width: 32, height: 32)
                Image(systemName: icon)
                    .font(.system(size: 13))
                    .foregroundColor(Color.Theme.secondary)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Color.Theme.labelCaption)
                    .kerning(0.4)
                TextField(label, text: $value)
                    .font(.system(size: 14))
                    .foregroundColor(Color.Theme.labelBody)
            }
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.Theme.background)
        .cornerRadius(10)
    }
}
