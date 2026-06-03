//
//  NutritionBar.swift
//  NurseryConnect Vision
//
//  Created by Susadi on 2026-06-02.
//

import SwiftUI

struct NutritionBar: View {
    let label: String
    let icon: String
    let color: Color
    let percent: Double
    let detail: String

    @State private var appeared = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundStyle(color)
                    .frame(width: 16)
                Text(label)
                    .font(.caption.bold())
                    .foregroundStyle(.primary)
                Spacer()
                Text(detail)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.secondary.opacity(0.12))
                        .frame(height: 10)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(
                            LinearGradient(
                                colors: [color.opacity(0.7), color],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(
                            width: appeared
                                ? geo.size.width * CGFloat(percent)
                                : 0,
                            height: 10
                        )
                        .animation(
                            .spring(response: 1.0, dampingFraction: 0.75).delay(0.15),
                            value: appeared
                        )

                    if percent >= 1.0 {
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 10))
                                .foregroundStyle(.white)
                                .padding(.trailing, 3)
                        }
                        .frame(height: 10)
                    }
                }
            }
            .frame(height: 10)
        }
        .onAppear { appeared = true }
    }
}
