/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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
import SwiftUI
@testable import Backpack_SwiftUI

class BPKSwitchTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        try requireSnapshotHost()
    }

    func test_givenNoInformation_whenOptingInWithNil_thenPreservesStandardSwitch() {
        assertSnapshot(
            BPKSwitch(isOn: .constant(false), text: "Test")
                .experimentalInformation(nil, tooltip: .init(id: "unused"))
                .padding(.sm),
            drawHierarchyInKeyWindow: true,
            testName: "testSwitchOffState"
        )
    }

    func test_givenInformation_whenTooltipDisabled_thenShowsPersistentInfoButton() {
        assertSnapshot(
            informationSwitch(),
            drawHierarchyInKeyWindow: true
        )
    }

    func test_givenInformation_whenTextSizeIncreases_thenLabelAndButtonRemainSeparate() {
        assertA11ySnapshot(
            informationSwitch(), customHeight: 1200,
            drawHierarchyInKeyWindow: true
        )
    }

    private func informationSwitch() -> some View {
        VStack(alignment: .leading, spacing: .md) {
            BPKSwitch(isOn: .constant(false), text: "Include nearby airports", truncate: false)
                .experimentalInformation(.init(
                    title: "Nearby airports",
                    message: "Find cheaper flights by including nearby airports in your search.",
                    informationAccessibilityLabel: "About nearby airports",
                    dismissAccessibilityLabel: "Close information"
                ))
            BPKText("Search suggestions stay in place")
            Spacer(minLength: 0)
        }
        .padding(.md)
        .frame(width: 375, height: 300)
        .background(.surfaceDefaultColor)
    }

    func testSwitchOnState() {
        assertSnapshot(
            BPKSwitch(isOn: .constant(true), text: "Test").padding(.sm),
            drawHierarchyInKeyWindow: true
        )
    }
    
    func testSwitchOffState() {
        assertSnapshot(
            BPKSwitch(isOn: .constant(false), text: "Test").padding(.sm),
            drawHierarchyInKeyWindow: true
        )
    }

    func testSwitchTruncatedByDefault() {
        assertSnapshot(
            BPKSwitch(isOn: .constant(false), text: "line 1\n line 2").padding(.sm),
            drawHierarchyInKeyWindow: true
        )
    }
    
    func testSwitchOnContrastStyleOn() {
        assertSnapshot(
            BPKSwitch(isOn: .constant(true), text: "Test", style: .onContrast),
            drawHierarchyInKeyWindow: true
        )
    }
    
    func testSwitchOnContrastStyleOff() {
        assertSnapshot(
            BPKSwitch(isOn: .constant(false), text: "Test", style: .onContrast),
            drawHierarchyInKeyWindow: true
        )
    }

    func testSwitchTruncatedFalse() {
        assertSnapshot(
            BPKSwitch(
                isOn: .constant(false),
                text: "line 1\n line 2",
                truncate: false
            ).padding(.sm),
            drawHierarchyInKeyWindow: true
        )
    }
    func testSwitchDisabledOnState() {
        assertSnapshot(
            BPKSwitch(
                isOn: .constant(true),
                text: "Test",
                enabled: false
            )
            .padding(.sm),
            drawHierarchyInKeyWindow: true
        )
    }

    func testSwitchDisabledOffState() {
        assertSnapshot(
            BPKSwitch(
                isOn: .constant(false),
                text: "Test",
                enabled: false
            )
            .padding(.sm),
            drawHierarchyInKeyWindow: true
        )
    }

    func testSwitchOnContrastDisabledOn() {
        assertSnapshot(
            BPKSwitch(
                isOn: .constant(true),
                text: "Test",
                enabled: false,
                style: .onContrast
            )
            .padding(.sm)
            .background(Color(.surfaceContrastColor)),
            drawHierarchyInKeyWindow: true
        )
    }

    func testSwitchOnContrastDisabledOff() {
        assertSnapshot(
            BPKSwitch(
                isOn: .constant(false),
                text: "Test",
                enabled: false,
                style: .onContrast
            )
            .padding(.sm)
            .background(Color(.surfaceContrastColor)),
            drawHierarchyInKeyWindow: true
        )
    }

    func testSwitchAccessibility() {
        assertA11ySnapshot(
            BPKSwitch(
                isOn: .constant(true),
                text: "A switch label that can wrap over multiple lines",
                truncate: false
            ),
            drawHierarchyInKeyWindow: true
        )
    }

    func testSwitchAttributedText() {
        var text = AttributedString("Styled text")
        text.foregroundColor = Color(.coreAccentColor)

        assertSnapshot(
            BPKSwitch(
                isOn: .constant(true),
                text: text
            )
            .padding(.sm),
            drawHierarchyInKeyWindow: true
        )
    }
}
