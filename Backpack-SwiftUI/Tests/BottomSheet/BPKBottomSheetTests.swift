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
    func test_bottomSheetHeader_titleOnly() {
        assertSnapshot(
            BottomSheetHeader(closeAction: nil, title: "Title Here", action: nil)
                .frame(width: 300)
        )
    }
    
    func test_bottomSheetHeader_titleAndAction() {
        assertSnapshot(
            BottomSheetHeader(closeAction: nil, title: "Title Here", action: .init(title: "Do Action", action: {}))
                .frame(width: 300)
        )
    }
    
    func test_bottomSheetHeader_titleClosable() {
        assertSnapshot(
            BottomSheetHeader(closeAction: .init(title: "a11y label", action: {}), title: "Title Here", action: nil)
                .frame(width: 300)
        )
    }
    
    func test_bottomSheetHeader() {
        assertSnapshot(
            BottomSheetHeader(
                closeAction: .init(title: "a11y", action: {}),
                title: "Title Here",
                action: .init(title: "Do Action", action: {})
            )
            .frame(width: 300)
        )
    }
}
