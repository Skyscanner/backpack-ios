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
    func test_givenFirstAndReturningVisits_whenOpeningInformation_thenPreservesSwitchValue() {
        // Given
        let robot = SwitchTooltipRobot(app: app)
        robot.navigate()
        robot.open()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        XCTAssertFalse(robot.information.exists)
        robot.capture("Switch tooltip - first visit")
        let value = robot.control.value as? String
        let firstControlFrame = robot.control.frame
        let firstContentFrame = robot.contentBelowSwitch.frame
        XCTAssertNotNil(value)

        // When / Then
        robot.dismiss()
        XCTAssertFalse(robot.message.exists)
        XCTAssertEqual(robot.control.frame, firstControlFrame)
        XCTAssertEqual(robot.contentBelowSwitch.frame, firstContentFrame)
        XCTAssertEqual(robot.control.value as? String, value)
        robot.close()
        robot.open()
        XCTAssertFalse(robot.message.exists)
        XCTAssertTrue(robot.information.exists)
        XCTAssertLessThanOrEqual(robot.information.frame.maxX, robot.control.frame.minX)
        XCTAssertEqual(robot.control.label, "Include nearby airports")
        robot.capture("Switch tooltip - subsequent visit")

        let controlFrame = robot.control.frame
        let contentFrame = robot.contentBelowSwitch.frame
        XCTAssertGreaterThanOrEqual(robot.information.frame.width, 44)
        XCTAssertGreaterThanOrEqual(robot.information.frame.height, 44)
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))
        XCTAssertEqual(robot.control.frame, controlFrame)
        XCTAssertEqual(robot.contentBelowSwitch.frame, contentFrame)
        XCTAssertEqual(
            robot.message.label,
            "Find cheaper flights by including nearby airports in your search."
        )
        XCTAssertEqual(robot.control.value as? String, value)
        robot.capture("Switch tooltip - information reopened")

        robot.information.tap()
        XCTAssertFalse(robot.message.exists)
        XCTAssertEqual(robot.control.value as? String, value)
        XCTAssertEqual(robot.contentBelowSwitch.frame, contentFrame)
        robot.information.tap()
        XCTAssertTrue(robot.message.waitForExistence(timeout: 5))

        robot.toggle()
        let changed = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "value != %@", value ?? ""), object: robot.control
        )
        XCTAssertEqual(XCTWaiter.wait(for: [changed], timeout: 5), .completed)
        robot.dismiss()
        XCTAssertFalse(robot.message.exists)
    }
}

@MainActor
private final class SwitchTooltipRobot {
    private let app: XCUIApplication
    var message: XCUIElement { app.staticTexts["BPKSwitch.Tooltip.Message"] }
    var information: XCUIElement { app.buttons["BPKSwitch.Tooltip.Information"] }
    var control: XCUIElement { app.switches.firstMatch }
    var contentBelowSwitch: XCUIElement { app.staticTexts["SwitchExample.ContentBelowSwitch"] }

    init(app: XCUIApplication) { self.app = app }

    func navigate() {
        let switches = app.tables.staticTexts["Switches"]
        XCTAssertTrue(switches.waitForExistence(timeout: 5))
        for _ in 0..<8 where !switches.isHittable { app.swipeUp() }
        switches.tap()
        app.tabBars.buttons["SwiftUI"].tap()
    }

    func open() { app.buttons["SwitchExample.OpenTooltip"].tap() }
    func close() { app.buttons["SwitchExample.CloseTooltip"].tap() }
    func dismiss() { app.buttons["BPKSwitch.Tooltip.Dismiss"].tap() }

    func toggle() {
        control.tap()
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
