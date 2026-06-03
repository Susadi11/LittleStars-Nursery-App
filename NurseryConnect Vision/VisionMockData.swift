//
//  VisionMockData.swift
//  NurseryConnect Vision
//
//  Created by Susadi on 2026-06-02.
//

import Foundation
import SwiftUI

enum VisionConsumption: Double, CaseIterable {
    case all    = 1.0
    case most   = 0.75
    case half   = 0.5
    case little = 0.25
    case none   = 0.0

    var label: String {
        switch self {
        case .all:    return "Ate all"
        case .most:   return "Ate most"
        case .half:   return "Ate half"
        case .little: return "Ate a little"
        case .none:   return "Did not eat"
        }
    }

    var color: Color {
        switch self {
        case .all:    return Color(red: 0.13, green: 0.62, blue: 0.46)
        case .most:   return Color(red: 0.34, green: 0.34, blue: 0.85)
        case .half:   return Color(red: 0.95, green: 0.60, blue: 0.07)
        case .little: return Color(red: 0.95, green: 0.45, blue: 0.07)
        case .none:   return Color(red: 0.86, green: 0.21, blue: 0.27)
        }
    }
}

struct VisionMeal: Identifiable {
    let id: UUID
    let name: String
    let time: String
    let consumption: VisionConsumption
    let foods: [String]
    let fluidMl: Int
    let notes: String
    let allergenFlags: [String]

    init(name: String, time: String, consumption: VisionConsumption,
         foods: [String], fluidMl: Int = 150,
         notes: String = "", allergenFlags: [String] = []) {
        self.id           = UUID()
        self.name         = name
        self.time         = time
        self.consumption  = consumption
        self.foods        = foods
        self.fluidMl      = fluidMl
        self.notes        = notes
        self.allergenFlags = allergenFlags
    }
}

struct VisionNutritionSummary {
    let fruitAndVegPortions: Double
    let dairyPortions: Double
    let proteinPortions: Double
    let carbPortions: Double
    let fluidTotalMl: Int

    var fruitAndVegPercent: Double { min(fruitAndVegPortions / 5.0, 1.0) }
    var dairyPercent: Double       { min(dairyPortions / 3.0, 1.0) }
    var proteinPercent: Double     { min(proteinPortions / 2.0, 1.0) }
    var carbPercent: Double        { min(carbPortions / 4.0, 1.0) }
    var fluidPercent: Double       { min(Double(fluidTotalMl) / 1000.0, 1.0) }
}

struct VisionChild: Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let todayMeals: [VisionMeal]

    var nutritionSummary: VisionNutritionSummary {
        let totalFluid    = todayMeals.reduce(0) { $0 + $1.fluidMl }
        let consumed      = todayMeals.filter { $0.consumption.rawValue >= 0.5 }
        let dairyKeywords = ["milk", "yoghurt", "cheese"]
        let proteinKeywords = ["chicken", "egg", "fish", "beef"]
        return VisionNutritionSummary(
            fruitAndVegPortions: Double(consumed.count) * 0.8,
            dairyPortions: Double(consumed.filter { m in
                m.foods.contains { f in dairyKeywords.contains { f.lowercased().contains($0) } }
            }.count) * 1.2,
            proteinPortions: Double(consumed.filter { m in
                m.foods.contains { f in proteinKeywords.contains { f.lowercased().contains($0) } }
            }.count),
            carbPortions: Double(consumed.count) * 0.9,
            fluidTotalMl: totalFluid
        )
    }
}

enum BusStopStatus: Equatable {
    case upcoming
    case current
    case collected
}

struct VisionBusStop: Identifiable {
    let id: UUID
    let schoolName: String
    let scheduledTime: String
    let childName: String
    var status: BusStopStatus
    let routePosition: Float
}

struct VisionRoute {
    var stops: [VisionBusStop]
    var currentStopIndex: Int
    let driverName: String
    let estimatedReturnTime: String

    var busRoutePosition: Float {
        guard currentStopIndex < stops.count else { return 1.0 }
        return stops[currentStopIndex].routePosition
    }
}

extension VisionChild {
    static let harry = VisionChild(
        id: UUID(),
        name: "Harry Potter",
        age: 4,
        todayMeals: [
            VisionMeal(name: "Breakfast", time: "8:30 AM", consumption: .all,
                       foods: ["Porridge", "Banana", "Whole milk"], fluidMl: 180,
                       notes: "Ate enthusiastically, asked for seconds of banana."),
            VisionMeal(name: "Morning Snack", time: "10:15 AM", consumption: .most,
                       foods: ["Apple slices", "Water"], fluidMl: 150,
                       notes: "Left a few apple slices."),
            VisionMeal(name: "Lunch", time: "12:00 PM", consumption: .all,
                       foods: ["Chicken", "Roast vegetables", "Mashed potato", "Milk"],
                       fluidMl: 200, notes: "Cleared the plate.",
                       allergenFlags: ["Milk"]),
            VisionMeal(name: "Afternoon Snack", time: "3:00 PM", consumption: .half,
                       foods: ["Yoghurt", "Mixed berries"], fluidMl: 120,
                       notes: "Seemed tired, ate about half.",
                       allergenFlags: ["Milk"])
        ]
    )
}

extension VisionRoute {
    static let liveRoute = VisionRoute(
        stops: [
            VisionBusStop(id: UUID(), schoolName: "Little Whinging Primary",
                          scheduledTime: "3:15 PM", childName: "Harry Potter",
                          status: .current, routePosition: 0.35),
            VisionBusStop(id: UUID(), schoolName: "Hogsmeade Junior School",
                          scheduledTime: "3:30 PM", childName: "Hermione Granger",
                          status: .upcoming, routePosition: 0.65)
        ],
        currentStopIndex: 0,
        driverName: "Emma Wilson",
        estimatedReturnTime: "3:50 PM"
    )
}
