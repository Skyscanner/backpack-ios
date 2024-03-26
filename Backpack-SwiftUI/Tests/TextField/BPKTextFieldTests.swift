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

class BPKTextFieldTests: XCTestCase {
    func test_defaultSettings() {
        assertSnapshot(
            BPKTextField(.constant("Value"))
                .frame(width: 300))
    }

    func test_emptyField() {
        assertSnapshot(
            BPKTextField(.constant(""))
                .frame(width: 300))
    }

    func test_disabledField() {
        assertSnapshot(
            BPKTextField(.constant("Value"))
                .inputState(.disabled)
                .frame(width: 300))
    }

    func test_clearableField() {
        assertSnapshot(
            BPKTextField(.constant("Value"))
                .inputState(.clear(accessibilityLabel: "Clear") { })
                .frame(width: 300))
    }

    func test_validField() {
        assertSnapshot(
            BPKTextField(.constant("Value"))
                .inputState(.valid)
                .frame(width: 300))
    }

    func test_errorField() {
        assertSnapshot(
            BPKTextField(.constant("Value"))
                .inputState(.error)
                .frame(width: 300))
    }
    
    func test_defaultSettings_withPrefixIcon() {
        assertSnapshot(
            BPKTextField(prefixState: .searchIcon, .constant("Value"))
                .frame(width: 300))
    }

    func test_emptyField_withPrefixIcon() {
        assertSnapshot(
            BPKTextField(prefixState: .searchIcon, .constant(""))
                .frame(width: 300))
    }

    func test_disabledField_withPrefixIcon() {
        assertSnapshot(
            BPKTextField(prefixState: .searchIcon, .constant("Value"))
                .inputState(.disabled)
                .frame(width: 300))
    }

    func test_clearableField_withPrefixIcon() {
        assertSnapshot(
            BPKTextField(prefixState: .searchIcon, .constant("Value"))
                .inputState(.clear(accessibilityLabel: "Clear") { })
                .frame(width: 300))
    }

    func test_validField_withPrefixIcon() {
        assertSnapshot(
            BPKTextField(prefixState: .searchIcon, .constant("Value"))
                .inputState(.valid)
                .frame(width: 300))
    }

    func test_errorField_withPrefixIcon() {
        assertSnapshot(
            BPKTextField(prefixState: .searchIcon, .constant("Value"))
                .inputState(.error)
                .frame(width: 300))
    }
    
    func test_defaultSettings_withCustomPrefixText() {
        assertSnapshot(
            BPKTextField(prefixState: .text("Prefix"), .constant("Value"))
                .frame(width: 300))
    }

    func test_emptyField_withCustomPrefixText() {
        assertSnapshot(
            BPKTextField(prefixState: .text("Prefix"), .constant(""))
                .frame(width: 300))
    }

    func test_disabledField_withCustomPrefixText() {
        assertSnapshot(
            BPKTextField(prefixState: .text("Prefix"), .constant("Value"))
                .inputState(.disabled)
                .frame(width: 300))
    }

    func test_clearableField_withCustomPrefixText() {
        assertSnapshot(
            BPKTextField(prefixState: .text("Prefix"), .constant("Value"))
                .inputState(.clear(accessibilityLabel: "Clear") { })
                .frame(width: 300))
    }

    func test_validField_withCustomPrefixText() {
        assertSnapshot(
            BPKTextField(prefixState: .text("Prefix"), .constant("Value"))
                .inputState(.valid)
                .frame(width: 300))
    }

    func test_errorField_withCustomPrefixText() {
        assertSnapshot(
            BPKTextField(prefixState: .text("Prefix"), .constant("Value"))
                .inputState(.error)
                .frame(width: 300))
    }
}
