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

class BPKNavigationTabGroupTests: XCTestCase {
    
    private let tabs: [BPKNavigationTabGroup.Item] = [
        .init(text: "Explore", icon: .explore),
        .init(text: "Flights", icon: .flight),
        .init(text: "Hotels", icon: .hotels),
        .init(text: "Car Hire", icon: .cars)
    ]
    
    func test_default() {
        assertSnapshot(
            VStack {
                BPKNavigationTabGroup(
                    tabs: tabs,
                    selectedIndex: .constant(0),
                    onItemClick: { _ in }
                )
                .padding()
            }
                .frame(width: 300)
        )
    }
    
    func test_dark() {
        assertSnapshot(
            VStack {
                BPKNavigationTabGroup(
                    tabs: tabs,
                    style: .onDark,
                    selectedIndex: .constant(0),
                    onItemClick: { _ in }
                )
                .padding()
                .background(.surfaceContrastColor)
            }
                .frame(width: 300)
        )
    }
}
