//
//  DiaryEntryTests.swift
//  Little Stars Nursery AppTests
//

import XCTest
@testable import Little_Stars_Nursery_App

final class DiaryEntryTests: XCTestCase {

    func test_diaryEntry_hasUniqueID() {
        let a = DiaryEntry(category: .mood, time: "08:30 AM", title: "Arrival", description: "Happy", imageName: nil)
        let b = DiaryEntry(category: .mood, time: "08:30 AM", title: "Arrival", description: "Happy", imageName: nil)
        XCTAssertNotEqual(a.id, b.id)
    }

    func test_diaryCategory_icon_isNonEmpty() {
        for category in [DiaryCategory.mood, .snack, .play, .nap, .lunch, .nappy, .outdoor, .pickup] {
            XCTAssertFalse(category.icon.isEmpty, "\(category.rawValue) icon should not be empty")
        }
    }

    func test_diaryCategory_rawValue() {
        XCTAssertEqual(DiaryCategory.mood.rawValue,    "Arrival Mood")
        XCTAssertEqual(DiaryCategory.nap.rawValue,     "Nap Time")
        XCTAssertEqual(DiaryCategory.nappy.rawValue,   "Nappy Log")
        XCTAssertEqual(DiaryCategory.lunch.rawValue,   "Lunch")
        XCTAssertEqual(DiaryCategory.outdoor.rawValue, "Outdoor Play")
    }

    func test_sampleDiaryEntries_count() {
        XCTAssertEqual(sampleDiaryEntries.count, 8, "Expected 8 sample diary entries")
    }

    func test_sampleDiaryEntries_allHaveTitles() {
        for entry in sampleDiaryEntries {
            XCTAssertFalse(entry.title.isEmpty, "Diary entry title should not be empty")
        }
    }

    func test_sampleDiaryEntries_allHaveDescriptions() {
        for entry in sampleDiaryEntries {
            XCTAssertFalse(entry.description.isEmpty, "Diary entry description should not be empty")
        }
    }

    func test_sampleDiaryEntries_allHaveTimes() {
        for entry in sampleDiaryEntries {
            XCTAssertFalse(entry.time.isEmpty, "Diary entry time should not be empty")
        }
    }

    func test_diaryEntry_imageNameIsStored() {
        let entry = DiaryEntry(category: .play, time: "2:00 PM", title: "Art", description: "Painted", imageName: "artwork")
        XCTAssertEqual(entry.imageName, "artwork")
    }

    func test_diaryEntry_nilImageName() {
        let entry = DiaryEntry(category: .nap, time: "1:00 PM", title: "Nap", description: "Slept well", imageName: nil)
        XCTAssertNil(entry.imageName)
    }

    func test_diaryCategory_allCasesHaveIcons() {
        let allCategories: [DiaryCategory] = [.mood, .snack, .play, .nap, .lunch, .nappy, .outdoor, .pickup]
        for cat in allCategories {
            XCTAssertFalse(cat.icon.isEmpty, "\(cat.rawValue) must have an SF Symbol icon")
        }
    }

    func test_diaryCategory_allCasesHaveRawValues() {
        let allCategories: [DiaryCategory] = [.mood, .snack, .play, .nap, .lunch, .nappy, .outdoor, .pickup]
        for cat in allCategories {
            XCTAssertFalse(cat.rawValue.isEmpty, "Category rawValue should not be empty")
        }
    }

    func test_sampleDiaryEntries_firstIsArrival() {
        XCTAssertEqual(sampleDiaryEntries.first?.category, .mood, "First entry should be arrival mood")
    }

    func test_sampleDiaryEntries_idsAreAllUnique() {
        let ids = sampleDiaryEntries.map { $0.id }
        let unique = Set(ids)
        XCTAssertEqual(ids.count, unique.count, "All diary entry IDs must be unique")
    }
}
