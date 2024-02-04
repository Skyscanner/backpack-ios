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
    let singleChips: [BPKSingleSelectChipGroup.ChipItem] = [
        .init(text: "Barcelona"),
        .init(text: "Tokio", icon: .city),
        .init(text: "London"),
        .init(text: "Shenzhen")
    ]
    
    func test_singleSelect_railChips_default() {
        assertSnapshot(
            VStack {
                BPKSingleSelectChipGroup(
                    chips: singleChips,
                    style: .default,
                    selectedIndex: .constant(1),
                    type: .rail,
                    onItemClick: { _ in }
                )
                .padding()
                
                BPKSingleSelectChipGroup(
                    chips: singleChips,
                    style: .onDark,
                    selectedIndex: .constant(1),
                    type: .rail,
                    onItemClick: { _ in }
                )
                .padding()
                .background(.surfaceContrastColor)
                
                BPKSingleSelectChipGroup(
                    chips: singleChips,
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
                    chips: singleChips,
                    style: .default,
                    selectedIndex: .constant(1),
                    type: .wrap(alignment: .leading),
                    onItemClick: { _ in }
                )
                .padding()
                
                BPKSingleSelectChipGroup(
                    chips: singleChips,
                    style: .onDark,
                    selectedIndex: .constant(1),
                    type: .wrap(alignment: .leading),
                    onItemClick: { _ in }
                )
                .padding()
                .background(.surfaceContrastColor)
                
                BPKSingleSelectChipGroup(
                    chips: singleChips,
                    style: .onImage,
                    selectedIndex: .constant(1),
                    type: .wrap(alignment: .leading),
                    onItemClick: { _ in }
                )
                .padding()
                .background(.statusSuccessSpotColor)
                
                BPKSingleSelectChipGroup(
                    chips: singleChips,
                    style: .default,
                    selectedIndex: .constant(1),
                    type: .wrap(alignment: .center),
                    onItemClick: { _ in }
                )
                .padding()
            }
            .frame(width: 350)
        )
    }
    
    let multiselectChips: [BPKMultiSelectChipGroup.ChipItem] = [
        .init(text: "Barcelona", selected: false, onClick: {}),
        .init(text: "Tokio", icon: .city, selected: true, onClick: {}),
        .init(text: "London", selected: true, onClick: {}),
        .init(text: "Shenzhen", selected: false, onClick: {})
    ]
    
    func test_multipleSelect_railChips_default() {
        assertSnapshot(
            VStack {
                BPKMultiSelectChipGroup(
                    chips: multiselectChips,
                    style: .default,
                    type: .rail(stickyChip: nil)
                )
                .padding()
                
                BPKMultiSelectChipGroup(
                    chips: multiselectChips,
                    style: .onDark,
                    type: .rail(stickyChip: nil)
                )
                .padding()
                .background(.surfaceContrastColor)
                
                BPKMultiSelectChipGroup(
                    chips: multiselectChips,
                    style: .onImage,
                    type: .rail(stickyChip: nil)
                )
                .padding()
                .background(.statusSuccessSpotColor)
            }
            .frame(width: 300)
        )
    }
    
    func test_multipleSelect_railWithStickyChips_default() {
        let sticky = BPKMultiSelectChipGroup.StickyChipItem(
            accessibilityLabel: "",
            icon: .filter,
            selected: false,
            onClick: {}
        )
        assertSnapshot(
            VStack {
                BPKMultiSelectChipGroup(
                    chips: multiselectChips,
                    style: .default,
                    type: .rail(stickyChip: sticky)
                )
                .padding()
                
                BPKMultiSelectChipGroup(
                    chips: multiselectChips,
                    style: .onDark,
                    type: .rail(stickyChip: sticky)
                )
                .padding()
                .background(.surfaceContrastColor)
                
                BPKMultiSelectChipGroup(
                    chips: multiselectChips,
                    style: .onImage,
                    type: .rail(stickyChip: sticky)
                )
                .padding()
                .background(.statusSuccessSpotColor)
            }
            .frame(width: 300)
        )
    }
    
    func test_multipleSelect_wrapChips_onDark() {
        assertSnapshot(
            VStack {
                BPKMultiSelectChipGroup(
                    chips: multiselectChips,
                    style: .default,
                    type: .wrap(alignment: .leading)
                )
                .padding()
                
                BPKMultiSelectChipGroup(
                    chips: multiselectChips,
                    style: .onDark,
                    type: .wrap(alignment: .leading)
                )
                .padding()
                .background(.surfaceContrastColor)
                
                BPKMultiSelectChipGroup(
                    chips: multiselectChips,
                    style: .onImage,
                    type: .wrap(alignment: .leading)
                )
                .padding()
                .background(.statusSuccessSpotColor)
                
                BPKMultiSelectChipGroup(
                    chips: multiselectChips,
                    style: .default,
                    type: .wrap(alignment: .center)
                )
                .padding()
            }
            .frame(width: 350)
        )
    }
}
