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

class BPKLabelSnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    private func createView(withStyles styles: [BPKFontStyle]) -> UIView {
        viewsInStack(withStyles: styles) { style in
            let label = BPKLabel(fontStyle: style)
            label.text = "Backpack Rocks"
            return label
        }
    }
    
    func testLabelsWithRegularFontStyles() {
        let styles: [BPKFontStyle] = .regularStyles
        assertSnapshot(createView(withStyles: styles))
    }
    
    func testLabelsWithHeadingFontStyles() {
        let styles: [BPKFontStyle] = .headingStyles
        assertSnapshot(createView(withStyles: styles))
    }
    
    func testLabelsWithHeroFontStyles() {
        let styles: [BPKFontStyle] = .heroStyles
        assertSnapshot(createView(withStyles: styles))
    }
}
