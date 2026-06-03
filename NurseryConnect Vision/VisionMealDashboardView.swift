//
//  VisionMealDashboardView.swift
//  NurseryConnect Vision
//
//  Created by Susadi on 2026-06-02.
//

import SwiftUI

struct VisionMealDashboardView: View {
    let child: VisionChild

    var body: some View {
        VStack(spacing: 0) {
            dashboardHeader
                .padding(.horizontal, 28)
                .padding(.top, 22)
                .padding(.bottom, 16)

            Divider()
                .padding(.horizontal, 28)

            HStack(alignment: .top, spacing: 0) {
                mealCardsColumn
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)

                Divider()

                nutritionChartColumn
                    .frame(width: 300)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
            }
            .frame(maxHeight: .infinity)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.08, green: 0.08, blue: 0.12).opacity(0.94))
        )
    }

    private var dashboardHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("\(child.name)'s Meals Today")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                Text(Date.now.formatted(date: .complete, time: .omitted))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            let avg = child.todayMeals.map(\.consumption.rawValue).reduce(0, +)
                      / Double(child.todayMeals.count)
            VStack(spacing: 2) {
                Text(mealQualityLabel(for: avg))
                    .font(.subheadline.bold())
                    .foregroundStyle(mealQualityColor(for: avg))
                Text("overall today")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(mealQualityColor(for: avg).opacity(0.12))
            )
        }
    }

    private var mealCardsColumn: some View {
        VStack(spacing: 14) {
            HStack {
                Text("Meal Log")
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer()
                Text("\(child.todayMeals.count) meals")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            ForEach(child.todayMeals) { meal in
                MealCard(meal: meal)
            }

            let allergens = Array(Set(child.todayMeals.flatMap(\.allergenFlags)))
            if !allergens.isEmpty {
                AllergenAlertStrip(allergens: allergens)
            }
        }
    }

    private var nutritionChartColumn: some View {
        let nutrition = child.nutritionSummary
        return VStack(alignment: .leading, spacing: 16) {
            Text("Nutrition Summary")
                .font(.headline)
                .foregroundStyle(.primary)

            VStack(spacing: 12) {
                NutritionBar(label: "Fruit & Veg",    icon: "leaf.fill",
                             color: .green,   percent: nutrition.fruitAndVegPercent,
                             detail: "\(String(format: "%.1f", nutrition.fruitAndVegPortions))/5 portions")
                NutritionBar(label: "Dairy",           icon: "cup.and.saucer.fill",
                             color: .indigo,  percent: nutrition.dairyPercent,
                             detail: "\(String(format: "%.1f", nutrition.dairyPortions))/3 portions")
                NutritionBar(label: "Protein",         icon: "fork.knife",
                             color: .orange,  percent: nutrition.proteinPercent,
                             detail: "\(String(format: "%.1f", nutrition.proteinPortions))/2 portions")
                NutritionBar(label: "Carbohydrates",   icon: "circle.grid.2x2.fill",
                             color: .brown,   percent: nutrition.carbPercent,
                             detail: "\(String(format: "%.1f", nutrition.carbPortions))/4 portions")
                NutritionBar(label: "Fluid",           icon: "drop.fill",
                             color: .blue,    percent: nutrition.fluidPercent,
                             detail: "\(nutrition.fluidTotalMl)ml / 1000ml target")
            }

            Divider()

            HStack(spacing: 6) {
                Image(systemName: "info.circle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Targets based on FSA Eatwell Guide for under-5s")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func mealQualityLabel(for avg: Double) -> String {
        switch avg {
        case 0.8...1.0: return "Excellent"
        case 0.6..<0.8: return "Good"
        case 0.4..<0.6: return "Fair"
        default:        return "Poor"
        }
    }

    private func mealQualityColor(for avg: Double) -> Color {
        switch avg {
        case 0.8...1.0: return .green
        case 0.6..<0.8: return .indigo
        case 0.4..<0.6: return .orange
        default:        return .red
        }
    }
}
