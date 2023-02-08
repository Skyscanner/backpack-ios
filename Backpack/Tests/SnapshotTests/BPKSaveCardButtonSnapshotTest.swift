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
import Backpack

import SnapshotTesting

class BPKSaveCardButtonSnapshotTest: XCTestCase {

    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    private let buttonStylesAndSizes: [(BPKCardButtonStyle, BPKCardButtonSize)] = [
        (.default, .default),
        (.default, .small),
        (.contained, .default),
        (.contained, .small),
        (.onDark, .default),
        (.onDark, .small)
    ]

    private func buttonBackgroundColor(for style: BPKCardButtonStyle) -> UIColor {
        switch style {
        case .default:
            return BPKColor.surfaceDefaultColor
        case .contained:
            return BPKColor.surfaceHighlightColor
        case .onDark:
            return BPKColor.black
        }
    }

    private func createViewWithTypes(checked: Bool) -> UIView {
        viewsInStack(withStyles: buttonStylesAndSizes) { (style, size) in
            let cardButton = BPKSaveCardButton(
                checked: checked,
                accessibilityLabel: "",
                style: style,
                size: size,
                onCheckedChange: { _ in }
            )
            cardButton.backgroundColor = buttonBackgroundColor(for: style)
            return cardButton
        }
    }

    func testUncheckedSaveCardButtonSnapshot() {
        let saveButtons = createViewWithTypes(checked: false)
        assertSnapshot(saveButtons)
    }

    func testCheckedSaveCardButtonSnapshot() {
        let saveButtons = createViewWithTypes(checked: true)
        assertSnapshot(saveButtons)
    }
}
