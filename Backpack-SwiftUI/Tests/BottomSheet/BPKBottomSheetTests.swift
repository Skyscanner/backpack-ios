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
    func test_default_bottom_sheet_medium() {
        assertSnapshot(
            Color(BPKColor.surfaceDefaultColor)
                .frame(width: 300, height: 500)
                .bpkBottomSheet(
                    isPresented: .constant(true),
                    contentMode: .medium,
                    bottomSheetContent: {
                        BPKText("This this bottom sheet content")
                    })
        )
    }
    
    func test_closeable_bottom_sheet_medium() {
        assertSnapshot(
            Color(BPKColor.surfaceDefaultColor)
                .frame(width: 300, height: 500)
                .bpkCloseableBottomSheet(
                    isPresented: .constant(true),
                    contentMode: .medium,
                    closeButtonAccessibilityLabel: "Close botton",
                    title: "Title",
                    action: BPKBottomSheetAction(title: "Action", action: {}),
                    bottomSheetContent: {
                        BPKText("This this bottom sheet content")
                    })
        )
    }
    
    func test_default_bottom_sheet_large() {
        assertSnapshot(
            Color(BPKColor.surfaceDefaultColor)
                .frame(width: 300, height: 500)
                .bpkBottomSheet(
                    isPresented: .constant(true),
                    contentMode: .large,
                    bottomSheetContent: {
                        BPKText("This this bottom sheet content")
                    })
        )
    }
    
    func test_closeable_bottom_sheet_large() {
        assertSnapshot(
            Color(BPKColor.surfaceDefaultColor)
                .frame(width: 300, height: 500)
                .bpkCloseableBottomSheet(
                    isPresented: .constant(true),
                    contentMode: .large,
                    closeButtonAccessibilityLabel: "Close botton",
                    title: "Title",
                    action: BPKBottomSheetAction(title: "Action", action: {}),
                    bottomSheetContent: {
                        BPKText("This this bottom sheet content")
                    })
        )
    }
}
