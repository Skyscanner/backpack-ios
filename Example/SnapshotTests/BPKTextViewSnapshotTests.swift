/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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
import FBSnapshotTestCase

class BPKTextViewSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    private func createView(withStyles styles: [BPKFontStyle], textColor: UIColor? = nil) -> UIView {
        viewsInStack(withStyles: styles) { style in
            let textView = BPKTextView(fontStyle: style)
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            textView.text = "Backpack Rocks"
            if let color = textColor { textView.textColor = color }
            return textView
        }
    }
    
    func testTextViewWithRegularFontStyles() {
        FBSnapshotVerifyView(createView(withStyles: .regularStyles))
    }
    
    func testTextViewWithHeadingFontStyles() {
        FBSnapshotVerifyView(createView(withStyles: .headingStyles))
    }
    
    func testTextViewWithThemeApplied() {
        BPKSnapshotVerifyViewLight(
            createView(
                withStyles: .regularStyles,
                textColor: .orange
            )
        )
    }
}
