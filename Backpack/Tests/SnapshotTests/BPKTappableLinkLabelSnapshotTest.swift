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

class BPKTappableLinkLabelSnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    private func createView(
        withStyles styles: [BPKFontStyle],
        textColor: UIColor? = nil,
        linkColor: UIColor? = nil,
        backgroundColor: UIColor = BPKColor.surfaceContrastColor,
        tappableLabelStyle: BPKTappableLinkLabelStyle? = nil
    ) -> UIView {
        viewsInStack(withStyles: styles, backgroundColor: backgroundColor) { style in
            let label = BPKTappableLinkLabel(fontStyle: style)
            label.text = "Backpack Rocks"
            label.addLink(
                to: URL(string: "https://skyscanner.design/")!,
                with: NSRange(location: 0, length: 8)
            )
            if let color = textColor { label.textColor = color }
            if let linkColor = linkColor {
                label.linkColor = linkColor
            }
            if let tappableLabelStyle = tappableLabelStyle {
                label.style = tappableLabelStyle
            }
            return label
        }
    }
    
    func testTappableLinkLabelWithRegularFontStyles() {
        assertSnapshot(createView(withStyles: .regularStyles))
    }
    
    func testTappableLinkLabelWithHeadingFontStyles() {
        assertSnapshot(createView(withStyles: .headingStyles))
    }
    
    func testTappableLinkLabelWithHeroFontStyles() {
        assertSnapshot(createView(withStyles: .heroStyles))
    }
    
    func testViewSnapshotWithAlternateStyle() {
        assertSnapshot(createView(
            withStyles: .regularStyles,
            backgroundColor: BPKColor.coreAccentColor,
            tappableLabelStyle: .alternate
        ))
    }
    
    func testViewSnapshotWithThemeApplied() {
        assertSnapshot(createView(
            withStyles: .headingStyles,
            linkColor: .orange
        ))
    }
    
    func testViewSnapshotWithColorApplied() {
        assertSnapshot(createView(
            withStyles: .headingStyles,
            textColor: BPKColor.statusDangerSpotColor
        ))
    }
}
