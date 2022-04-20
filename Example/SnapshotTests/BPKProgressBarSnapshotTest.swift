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

class BPKProgressBarSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    private func makeProgressBar(
        backgroundColor: UIColor? = nil,
        fillColor: UIColor? = nil
    ) -> BPKProgressBar {
        let progressBar = BPKProgressBar()
        if let backgroundColor = backgroundColor {
            progressBar.trackTintColor = backgroundColor
        }
        if let fillColor = fillColor {
            progressBar.fillColor = fillColor
        }
        
        let fittingSize = progressBar.systemLayoutSizeFitting(CGSize(width: 1000, height: 1000))
        progressBar.frame = CGRect(x: 0.0, y: 0.0, width: 200, height: fittingSize.height)
        progressBar.progress = 0.75
        return progressBar
    }
    
    func testSettingValue() {
        BPKSnapshotVerifyViewLight(makeProgressBar())
        BPKSnapshotVerifyViewDark(makeProgressBar())
    }
    
    func testOverridingBackgroundColor() {
        BPKSnapshotVerifyViewLight(makeProgressBar(backgroundColor: BPKColor.clear))
        BPKSnapshotVerifyViewDark(makeProgressBar(backgroundColor: BPKColor.clear))
    }
    
    func testTheme() {
        BPKSnapshotVerifyViewLight(makeProgressBar(fillColor: .purple))
        BPKSnapshotVerifyViewDark(makeProgressBar(fillColor: .purple))
    }
}
