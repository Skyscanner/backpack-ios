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

class BPKBottomSheetTests: XCTestCase {
    func test_fullSize_bottom_sheet() {
        assertSnapshot(
            BPKButton("Show bottom sheet", action: {})
                .bpkBottomSheet(
                    isPresented: .constant(true),
                    maxHeight: 400,
                    bottomSheetContent: {
                        Spacer()
                        BPKText("This this bottom sheet content")
                        Spacer()
                    })
                .frame(width: 300, height: 500)
        )
    }
    
    func test_regular_bottom_sheet() {
        assertSnapshot(
            BPKButton("Show bottom sheet", action: {})
                .bpkCloseableBottomSheet(
                    isPresented: .constant(true),
                    maxHeight: 400,
                    closeButtonAccessibilityLabel: "Close botton",
                    title: "Title",
                    action: BPKBottomSheetAction(title: "Action", action: {}),
                    bottomSheetContent: {
                        Spacer()
                        BPKText("This this bottom sheet content")
                        Spacer()
                    })
                .frame(width: 300, height: 500)
        )
    }
    
    func test_minHeight_bottom_sheet() {
        assertSnapshot(
            BPKButton("Show bottom sheet", action: {})
                .bpkBottomSheet(
                    isPresented: .constant(true),
                    maxHeight: 400,
                    minHeight: 200,
                    bottomSheetContent: {
                        Spacer()
                        BPKText("This this bottom sheet content")
                        Spacer()
                    })
                .frame(width: 300, height: 500)
        )
    }
}
