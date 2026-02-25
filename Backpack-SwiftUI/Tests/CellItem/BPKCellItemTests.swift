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

class BPKCellItemTests: XCTestCase {

    // MARK: - US1: Basic Cell Item Display

    func test_titleOnly() {
        assertSnapshot(
            BPKCellItem(title: "Settings")
                .frame(width: 375)
                .padding(.sm)
        )
    }

    func test_titleAndBody() {
        assertSnapshot(
            BPKCellItem(
                title: "Flight updates",
                body: "Get notified about your flight status"
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    func test_titleAndIcon() {
        assertSnapshot(
            BPKCellItem(
                title: "Notifications",
                icon: .alertActive
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    func test_titleBodyIcon() {
        assertSnapshot(
            BPKCellItem(
                title: "Flight updates",
                body: "Get notified about your flight status",
                icon: .alertActive
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    // MARK: - US2: Styling Variants

    func test_surfaceLowContrast() {
        assertSnapshot(
            BPKCellItem(
                title: "Settings",
                style: .surfaceLowContrast
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    func test_roundedCorners() {
        assertSnapshot(
            BPKCellItem(
                title: "Settings",
                corner: .rounded
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    // MARK: - US4: Slot Content - Chevron

    func test_slotChevron() {
        assertSnapshot(
            BPKCellItem(
                title: "Account settings",
                slot: .chevron
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    // MARK: - US5: Slot Content - Switch

    func test_slotSwitchOn() {
        assertSnapshot(
            BPKCellItem(
                title: "Push notifications",
                slot: .switch(isOn: .constant(true))
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    func test_slotSwitchOff() {
        assertSnapshot(
            BPKCellItem(
                title: "Push notifications",
                slot: .switch(isOn: .constant(false))
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    // MARK: - US6: Slot Content - Text

    func test_slotText() {
        assertSnapshot(
            BPKCellItem(
                title: "Currency",
                slot: .text("GBP")
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    // MARK: - US7: Slot Content - Link

    func test_slotLink() {
        assertSnapshot(
            BPKCellItem(
                title: "Terms and conditions",
                slot: .link(text: "View", url: "https://example.com", action: { _ in })
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    // MARK: - US8: Slot Content - Image

    func test_slotImage() {
        let testImage = Image(systemName: "star.fill")
        assertSnapshot(
            BPKCellItem(
                title: "Partner logo",
                slot: .image(testImage)
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    // MARK: - Combined Variants

    func test_fullContent_withChevron() {
        assertSnapshot(
            BPKCellItem(
                title: "Flight updates",
                body: "Get notified about your flight status",
                icon: .alertActive,
                style: .surfaceLowContrast,
                corner: .rounded,
                slot: .chevron
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }

    func test_fullContent_withSwitch() {
        assertSnapshot(
            BPKCellItem(
                title: "Push notifications",
                body: "Receive updates on your device",
                icon: .alertActive,
                slot: .switch(isOn: .constant(true))
            )
            .frame(width: 375)
            .padding(.sm)
        )
    }
}
