//
//  ProfileAllergenCard.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-05-29.
//

import SwiftUI

struct ProfileAllergenCard: View {

    var body: some View {
        ProfileInfoCard(title: "Dietary & Allergens") {
            VStack(alignment: .leading, spacing: 14) {

                // Anaphylactic alert banner
                HStack(spacing: 10) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color.Theme.destructive)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("ANAPHYLACTIC ALERT")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color.Theme.destructive)
                        Text("Peanut allergy — EpiPen must be carried at all times")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 0.60, green: 0.15, blue: 0.15))
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.Theme.destructiveBg)
                .cornerRadius(10)

                // Confirmed allergens
                Text("CONFIRMED ALLERGENS")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(Color.Theme.labelCaption)
                    .kerning(0.8)

                VStack(spacing: 8) {
                    AllergenRow(name: "Peanuts",      severity: "Anaphylactic")
                    AllergenRow(name: "Milk / Dairy", severity: "Allergy")
                    AllergenRow(name: "Eggs",         severity: "Intolerance")
                }

                Divider()

                // Dietary tags
                Text("DIETARY REQUIREMENTS")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(Color.Theme.labelCaption)
                    .kerning(0.8)

                HStack(spacing: 8) {
                    ProfileTag(
                        label: "Vegetarian",
                        bgColor: Color(red: 0.20, green: 0.75, blue: 0.40).opacity(0.12),
                        textColor: Color(red: 0.10, green: 0.50, blue: 0.25)
                    )
                    ProfileTag(
                        label: "No Dairy",
                        bgColor: Color(red: 0.20, green: 0.50, blue: 0.90).opacity(0.12),
                        textColor: Color(red: 0.10, green: 0.30, blue: 0.70)
                    )
                    ProfileTag(
                        label: "No Peanuts",
                        bgColor: Color.Theme.destructiveBg,
                        textColor: Color.Theme.destructive
                    )
                }
            }
        }
    }
}

private struct AllergenRow: View {
    let name: String
    let severity: String

    private var severityColor: Color {
        switch severity {
        case "Anaphylactic": return Color.Theme.destructive
        case "Allergy":      return Color(red: 0.92, green: 0.55, blue: 0.10)
        default:             return Color(red: 0.75, green: 0.60, blue: 0.05)
        }
    }

    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 14))
                .foregroundColor(Color.Theme.labelBody)
            Spacer()
            Text(severity.uppercased())
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(severityColor)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(severityColor.opacity(0.12))
                .cornerRadius(6)
        }
    }
}
