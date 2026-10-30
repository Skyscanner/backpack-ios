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
