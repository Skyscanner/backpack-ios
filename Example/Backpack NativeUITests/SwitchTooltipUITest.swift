/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2026 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import XCTest

final class SwitchTooltipUITest: BackpackUITestCase {
    @MainActor
    func test_givenTooltipDisabled_whenOpeningAndReopeningHelp_thenPreservesChoiceAndLayout() {
        // Given
        launch()
        let robot = SwitchTooltipRobot(app: app)
        robot.navigate()
        robot.open()
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        XCTAssertFalse(robot.message.exists)
        let value = robot.control.value as? String
        let controlFrame = robot.control.frame
        let contentFrame = robot.contentBelowSwitch.frame
        XCTAssertNotNil(value)
        XCTAssertGreaterThanOrEqual(robot.information.frame.width, 44)
        XCTAssertGreaterThanOrEqual(robot.information.frame.height, 44)
        robot.capture("nearby-help-persistent-light")

        // When / Then
        for _ in 0..<2 {
            robot.information.tap()
            XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
            XCTAssertEqual(robot.message.label, SwitchTooltipRobot.copy)
            robot.capture("nearby-help-sheet-light")
            robot.dismiss()
            robot.waitForHelpToDisappear()
            XCTAssertEqual(robot.control.value as? String, value)
            XCTAssertEqual(robot.control.frame, controlFrame)
            XCTAssertEqual(robot.contentBelowSwitch.frame, contentFrame)
        }
        robot.control.tap()
        robot.assertChoiceDiffers(from: value)
        let changed = robot.control.value as? String
        robot.close()
        robot.open()
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        XCTAssertEqual(robot.control.value as? String, changed)
    }

    @MainActor
    func test_givenNativeIntroduction_whenDismissed_thenPersistentHelpStillOpensAfterRelaunch() {
        // Given
        launch(reset: true)
        let robot = SwitchTooltipRobot(app: app)
        robot.navigate()
        app.switches["SwitchExample.NativeTooltipEnabled"].tap()
        robot.open()
        let tipMessage = app.staticTexts[SwitchTooltipRobot.copy].firstMatch
        let tipAppeared = tipMessage.waitForExistence(timeout: 8)
        robot.capture("nearby-help-native-introduction")
        XCTAssertTrue(tipAppeared)
        XCTAssertTrue(robot.information.exists)

        // When: Apple's close button dismisses the once-only introduction.
        let close = app.buttons.matching(NSPredicate(format: "label == 'Close' OR label == 'Dismiss'")).firstMatch
        XCTAssertTrue(close.waitForExistence(timeout: 5))
        close.tap()
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        XCTAssertEqual(robot.message.label, SwitchTooltipRobot.copy)
        robot.dismiss()
        robot.waitForHelpToDisappear()

        // Then: the same native tip stays dismissed, while the bottom sheet stays available.
        app.terminate()
        app.launchArguments.removeAll { $0 == "SWITCH_INFORMATION_RESET" }
        app.launch()
        robot.navigate()
        app.switches["SwitchExample.NativeTooltipEnabled"].tap()
        robot.open()
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        XCTAssertFalse(tipMessage.waitForExistence(timeout: 2))
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
    }

    @MainActor
    func test_givenNativeIntroduction_whenSelectingInformationAction_thenOpensSameSheet() {
        // Given
        launch(reset: true)
        let robot = SwitchTooltipRobot(app: app)
        robot.navigate()
        app.switches["SwitchExample.NativeTooltipEnabled"].tap()
        robot.open()
        XCTAssertTrue(app.staticTexts[SwitchTooltipRobot.copy].firstMatch.waitForExistence(timeout: 8))
        let value = robot.control.value as? String

        // When: use the action inside Apple's native tip, rather than a background tap.
        let action = app.buttons.matching(NSPredicate(format: "label == 'About nearby airports'"))
            .allElementsBoundByIndex
            .first { $0.identifier != "BPKSwitch.Information" }
        XCTAssertNotNil(action)
        action?.tap()

        // Then
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        XCTAssertEqual(robot.message.label, SwitchTooltipRobot.copy)
        robot.capture("nearby-help-sheet-from-native-tip")
        robot.dismiss()
        robot.waitForHelpToDisappear()
        XCTAssertEqual(robot.control.value as? String, value)
    }

    @MainActor
    func test_givenDarkThemeAndLargestText_whenOpeningHelp_thenKeepsContentScrollable() {
        // Given
        launch(dark: true, largerText: true)
        let robot = SwitchTooltipRobot(app: app)
        robot.navigate()
        robot.open()
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        robot.capture("nearby-help-persistent-dark-large-text")
        // When / Then
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        XCTAssertEqual(robot.message.label, SwitchTooltipRobot.copy)
        robot.capture("nearby-help-sheet-dark-large-text")
        robot.dismiss()
        robot.waitForHelpToDisappear()
        XCTAssertTrue(robot.information.exists)
    }

    @MainActor
    private func launch(reset: Bool = false, dark: Bool = false, largerText: Bool = false) {
        app.terminate()
        // Normal animations exercise real sheet and native-tip presentation.
        app.launchArguments = [dark ? "FORCE_DARK_MODE" : "FORCE_LIGHT_MODE"]
        if reset { app.launchArguments.append("SWITCH_INFORMATION_RESET") }
        if largerText {
            app.launchArguments += ["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityXXXL"]
        }
        app.launch()
    }
}

@MainActor
private final class SwitchTooltipRobot {
    static let copy = "Find cheaper flights by including nearby airports in your search."
    private let app: XCUIApplication
    var message: XCUIElement { app.staticTexts["BPKSwitch.Information.Message"] }
    var information: XCUIElement { app.buttons["BPKSwitch.Information"] }
    var control: XCUIElement {
        app.switches.matching(NSPredicate(format: "label == 'Include nearby airports'")).firstMatch
    }
    var contentBelowSwitch: XCUIElement { app.staticTexts["SwitchExample.ContentBelowSwitch"] }

    init(app: XCUIApplication) { self.app = app }

    func navigate() {
        let switches = app.tables.staticTexts["Switches"]
        XCTAssertTrue(switches.waitForExistence(timeout: 5))
        for _ in 0..<8 where !switches.isHittable { app.swipeUp() }
        switches.tap()
        app.tabBars.buttons["SwiftUI"].tap()
    }

    func open() {
        let button = app.buttons["SwitchExample.OpenTooltip"]
        for _ in 0..<5 where !button.isHittable { app.swipeDown() }
        button.tap()
    }
    func close() { app.buttons["SwitchExample.CloseTooltip"].tap() }
    func dismiss() { app.buttons["Close information"].tap() }

    func waitForHelpToDisappear() {
        let gone = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: message)
        XCTAssertEqual(XCTWaiter.wait(for: [gone], timeout: 5), .completed)
    }

    func assertChoiceDiffers(from value: String?) {
        let changed = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "value != %@", value ?? ""), object: control
        )
        XCTAssertEqual(XCTWaiter.wait(for: [changed], timeout: 5), .completed)
    }

    func capture(_ name: String) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        XCTContext.runActivity(named: name) { $0.add(attachment) }
    }
}
