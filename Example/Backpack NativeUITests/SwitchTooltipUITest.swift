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

final class TipKitAssessmentUITest: BackpackUITestCase {
    @MainActor
    private func launchAssessment(theme: String = "FORCE_LIGHT_MODE", accessibility: Bool = false) {
        app.terminate()
        app.launchArguments += ["TIPKIT_ASSESSMENT_RESET", theme]
        if accessibility {
            app.launchArguments += ["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityXXXL"]
        }
        app.launch()
    }

    @MainActor
    func test_givenBasicDemoLaunch_whenTappingSwitchBehindTip_thenRecordsDefaultInteraction() {
        // Given
        app.launchArguments.removeAll { $0 == "UITests" }
        app.launchArguments.append("TIPKIT_ASSESSMENT_BASIC")
        launchAssessment()
        let robot = TipKitAssessmentRobot(app: app)
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        XCTAssertFalse(robot.information.exists)
        XCTAssertTrue(robot.control.waitForExistence(timeout: 5))
        let value = robot.control.value as? String
        let frame = robot.control.frame
        XCTAssertEqual(value, "0")
        robot.capture("basic-tipkit-direct-launch")

        // When
        robot.tap(frame)

        // Then: measure the default API rather than assuming background taps are forwarded.
        let gone = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: robot.message)
        let dismissed = XCTWaiter.wait(for: [gone], timeout: 3) == .completed
        let changed = robot.control.value as? String != value
        print("TIPKIT_BASIC_SWITCH_CHANGED_ON_FIRST_BACKGROUND_TAP=\(changed)")
        print("TIPKIT_BASIC_DISMISSED_ON_BACKGROUND_TAP=\(dismissed)")
        robot.capture("basic-tipkit-after-background-tap")
        if !dismissed { robot.closeSystemTip() }
        robot.closeSelector()
        robot.openSelector("To")
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        robot.information.tap()
        XCTAssertFalse(robot.message.waitForExistence(timeout: 2))
    }

    @MainActor
    func test_givenClosedTipKitIntroduction_whenOpeningInformation_thenRemainsPermanentlyDismissed() {
        // Given
        launchAssessment()
        let robot = TipKitAssessmentRobot(app: app)
        robot.navigate()
        robot.openAssessment("TipKit")
        robot.openSelector("From")
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("tipkit-first-visit-light")
        robot.closeSystemTip()
        robot.closeSelector()
        XCTAssertTrue(robot.status.waitForExistence(timeout: 5))
        XCTAssertTrue(robot.status.label.contains("Permanently dismissed"))

        // When
        robot.openSelector("To")
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        robot.information.tap()

        // Then: this is the framework limitation being assessed, not the desired product behaviour.
        XCTAssertFalse(robot.message.waitForExistence(timeout: 2))
        robot.capture("tipkit-cannot-reopen-after-close")
        app.terminate()
        app.launchArguments.removeAll { $0 == "TIPKIT_ASSESSMENT_RESET" }
        app.launch()
        robot.navigate()
        robot.openAssessment("TipKit")
        robot.openSelector("From")
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        XCTAssertFalse(robot.message.exists)
    }

    @MainActor
    func test_givenNativePopover_whenReopeningInformation_thenPreservesChoiceAndLayout() {
        // Given
        launchAssessment()
        let robot = TipKitAssessmentRobot(app: app)
        robot.navigate()
        robot.openAssessment("Popover")
        robot.openSelector("From")
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("native-popover-first-visit-light")
        robot.dismissPopover()
        robot.closeSelector()
        robot.openSelector("To")
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        XCTAssertFalse(robot.message.exists)
        let value = robot.control.value as? String
        let controlFrame = robot.control.frame
        let contentFrame = robot.content.frame
        let informationFrame = robot.information.frame
        XCTAssertGreaterThanOrEqual(informationFrame.width, 44)
        XCTAssertGreaterThanOrEqual(informationFrame.height, 44)

        // When / Then
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("native-popover-information-light")
        robot.tap(informationFrame)
        robot.waitForMessageToDisappear()
        XCTAssertEqual(robot.control.value as? String, value)
        XCTAssertEqual(robot.control.frame, controlFrame)
        XCTAssertEqual(robot.content.frame, contentFrame)
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.tap(controlFrame)
        robot.waitForMessageToDisappear()
        let changedOnFirstTap = robot.control.value as? String != value
        print("TIPKIT_ASSESSMENT_SWITCH_CHANGED_ON_FIRST_BACKGROUND_TAP=\(changedOnFirstTap)")
        if !changedOnFirstTap { robot.control.tap() }
        XCTAssertNotEqual(robot.control.value as? String, value)
        robot.closeSelector()

        app.terminate()
        app.launchArguments.removeAll { $0 == "TIPKIT_ASSESSMENT_RESET" }
        app.launch()
        robot.navigate()
        robot.openAssessment("Popover")
        robot.openSelector("From")
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        XCTAssertFalse(robot.message.exists)
    }

    @MainActor
    func test_givenControlledTipKit_whenReopeningInformation_thenSupportsBackgroundSwitchAndPersistence() {
        // Given
        launchAssessment()
        let robot = TipKitAssessmentRobot(app: app)
        robot.navigate()
        guard #available(iOS 26.0, *) else {
            XCTAssertFalse(app.buttons["TipKitAssessment.OpenControlledTipKit"].exists)
            return
        }
        robot.openAssessment("ControlledTipKit")
        robot.openSelector("From")
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("controlled-tipkit-first-visit-light")
        robot.closeSystemTip()
        robot.closeSelector()
        robot.openSelector("To")
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        XCTAssertFalse(robot.message.exists)
        let value = robot.control.value as? String
        XCTAssertNotNil(value)
        let controlFrame = robot.control.frame
        let contentFrame = robot.content.frame
        let informationFrame = robot.information.frame

        // When / Then
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("controlled-tipkit-information-light")
        robot.tap(informationFrame)
        robot.waitForMessageToDisappear()
        XCTAssertEqual(robot.control.value as? String, value)
        XCTAssertEqual(robot.control.frame, controlFrame)
        XCTAssertEqual(robot.content.frame, contentFrame)
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.tap(controlFrame)
        let changed = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "value != %@", value ?? ""), object: robot.control
        )
        XCTAssertEqual(XCTWaiter.wait(for: [changed], timeout: 5), .completed)
        XCTAssertEqual(robot.content.frame, contentFrame)
        if robot.message.exists { robot.closeSystemTip() }
        robot.closeSelector()

        app.terminate()
        app.launchArguments.removeAll { $0 == "TIPKIT_ASSESSMENT_RESET" }
        app.launch()
        robot.navigate()
        robot.openAssessment("ControlledTipKit")
        robot.openSelector("From")
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        XCTAssertFalse(robot.message.exists)
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
    }

    @MainActor
    func test_givenVisibleControlledIntroduction_whenLeavingSelector_thenShowsInformationOnNextVisit() {
        // Given
        launchAssessment()
        let robot = TipKitAssessmentRobot(app: app)
        robot.navigate()
        guard #available(iOS 26.0, *) else {
            XCTAssertFalse(app.buttons["TipKitAssessment.OpenControlledTipKit"].exists)
            return
        }
        robot.openAssessment("ControlledTipKit")
        robot.openSelector("From")
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))

        // When: leave without pressing the tip's close button.
        robot.closeSelector()
        robot.openSelector("To")

        // Then
        XCTAssertTrue(robot.information.waitForExistence(timeout: 5))
        XCTAssertFalse(robot.message.exists)
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
    }

    @MainActor
    func test_givenControlledTipKitInDarkTheme_whenPresentingHelp_thenSupportsNativeDismissal() {
        // Given
        launchAssessment(theme: "FORCE_DARK_MODE")
        let robot = TipKitAssessmentRobot(app: app)
        robot.navigate()
        guard #available(iOS 26.0, *) else {
            XCTAssertFalse(app.buttons["TipKitAssessment.OpenControlledTipKit"].exists)
            return
        }
        robot.openAssessment("ControlledTipKit")
        robot.openSelector("From")
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("controlled-tipkit-first-visit-dark")
        robot.closeSystemTip()
        robot.closeSelector()

        // When / Then
        robot.openSelector("To")
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("controlled-tipkit-information-dark")
        robot.information.tap()
        robot.waitForMessageToDisappear()
    }

    @MainActor
    func test_givenLargestText_whenShowingNativePresentations_thenCapturesLayoutsAndAllowsDismissal() {
        // Given
        launchAssessment(accessibility: true)
        let robot = TipKitAssessmentRobot(app: app)
        robot.navigate()
        robot.openAssessment("TipKit")
        robot.openSelector("From")
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("tipkit-largest-text")
        robot.closeSystemTip()
        robot.closeSelector()
        robot.closeAssessment()

        // When / Then
        robot.openAssessment("Popover")
        robot.openSelector("From")
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("native-popover-largest-text")
        robot.dismissPopover()
        robot.closeSelector()
        robot.closeAssessment()
        if #available(iOS 26.0, *) {
            robot.openAssessment("ControlledTipKit")
            robot.openSelector("From")
            XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
            robot.capture("controlled-tipkit-largest-text")
            robot.closeSystemTip()
            robot.closeSelector()
        }
    }

    @MainActor
    func test_givenDarkTheme_whenShowingNativePresentations_thenCapturesBothAppearances() {
        // Given
        launchAssessment(theme: "FORCE_DARK_MODE")
        let robot = TipKitAssessmentRobot(app: app)
        robot.navigate()
        robot.openAssessment("TipKit")
        robot.openSelector("From")
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("tipkit-first-visit-dark")
        robot.closeSystemTip()
        robot.closeSelector()
        robot.closeAssessment()

        // When / Then
        robot.openAssessment("Popover")
        robot.openSelector("From")
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("native-popover-first-visit-dark")
        robot.dismissPopover()
        robot.closeSelector()
        robot.openSelector("To")
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        robot.capture("native-popover-information-dark")
    }
}

@MainActor
private final class TipKitAssessmentRobot {
    private let app: XCUIApplication
    private let copy = "Find cheaper flights by including nearby airports in your search."
    var message: XCUIElement { app.staticTexts[copy].firstMatch }
    var information: XCUIElement { app.buttons["TipKitAssessment.Information"] }
    var control: XCUIElement { app.switches["TipKitAssessment.Switch"] }
    var content: XCUIElement { app.staticTexts["TipKitAssessment.ContentBelowSwitch"] }
    var status: XCUIElement { app.staticTexts["TipKitAssessment.Status"] }

    init(app: XCUIApplication) { self.app = app }

    func navigate() {
        let switches = app.tables.staticTexts["Switches"]
        XCTAssertTrue(switches.waitForExistence(timeout: 5))
        for _ in 0..<8 where !switches.isHittable { app.swipeUp() }
        switches.tap()
        app.tabBars.buttons["SwiftUI"].tap()
    }

    func openAssessment(_ mode: String) { app.buttons["TipKitAssessment.Open\(mode)"].tap() }
    func openSelector(_ name: String) { app.buttons["TipKitAssessment.Open\(name)"].tap() }
    func closeSelector() { app.buttons["TipKitAssessment.CloseSelector"].tap() }
    func closeAssessment() { app.buttons["TipKitAssessment.CloseAssessment"].tap() }
    func dismissPopover() { app.buttons["TipKitAssessment.Dismiss"].tap() }

    func closeSystemTip() {
        let close = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] %@", "close")).firstMatch
        XCTAssertTrue(close.waitForExistence(timeout: 5), app.debugDescription)
        close.tap()
        waitForMessageToDisappear()
    }

    func waitForMessageToDisappear() {
        let gone = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: message)
        XCTAssertEqual(XCTWaiter.wait(for: [gone], timeout: 5), .completed)
    }

    func tap(_ frame: CGRect) {
        app.coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: frame.midX, dy: frame.midY)).tap()
    }

    func capture(_ name: String) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        XCTContext.runActivity(named: name) { $0.add(attachment) }
    }
}
