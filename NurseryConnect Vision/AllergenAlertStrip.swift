//
//  AllergenAlertStrip.swift
//  NurseryConnect Vision
//
//  Created by Susadi on 2026-06-02.
//

import SwiftUI

struct AllergenAlertStrip: View {
    let allergens: [String]

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.subheadline)
                .foregroundStyle(.red)
            VStack(alignment: .leading, spacing: 2) {
                Text("Allergens served today")
                    .font(.caption.bold())
                    .foregroundStyle(.red)
                Text(allergens.joined(separator: " · "))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text("Please verify with nursery if concerned")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: 160)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.red.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.red.opacity(0.25), lineWidth: 1)
                )
        )
    }
}
