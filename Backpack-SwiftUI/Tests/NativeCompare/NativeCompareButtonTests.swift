//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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
import Backpack_Common

/// One cropped image per button type, light and dark, for the "Backpack on native" audit.
final class NativeCompareButtonTests: XCTestCase {
    func testPrimary() {
        assertNativeCompareSnapshot(ButtonComparison.primary)
    }

    func testSecondary() {
        assertNativeCompareSnapshot(ButtonComparison.secondary)
    }

    func testDestructive() {
        assertNativeCompareSnapshot(ButtonComparison.destructive)
    }

    func testLink() {
        assertNativeCompareSnapshot(ButtonComparison.link)
    }

    func testPrimaryAtLargeText() {
        assertNativeCompareLargeTextSnapshot(ButtonComparison.primary)
    }

    func testSecondaryAtLargeText() {
        assertNativeCompareLargeTextSnapshot(ButtonComparison.secondary)
    }

    func testDestructiveAtLargeText() {
        assertNativeCompareLargeTextSnapshot(ButtonComparison.destructive)
    }

    func testLinkAtLargeText() {
        assertNativeCompareLargeTextSnapshot(ButtonComparison.link)
    }
}
