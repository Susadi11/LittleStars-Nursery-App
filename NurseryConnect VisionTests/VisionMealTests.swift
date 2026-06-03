//
//  VisionMealTests.swift
//  NurseryConnect VisionTests
//
//  Created by Susadi on 2026-06-02.
//

import XCTest
@testable import NurseryConnect_Vision

final class VisionMealTests: XCTestCase {

    func testConsumptionFractionRange() {
        for consumption in VisionConsumption.allCases {
            XCTAssertGreaterThanOrEqual(consumption.rawValue, 0.0)
            XCTAssertLessThanOrEqual(consumption.rawValue, 1.0)
        }
    }

    func testNutritionSummaryFluidTotal() {
        let child = VisionChild.harry
        let summary = child.nutritionSummary
        let expected = child.todayMeals.reduce(0) { $0 + $1.fluidMl }
        XCTAssertEqual(summary.fluidTotalMl, expected)
    }

    func testNutritionPercentCappedAtOne() {
        let summary = VisionNutritionSummary(
            fruitAndVegPortions: 10, dairyPortions: 10,
            proteinPortions: 10, carbPortions: 10, fluidTotalMl: 5000
        )
        XCTAssertLessThanOrEqual(summary.fruitAndVegPercent, 1.0)
        XCTAssertLessThanOrEqual(summary.fluidPercent, 1.0)
    }

    func testBusRouteInitialStatus() {
        let route = VisionRoute.liveRoute
        XCTAssertEqual(route.stops[0].status, BusStopStatus.current)
        XCTAssertEqual(route.stops[1].status, BusStopStatus.upcoming)
    }

    func testHarryHasFourMeals() {
        XCTAssertEqual(VisionChild.harry.todayMeals.count, 4)
    }

    func testAllergenFlagsDetected() {
        let flagged = VisionChild.harry.todayMeals.filter { !$0.allergenFlags.isEmpty }
        XCTAssertFalse(flagged.isEmpty)
    }
}
