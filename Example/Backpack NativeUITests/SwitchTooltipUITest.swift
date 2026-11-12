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
        // Simulator transforms can report 44 points as 43.999999999999986.
        let frameRoundingTolerance = 0.001
        XCTAssertGreaterThanOrEqual(robot.information.frame.width, 44 - frameRoundingTolerance)
        XCTAssertGreaterThanOrEqual(robot.information.frame.height, 44 - frameRoundingTolerance)
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
    func test_givenDismissedNativeTip_whenDraggingHelpDown_thenPreservesChoiceAndLayout() {
        // Given
        launch(reset: true)
        let robot = SwitchTooltipRobot(app: app)
        robot.navigate()
        app.switches["SwitchExample.NativeTooltipEnabled"].tap()
        robot.open()
        let tipMessage = app.staticTexts[SwitchTooltipRobot.copy].firstMatch
        XCTAssertTrue(tipMessage.waitForExistence(timeout: 8))
        robot.dismissIntroduction()

        for _ in 0..<2 {
            let value = robot.control.value as? String
            let controlFrame = robot.control.frame
            let contentFrame = robot.contentBelowSwitch.frame

            // When: cancel a partial drag, then fully dismiss the information sheet.
            robot.information.tap()
            XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
            robot.dragHelpDown(dismiss: false)
            XCTAssertTrue(robot.message.exists)
            robot.dragHelpDown(dismiss: true)
            robot.waitForHelpToDisappear()

            // Then: both on and off choices survive interactive dismissal.
            XCTAssertEqual(robot.control.value as? String, value)
            XCTAssertEqual(robot.control.frame, controlFrame)
            XCTAssertEqual(robot.contentBelowSwitch.frame, contentFrame)
            robot.capture("nearby-help-after-drag-\(value ?? "unknown")")
            robot.information.tap()
            XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
            robot.dismiss()
            robot.waitForHelpToDisappear()
            robot.toggleControl()
            robot.assertChoiceDiffers(from: value)
        }
    }

    @MainActor
    func test_givenNativeIntroduction_whenDismissed_thenPersistentHelpStillOpensAfterRelaunch() throws {
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
        // The foreground popover repeats the switch's label; select its title after the underlying label.
        let tipTitle = try XCTUnwrap(
            app.staticTexts.matching(identifier: "Include nearby airports").allElementsBoundByIndex.last
        )
        let controlFrame = robot.control.frame
        XCTAssertGreaterThan(controlFrame.height, 0)
        XCTAssertGreaterThan(
            tipTitle.frame.minY, controlFrame.maxY, "The native introduction must appear below the switch."
        )
        XCTAssertGreaterThan(tipMessage.frame.minY, controlFrame.maxY)
        let extraInformationActions = app.buttons.matching(NSPredicate(format: "label == 'About nearby airports'"))
            .allElementsBoundByIndex.filter { $0.identifier != "BPKSwitch.Information" }
        XCTAssertTrue(extraInformationActions.isEmpty, "The introduction has no extra action button.")

        // When: Apple's close button dismisses the once-only introduction.
        robot.dismissIntroduction()
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
    func test_givenDarkThemeAndLargestText_whenOpeningHelp_thenKeepsContentScrollable() {
        for largerText in [false, true] {
            // Given
            launch(dark: true, largerText: largerText)
            let robot = SwitchTooltipRobot(app: app)
            robot.navigate()
            robot.open()
            XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
            let suffix = largerText ? "dark-large-text" : "dark"
            robot.capture("nearby-help-persistent-\(suffix)")
            // When / Then
            robot.information.tap()
            XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
            XCTAssertEqual(robot.message.label, SwitchTooltipRobot.copy)
            robot.capture("nearby-help-sheet-\(suffix)")
            if largerText {
                app.scrollViews.containing(.staticText, identifier: "BPKSwitch.Information.Message")
                    .firstMatch.swipeUp()
                robot.capture("nearby-help-sheet-large-text-scrolled")
            }
            robot.dismiss()
            robot.waitForHelpToDisappear()
            XCTAssertTrue(robot.information.exists)
        }
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

    func toggleControl() {
        let frame = control.frame
        app.coordinate(withNormalizedOffset: .zero)
            .withOffset(CGVector(dx: frame.midX, dy: frame.midY)).tap()
    }

    func dismissIntroduction() {
        let close = app.buttons.matching(NSPredicate(format: "label == 'Close' OR label == 'Dismiss'")).firstMatch
        XCTAssertTrue(close.waitForExistence(timeout: 5))
        close.tap()
        let gone = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: app.staticTexts[Self.copy].firstMatch
        )
        XCTAssertEqual(XCTWaiter.wait(for: [gone], timeout: 5), .completed)
    }

    func dragHelpDown(dismiss: Bool) {
        let close = app.buttons["Close information"]
        let origin = app.coordinate(withNormalizedOffset: .zero)
        let start = origin.withOffset(CGVector(dx: app.frame.midX, dy: close.frame.midY))
        let end = dismiss ? origin.withOffset(CGVector(dx: app.frame.midX, dy: app.frame.maxY)) :
            start.withOffset(CGVector(dx: 0, dy: close.frame.height / 2))
        start.press(forDuration: 0.1, thenDragTo: end, withVelocity: .slow, thenHoldForDuration: 0.1)
    }

    func waitForHelpToDisappear() {
        let gone = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: message)
        XCTAssertEqual(XCTWaiter.wait(for: [gone], timeout: 5), .completed)
        let ready = XCTNSPredicateExpectation(predicate: NSPredicate(format: "hittable == true"), object: control)
        XCTAssertEqual(XCTWaiter.wait(for: [ready], timeout: 5), .completed)
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
