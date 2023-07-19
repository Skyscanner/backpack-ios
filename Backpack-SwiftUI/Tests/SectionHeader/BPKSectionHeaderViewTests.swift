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
import SnapshotTesting
import Backpack_SwiftUI

class BPKSectionHeaderViewTests: XCTestCase {
    func testSectionHeaderDefault() {
        assertSnapshot(
            BPKSectionHeader(title: "Section title", accessibilityLabel: "Section header")
                .padding()
        )
    }

    func testSectionHeaderWithDescription() {
        assertSnapshot(
            BPKSectionHeader(title: "Section title",
                             description: "Description about this section",
                            accessibilityLabel: "Section header")
            .padding()
        )
    }

    func testSectionHeaderWithDescriptionAndButton() {
        assertSnapshot(
            BPKSectionHeader(title: "Section title",
                             description: "Description about this section",
                             accessibilityLabel: "Section header") {
                                 BPKButton(icon: .addCircle, accessibilityLabel: "sectionHeaderButton") { }
                           }
                .padding()
        )
    }

    func testSectionHeaderWithDescriptionAndButtonOnDark() {
        assertSnapshot(
            BPKSectionHeader(title: "Section title",
                             description: "Description about this section",
                             style: .onDark,
                             accessibilityLabel: "Section header") {
                                 BPKButton(icon: .addCircle, accessibilityLabel: "sectionHeaderButton") { }
                           }
                .padding()
        )
    }
}
