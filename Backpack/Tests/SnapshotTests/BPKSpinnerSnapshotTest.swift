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

class BPKSpinnerSnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    private var allStyles: [BPKSpinnerStyle] = [
        .textPrimary,
        .disabled,
        .onDarkSurface
    ]
    
    private var allSizes: [BPKSpinnerSize] = [
        .sm,
        .lg,
        .xl
    ]
    
    private func createView(themed: Bool = false) -> UIView {
        viewsInStack(withStyles: allStyles) { style in
            viewsInStack(withStyles: allSizes) { size in
                let spinner = BPKSpinner(style: style, size: size)
                if themed {
                    spinner.primaryColor = BPKColor.coreEcoColor
                }
                spinner.hidesWhenStopped = false
                return spinner
            }
        }
    }
    
    func testSpinnerSizesNotThemed() {
        assertSnapshot(createView())
    }
    
    func testSpinnerSizesThemed() {
        assertSnapshot(createView(themed: true))
    }
}
