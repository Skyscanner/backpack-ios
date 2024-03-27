/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2024 Skyscanner Ltd
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

class BPKSearchInputSummaryTests: XCTestCase {
    func test_defaultSettings_withPrefixIcon() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .icon, .constant("Value"))
                .frame(width: 300))
    }

    func test_emptyField_withPrefixIcon() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .icon, .constant(""))
                .frame(width: 300))
    }

    func test_disabledField_withPrefixIcon() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .icon, .constant("Value"))
                .inputState(.disabled)
                .frame(width: 300))
    }

    func test_clearableField_withPrefixIcon() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .icon, .constant("Value"))
                .inputState(.clear(accessibilityLabel: "Clear") { })
                .frame(width: 300))
    }

    func test_validField_withPrefixIcon() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .icon, .constant("Value"))
                .inputState(.valid)
                .frame(width: 300))
    }

    func test_errorField_withPrefixIcon() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .icon, .constant("Value"))
                .inputState(.error)
                .frame(width: 300))
    }
    
    func test_defaultSettings_withCustomPrefixText() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .text("Prefix"), .constant("Value"))
                .frame(width: 300))
    }

    func test_emptyField_withCustomPrefixText() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .text("Prefix"), .constant(""))
                .frame(width: 300))
    }

    func test_disabledField_withCustomPrefixText() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .text("Prefix"), .constant("Value"))
                .inputState(.disabled)
                .frame(width: 300))
    }

    func test_clearableField_withCustomPrefixText() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .text("Prefix"), .constant("Value"))
                .inputState(.clear(accessibilityLabel: "Clear") { })
                .frame(width: 300))
    }

    func test_validField_withCustomPrefixText() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .text("Prefix"), .constant("Value"))
                .inputState(.valid)
                .frame(width: 300))
    }

    func test_errorField_withCustomPrefixText() {
        assertSnapshot(
            BPKSearchInputSummary(inputPrefix: .text("Prefix"), .constant("Value"))
                .inputState(.error)
                .frame(width: 300))
    }
}
