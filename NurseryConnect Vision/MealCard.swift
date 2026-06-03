//
//  MealCard.swift
//  NurseryConnect Vision
//
//  Created by Susadi on 2026-06-02.
//

import SwiftUI

struct MealCard: View {
    let meal: VisionMeal
    @State private var appeared = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(meal.name)
                        .font(.subheadline.bold())
                        .foregroundStyle(.primary)
                    Text(meal.time)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text(meal.consumption.label)
                    .font(.caption.bold())
                    .foregroundStyle(meal.consumption.color)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(meal.consumption.color.opacity(0.12))
                    )
            }

            Text(meal.foods.joined(separator: " · "))
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            // Animated consumption bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.secondary.opacity(0.15))
                        .frame(height: 8)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(meal.consumption.color)
                        .frame(
                            width: appeared
                                ? geo.size.width * CGFloat(meal.consumption.rawValue)
                                : 0,
                            height: 8
                        )
                        .animation(
                            .spring(response: 0.8, dampingFraction: 0.7).delay(0.2),
                            value: appeared
                        )
                }
            }
            .frame(height: 8)

            HStack(spacing: 12) {
                Label("\(meal.fluidMl)ml fluid", systemImage: "drop.fill")
                    .font(.caption2)
                    .foregroundStyle(.blue)
                if !meal.notes.isEmpty {
                    Text("\"\(meal.notes)\"")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .italic()
                        .lineLimit(1)
                }
            }

            if !meal.allergenFlags.isEmpty {
                HStack(spacing: 4) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.caption2)
                        .foregroundStyle(.red)
                    Text("Contains: \(meal.allergenFlags.joined(separator: ", "))")
                        .font(.caption2)
                        .foregroundStyle(.red)
                }
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.13, green: 0.13, blue: 0.18).opacity(0.95))
        )
        .onAppear { appeared = true }
    }
}
