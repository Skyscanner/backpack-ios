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

class BPKLabelSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    // iPhone X dimensions
    private let deviceFrame = CGRect(x: 0, y: 0, width: 375, height: 812)
    
    private var parentView: UIView {
        let parent = UIView(frame: deviceFrame)
        parent.backgroundColor = BPKColor.skyGrayTint06
        return parent
    }
    
    private var stackView: UIStackView {
        let stack = UIStackView(frame: deviceFrame)
        stack.axis = .vertical
        stack.distribution = .equalCentering
        return stack
    }
    
    private func createView(withStyles styles: [BPKFontStyle]) -> UIView {
        let stack = stackView
        styles.map {
            let label = BPKLabel(fontStyle: $0)
            label.text = "Backpack Rocks"
            return label
        }.forEach(stack.addArrangedSubview)
        let parent = parentView
        parent.addSubview(stack)
        return parent
    }
    
    func testLabelsWithRegularFontStyles() {
        let styles: [BPKFontStyle] = .regularStyles
        BPKSnapshotVerifyViewLight(createView(withStyles: styles))
        BPKSnapshotVerifyViewDark(createView(withStyles: styles))
    }
    
    func testLabelsWithHeadingFontStyles() {
        let styles: [BPKFontStyle] = .headingStyles
        BPKSnapshotVerifyViewLight(createView(withStyles: styles))
        BPKSnapshotVerifyViewDark(createView(withStyles: styles))
    }
    
    func testLabelsWithHeroFontStyles() {
        let styles: [BPKFontStyle] = .heroStyles
        BPKSnapshotVerifyViewLight(createView(withStyles: styles))
        BPKSnapshotVerifyViewDark(createView(withStyles: styles))
    }
}
