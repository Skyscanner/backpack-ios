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

// swiftlint:disable closure_body_length
class BPKChipGroupTests: XCTestCase {
    func test_singleSelect_railChips_default() {
        assertSnapshot(
            VStack {
                BPKSingleSelectChipGroup(
                    chips: [
                        .init(text: "Barcelona"),
                        .init(text: "Tokio", icon: .city),
                        .init(text: "London"),
                        .init(text: "Shenzhen")
                    ],
                    style: .default,
                    selectedIndex: .constant(1),
                    type: .rail,
                    onItemClick: { _ in }
                )
                .padding()
                
                BPKSingleSelectChipGroup(
                    chips: [
                        .init(text: "Barcelona"),
                        .init(text: "Tokio", icon: .city),
                        .init(text: "London"),
                        .init(text: "Shenzhen")
                    ],
                    style: .onDark,
                    selectedIndex: .constant(1),
                    type: .rail,
                    onItemClick: { _ in }
                )
                .padding()
                .background(.surfaceContrastColor)
                
                BPKSingleSelectChipGroup(
                    chips: [
                        .init(text: "Barcelona"),
                        .init(text: "Tokio", icon: .city),
                        .init(text: "London"),
                        .init(text: "Shenzhen")
                    ],
                    style: .onImage,
                    selectedIndex: .constant(1),
                    type: .rail,
                    onItemClick: { _ in }
                )
                .padding()
                .background(.statusSuccessSpotColor)
            }
            .frame(width: 300)
        )
    }
    
    func test_singleSelect_wrapChips_onDark() {
        assertSnapshot(
            VStack {
                BPKSingleSelectChipGroup(
                    chips: [
                        .init(text: "Barcelona"),
                        .init(text: "Tokio", icon: .city),
                        .init(text: "London"),
                        .init(text: "Shenzhen")
                    ],
                    style: .default,
                    selectedIndex: .constant(1),
                    type: .wrap,
                    onItemClick: { _ in }
                )
                .padding()
                
                BPKSingleSelectChipGroup(
                    chips: [
                        .init(text: "Barcelona"),
                        .init(text: "Tokio", icon: .city),
                        .init(text: "London"),
                        .init(text: "Shenzhen")
                    ],
                    style: .onDark,
                    selectedIndex: .constant(1),
                    type: .wrap,
                    onItemClick: { _ in }
                )
                .padding()
                .background(.surfaceContrastColor)
                
                BPKSingleSelectChipGroup(
                    chips: [
                        .init(text: "Barcelona"),
                        .init(text: "Tokio", icon: .city),
                        .init(text: "London"),
                        .init(text: "Shenzhen")
                    ],
                    style: .onImage,
                    selectedIndex: .constant(1),
                    type: .wrap,
                    onItemClick: { _ in }
                )
                .padding()
                .background(.statusSuccessSpotColor)
                
            }
            .frame(width: 350)
        )
    }
}
