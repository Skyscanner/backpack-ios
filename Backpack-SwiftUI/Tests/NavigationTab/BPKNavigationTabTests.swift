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

class BPKNavigationTabTests: XCTestCase {
    func test_textNavigationTab() {
        assertSnapshot(
            VStack {
                BPKNavigationTab("Option") {}
                BPKNavigationTab("Option", style: .onDark) {}
                    .padding()
                    .background(.surfaceContrastColor)
            }.padding()
        )
    }

    func test_navigationTabWithIcon() {
        assertSnapshot(
            VStack {
                BPKNavigationTab("Option", icon: .account) {}
                BPKNavigationTab("Option", icon: .account, style: .onDark) {}
                    .padding()
                    .background(.surfaceContrastColor)
            }.padding()
        )
    }
    
    func test_navigationTabSelected() {
        assertSnapshot(
            VStack {
                BPKNavigationTab("Selected", icon: .account, selected: true) {}
                BPKNavigationTab("Selected", icon: .account, selected: true, style: .onDark) {}
                    .padding()
                    .background(.surfaceContrastColor)
            }.padding()
        )
    }
}
