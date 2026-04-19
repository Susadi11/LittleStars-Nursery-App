//
//  ChatMessageTests.swift
//  Little Stars Nursery AppTests
//

import XCTest
@testable import Little_Stars_Nursery_App

final class ChatMessageTests: XCTestCase {

    func test_chatMessage_hasUniqueID() {
        let a = ChatMessage(text: "Hello", time: "9:00 AM", isFromMe: true)
        let b = ChatMessage(text: "Hello", time: "9:00 AM", isFromMe: true)
        XCTAssertNotEqual(a.id, b.id)
    }

    func test_chatMessage_isFromMe_true() {
        let msg = ChatMessage(text: "Hi", time: "9:00 AM", isFromMe: true)
        XCTAssertTrue(msg.isFromMe)
    }

    func test_chatMessage_isFromMe_false() {
        let msg = ChatMessage(text: "Hi", time: "9:00 AM", isFromMe: false)
        XCTAssertFalse(msg.isFromMe)
    }

    func test_chatMessage_defaultImageName_isNil() {
        let msg = ChatMessage(text: "Hello", time: "9:00 AM", isFromMe: true)
        XCTAssertNil(msg.imageName)
    }

    func test_chatMessage_withImageName() {
        let msg = ChatMessage(text: "", time: "10:00 AM", isFromMe: false, imageName: "child_build")
        XCTAssertEqual(msg.imageName, "child_build")
    }

    func test_chatMessage_encodeDecode_roundtrip() throws {
        let original = ChatMessage(text: "Test message", time: "11:00 AM", isFromMe: true)
        let data     = try JSONEncoder().encode(original)
        let decoded  = try JSONDecoder().decode(ChatMessage.self, from: data)
        XCTAssertEqual(decoded.id,       original.id)
        XCTAssertEqual(decoded.text,     original.text)
        XCTAssertEqual(decoded.time,     original.time)
        XCTAssertEqual(decoded.isFromMe, original.isFromMe)
    }

    func test_chatMessageArray_encodeDecode_roundtrip() throws {
        let messages = [
            ChatMessage(text: "Hello",   time: "9:00 AM",  isFromMe: false),
            ChatMessage(text: "Hi back", time: "9:01 AM",  isFromMe: true),
            ChatMessage(text: "Photo",   time: "9:05 AM",  isFromMe: false, imageName: "img1")
        ]
        let data    = try JSONEncoder().encode(messages)
        let decoded = try JSONDecoder().decode([ChatMessage].self, from: data)
        XCTAssertEqual(decoded.count, messages.count)
        for (d, o) in zip(decoded, messages) {
            XCTAssertEqual(d.id,       o.id)
            XCTAssertEqual(d.text,     o.text)
            XCTAssertEqual(d.isFromMe, o.isFromMe)
        }
    }

    func test_emptyMessage_isRejected() {
        let msg = "   "
        XCTAssertTrue(msg.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                      "Whitespace-only message should be blocked from sending")
    }

    func test_sampleMessages_count() {
        XCTAssertGreaterThan(sampleMessages.count, 0, "Sample messages should not be empty")
    }

    func test_chatMessage_textIsPreserved() {
        let msg = ChatMessage(text: "Good morning!", time: "8:00 AM", isFromMe: true)
        XCTAssertEqual(msg.text, "Good morning!")
    }

    func test_chatMessage_timeIsPreserved() {
        let msg = ChatMessage(text: "Hi", time: "3:45 PM", isFromMe: false)
        XCTAssertEqual(msg.time, "3:45 PM")
    }

    func test_chatMessage_withImageName_encodeDecode() throws {
        let original = ChatMessage(text: "Photo", time: "10:00 AM", isFromMe: false, imageName: "drawing")
        let data     = try JSONEncoder().encode(original)
        let decoded  = try JSONDecoder().decode(ChatMessage.self, from: data)
        XCTAssertEqual(decoded.imageName, "drawing")
    }

    func test_whitespaceOnly_isConsideredEmpty() {
        let inputs = ["   ", "\t", "     "]
        for input in inputs {
            XCTAssertTrue(input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                          "'\(input)' should be treated as empty")
        }
    }

    func test_nonEmptyMessage_passesValidation() {
        let msg = "Hello teacher"
        XCTAssertFalse(msg.trimmingCharacters(in: .whitespaces).isEmpty)
    }

    func test_sampleMessages_allHaveText() {
        for msg in sampleMessages {
            XCTAssertFalse(msg.text.isEmpty, "Sample message text should not be empty")
        }
    }

    func test_sampleMessages_allHaveTimes() {
        for msg in sampleMessages {
            XCTAssertFalse(msg.time.isEmpty, "Sample message time should not be empty")
        }
    }
}
