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

final class SlideshowPhotoLayoutTests: XCTestCase {
    func test_whenSpaceIsTallerThanWide_thenPhotoIsASquareOfTheFullWidth() {
        let size = photoSize(offered: CGSize(width: 300, height: 600))

        XCTAssertEqual(size.width, 300, accuracy: 0.5)
        XCTAssertEqual(size.height, 300, accuracy: 0.5)
    }

    func test_whenSpaceIsWiderThanTall_thenPhotoTakesTheFullWidthAndAllTheHeight() {
        let size = photoSize(offered: CGSize(width: 867, height: 450))

        XCTAssertEqual(size.width, 867, accuracy: 0.5)
        XCTAssertEqual(size.height, 450, accuracy: 0.5)
    }

    // MARK: - Helpers

    private func photoSize(offered size: CGSize) -> CGSize {
        UIHostingController(rootView: SlideshowPhotoLayout { Color.red })
            .sizeThatFits(in: size)
    }
}
