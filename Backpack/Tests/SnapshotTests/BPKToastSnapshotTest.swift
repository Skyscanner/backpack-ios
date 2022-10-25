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
import Backpack
import SnapshotTesting

class BPKToastSnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    private func create(toastMode: BPKToastMode) -> UIView {
        let parent = UIView(frame: UIScreen.main.bounds)
        let toast = BPKToast.showAdded(
            to: parent,
            animated: false,
            accessibilityAnnouncement: "Saving your changes"
        )
        toast.mode = toastMode
        toast.labelText = "Toast Title Text"
        toast.detailsLabelText = "Toast detail text"

        return parent
    }

    func testToastWithTextMode() {
        assertSnapshot(create(toastMode: .text))
    }

    func testToastWithDefaultMode() {
        assertSnapshot(create(toastMode: .indeterminate))
    }
}
