//
//  Little_Stars_Nursery_AppUITests.swift
//  Little Stars Nursery AppUITests
//

import XCTest

final class Little_Stars_Nursery_AppUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_tabBar_existsWithFiveTabs() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.exists, "Tab bar should be visible")

        XCTAssertTrue(tabBar.buttons["Home"].exists,    "Home tab should exist")
        XCTAssertTrue(tabBar.buttons["Diary"].exists,   "Diary tab should exist")
        XCTAssertTrue(tabBar.buttons["Chat"].exists,    "Chat tab should exist")
        XCTAssertTrue(tabBar.buttons["Track"].exists,   "Track tab should exist")
        XCTAssertTrue(tabBar.buttons["Profile"].exists, "Profile tab should exist")
    }

    func test_tabBar_switchToDiaryTab() {
        app.tabBars.buttons["Diary"].tap()
        let title = app.staticTexts["Nethan's Diary"]
        XCTAssertTrue(title.waitForExistence(timeout: 5), "Diary title should appear")
    }

    func test_tabBar_switchToChatTab() {
        app.tabBars.buttons["Chat"].tap()
        let chatCell = app.staticTexts["Ayesha (KeyWorker)"]
        XCTAssertTrue(chatCell.waitForExistence(timeout: 3), "Chat list should show keyworker name")
    }

    func test_tabBar_switchToProfileTab() {
        app.tabBars.buttons["Profile"].tap()
        let name = app.staticTexts["Nathali Perera"]
        XCTAssertTrue(name.waitForExistence(timeout: 3), "Profile should show guardian name")
    }

    func test_diaryView_showsEntries() {
        app.tabBars.buttons["Diary"].tap()

        let firstEntry = app.staticTexts["ARRIVAL MOOD"]
        XCTAssertTrue(firstEntry.waitForExistence(timeout: 5),
                      "First diary entry title should appear after loading")
    }

    func test_diaryView_showsDateHeader() {
        app.tabBars.buttons["Diary"].tap()
        let dateLabel = app.staticTexts["THURSDAY, OCTOBER 24"]
        XCTAssertTrue(dateLabel.waitForExistence(timeout: 3),
                      "Date header should be visible in diary")
    }

    func test_chatView_showsConversations() {
        app.tabBars.buttons["Chat"].tap()

        let keyworkerChat = app.staticTexts["Ayesha (KeyWorker)"]
        let adminChat = app.staticTexts["Admin Office"]

        XCTAssertTrue(keyworkerChat.waitForExistence(timeout: 3))
        XCTAssertTrue(adminChat.exists, "Admin Office conversation should be listed")
    }

    func test_chatView_openConversation() {
        app.tabBars.buttons["Chat"].tap()

        let keyworkerChat = app.staticTexts["Ayesha (KeyWorker)"]
        XCTAssertTrue(keyworkerChat.waitForExistence(timeout: 3))
        keyworkerChat.tap()

        let todayLabel = app.staticTexts["TODAY"]
        XCTAssertTrue(todayLabel.waitForExistence(timeout: 3),
                      "Conversation should show TODAY date separator")
    }

    func test_chatConversation_showsMessages() {
        app.tabBars.buttons["Chat"].tap()

        let keyworkerChat = app.staticTexts["Ayesha (KeyWorker)"]
        XCTAssertTrue(keyworkerChat.waitForExistence(timeout: 3))
        keyworkerChat.tap()

        let firstMessage = app.staticTexts.element(matching: NSPredicate(
            format: "label CONTAINS %@", "Nethan arrived happy"
        ))
        XCTAssertTrue(firstMessage.waitForExistence(timeout: 3),
                      "First sample message should be visible")
    }

    func test_chatConversation_hasMessageInput() {
        app.tabBars.buttons["Chat"].tap()

        app.staticTexts["Ayesha (KeyWorker)"].tap()

        let textField = app.textFields["Type a message..."]
        XCTAssertTrue(textField.waitForExistence(timeout: 3),
                      "Message input field should be present")
    }

    func test_chatConversation_sendMessage() {
        app.tabBars.buttons["Chat"].tap()

        app.staticTexts["Ayesha (KeyWorker)"].tap()

        let textField = app.textFields["Type a message..."]
        XCTAssertTrue(textField.waitForExistence(timeout: 3))
        textField.tap()
        textField.typeText("Hello from UI test!")

        let sendButton = app.buttons["sendButton"]
        XCTAssertTrue(sendButton.exists, "Send button should exist")
        sendButton.tap()

        // New message appends at the bottom — scroll down to reveal it
        app.swipeUp()

        let sentMessage = app.staticTexts.element(matching: NSPredicate(
            format: "label CONTAINS %@", "Hello from UI test!"
        ))
        XCTAssertTrue(sentMessage.waitForExistence(timeout: 3),
                      "Sent message should appear in the conversation")
    }

    func test_chatConversation_emptyMessageNotSent() {
        app.tabBars.buttons["Chat"].tap()

        app.staticTexts["Ayesha (KeyWorker)"].tap()

        let textField = app.textFields["Type a message..."]
        XCTAssertTrue(textField.waitForExistence(timeout: 3))

        textField.tap()
        textField.typeText("   ")

        let sendButton = app.buttons["sendButton"]
        sendButton.tap()

        let whitespaceBubble = app.staticTexts["   "]
        XCTAssertFalse(whitespaceBubble.exists,
                       "Whitespace-only messages should not be sent")
    }

    func test_profileView_showsGuardianInfo() {
        app.tabBars.buttons["Profile"].tap()

        XCTAssertTrue(app.staticTexts["Nathali Perera"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["Primary Guardian • Nethan's Mom"].exists,
                      "Subtitle should show guardian role")
    }

    func test_profileView_showsEmergencyContact() {
        app.tabBars.buttons["Profile"].tap()

        let emergencyTitle = app.staticTexts["Emergency Contacts"]
        XCTAssertTrue(emergencyTitle.waitForExistence(timeout: 3),
                      "Emergency Contacts card should be visible")

        XCTAssertTrue(app.staticTexts["Nadan Perera"].exists,
                      "Father's name should be displayed")
    }

    func test_profileView_showsMedicalInfo() {
        app.tabBars.buttons["Profile"].tap()

        let medicalTitle = app.staticTexts["Medical Information"]
        XCTAssertTrue(medicalTitle.waitForExistence(timeout: 3),
                      "Medical Information card should be visible")

        XCTAssertTrue(app.staticTexts["Asthma inhaler (Blue)"].exists,
                      "Medical details should be listed")
    }

    func test_profileView_showsDietaryPreferences() {
        app.tabBars.buttons["Profile"].tap()

        let dietaryTitle = app.staticTexts["Dietary Preferences"]
        XCTAssertTrue(dietaryTitle.waitForExistence(timeout: 3),
                      "Dietary Preferences card should be visible")

        XCTAssertTrue(app.staticTexts["No Dairy"].exists)
        XCTAssertTrue(app.staticTexts["Egg Allergy"].exists)
        XCTAssertTrue(app.staticTexts["Vegetarian"].exists)
    }

    func test_profileView_showsAccountSettings() {
        app.tabBars.buttons["Profile"].tap()

        let settingsHeader = app.staticTexts["ACCOUNT SETTINGS"]
        XCTAssertTrue(settingsHeader.waitForExistence(timeout: 3))

        XCTAssertTrue(app.staticTexts["Privacy & Security"].exists)
        XCTAssertTrue(app.staticTexts["Settings"].exists)
        XCTAssertTrue(app.staticTexts["Sign Out"].exists)
    }
}
