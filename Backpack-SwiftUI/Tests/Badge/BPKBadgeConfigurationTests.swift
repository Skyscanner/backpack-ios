/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2025 Skyscanner Ltd
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
@testable import Backpack_Common

class BPKBadgeConfigurationTests: XCTestCase {
    override func setUp() {
        super.setUp()

        let config = BpkConfiguration.shared
        do {
            try config.setNew(configs: [.badges])
        } catch {
            XCTFail("Failed to set badge config")
        }
    }

    override func tearDown() {
        super.tearDown()

        BpkConfiguration.shared.reset()
    }

    func test_badge_noIcon_Configuration() {
        assertSnapshot(
            VStack {
                BPKBadge("Normal")
                BPKBadge("Strong").badgeStyle(.strong)
                HStack {
                    BPKBadge("Inverse").badgeStyle(.inverse).padding(.horizontal, .base).padding(.vertical, .md)
                }.frame(maxWidth: .infinity).background(.corePrimaryColor)
                BPKBadge("Brand").badgeStyle(.brand)
            }.padding(.vertical)
        )
    }

    func test_badge_withIcon_Configuration() {
        assertSnapshot(
            VStack {
                BPKBadge("Normal", icon: .tickCircle)
                BPKBadge("Strong", icon: .tickCircle).badgeStyle(.strong)
                BPKBadge("Success", icon: .tickCircle).badgeStyle(.success)
                BPKBadge("Warning", icon: .informationCircle).badgeStyle(.warning)
                BPKBadge("Critical", icon: .exclamation).badgeStyle(.destructive)
                HStack {
                    BPKBadge("Inverse", icon: .tickCircle).badgeStyle(.inverse)
                        .padding(.horizontal, .base)
                        .padding(.vertical, .md)
                }.frame(maxWidth: .infinity).background(.corePrimaryColor)
                BPKBadge("Brand", icon: .priceTag).badgeStyle(.brand)
            }.padding(.vertical)
        )
    }
}
