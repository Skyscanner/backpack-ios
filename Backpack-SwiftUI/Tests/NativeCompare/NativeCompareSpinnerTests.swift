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

/// One cropped image per pair, light and dark, for the "Backpack on native" audit.
final class NativeCompareSpinnerTests: XCTestCase {
    func testSmall() {
        assertNativeCompareSnapshot(SpinnerComparison.small)
    }

    func testLarge() {
        assertNativeCompareSnapshot(SpinnerComparison.large)
    }

    func testExtraLarge() {
        assertNativeCompareSnapshot(SpinnerComparison.extraLarge)
    }

    func testOnDark() {
        assertNativeCompareSnapshot(SpinnerComparison.onDark)
    }

    func testSmallAtLargeText() {
        assertNativeCompareLargeTextSnapshot(SpinnerComparison.small)
    }

    func testLargeAtLargeText() {
        assertNativeCompareLargeTextSnapshot(SpinnerComparison.large)
    }

    func testExtraLargeAtLargeText() {
        assertNativeCompareLargeTextSnapshot(SpinnerComparison.extraLarge)
    }

    func testOnDarkAtLargeText() {
        assertNativeCompareLargeTextSnapshot(SpinnerComparison.onDark)
    }
}
