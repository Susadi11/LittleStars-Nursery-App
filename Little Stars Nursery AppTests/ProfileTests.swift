//
//  ProfileTests.swift
//  Little Stars Nursery AppTests
//
//  Created by Susadi on 2026-06-02.
//

import XCTest

final class ProfileTests: XCTestCase {

    private let fullNameKey  = "profile.fullName"
    private let addressKey   = "profile.address"
    private let conditionKey = "medical.condition"
    private let nhsNumberKey = "medical.nhsNumber"
    private let bloodTypeKey = "medical.bloodType"

    override func setUp() {
        super.setUp()
        [fullNameKey, addressKey, conditionKey, nhsNumberKey, bloodTypeKey]
            .forEach { UserDefaults.standard.removeObject(forKey: $0) }
    }

    func testFullNamePersists() {
        UserDefaults.standard.set("Nethan Kusal Perera", forKey: fullNameKey)
        XCTAssertEqual(UserDefaults.standard.string(forKey: fullNameKey), "Nethan Kusal Perera")
    }

    func testAddressCanBeUpdated() {
        UserDefaults.standard.set("Old Address", forKey: addressKey)
        UserDefaults.standard.set("24 Maple Close, London", forKey: addressKey)
        XCTAssertEqual(UserDefaults.standard.string(forKey: addressKey), "24 Maple Close, London")
    }

    func testMedicalConditionPersists() {
        UserDefaults.standard.set("Asthma", forKey: conditionKey)
        XCTAssertEqual(UserDefaults.standard.string(forKey: conditionKey), "Asthma")
    }

    func testNHSNumberPersists() {
        UserDefaults.standard.set("NHS 123 456 7890", forKey: nhsNumberKey)
        XCTAssertEqual(UserDefaults.standard.string(forKey: nhsNumberKey), "NHS 123 456 7890")
    }

    func testBloodTypePersists() {
        UserDefaults.standard.set("O Positive", forKey: bloodTypeKey)
        XCTAssertEqual(UserDefaults.standard.string(forKey: bloodTypeKey), "O Positive")
    }

    func testFieldsAreIndependent() {
        UserDefaults.standard.set("Nethan", forKey: fullNameKey)
        UserDefaults.standard.set("Asthma", forKey: conditionKey)
        XCTAssertNotEqual(
            UserDefaults.standard.string(forKey: fullNameKey),
            UserDefaults.standard.string(forKey: conditionKey)
        )
    }

    func testClearedFieldReturnsNil() {
        UserDefaults.standard.set("Asthma", forKey: conditionKey)
        UserDefaults.standard.removeObject(forKey: conditionKey)
        XCTAssertNil(UserDefaults.standard.string(forKey: conditionKey))
    }
}
