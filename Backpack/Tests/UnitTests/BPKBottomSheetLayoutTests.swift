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
@testable import Backpack

final class BPKBottomSheetLayoutTests: XCTestCase {

    // MARK: - Heights that fit the window

    func test_whenWindowHeightIsUnknown_thenKeepsTheInset() {
        XCTAssertEqual(BottomSheetInsets.fitting(386, into: nil), 386)
    }

    func test_whenWindowHeightIsZero_thenKeepsTheInset() {
        XCTAssertEqual(BottomSheetInsets.fitting(386, into: 0), 386)
    }

    func test_whenWindowIsTall_thenKeepsTheInset() {
        XCTAssertEqual(BottomSheetInsets.fitting(386, into: 900), 386)
    }

    func test_whenWindowIsShort_thenCapsTheInsetToAShareOfTheHeight() {
        let fitted = BottomSheetInsets.fitting(386, into: 360)

        XCTAssertEqual(fitted, 360 * BottomSheetInsets.maximumPartialHeightFraction, accuracy: 0.001)
    }

    // MARK: - Width

    func test_whenWindowIsPhoneSized_thenSheetFillsTheWidth() {
        let frame = sheetFrame(inWindowOfSize: CGSize(width: 466, height: 678))

        XCTAssertEqual(frame.minX, 0, accuracy: 0.5)
        XCTAssertEqual(frame.width, 466, accuracy: 0.5)
    }

    func test_whenWindowIsWide_thenSheetIsCentredAtTheMaximumWidth() {
        let frame = sheetFrame(inWindowOfSize: CGSize(width: 951, height: 669))

        XCTAssertEqual(frame.width, BottomSheetHorizontalLayout.maximumWidth, accuracy: 0.5)
        XCTAssertEqual(frame.midX, 951 / 2, accuracy: 0.5)
    }

    private func sheetFrame(inWindowOfSize size: CGSize) -> CGRect {
        let window = UIView(frame: CGRect(origin: .zero, size: size))
        let sheet = UIView()
        sheet.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(sheet)
        NSLayoutConstraint.activate(
            BottomSheetHorizontalLayout.constraints(surfaceView: sheet, in: window) + [
                sheet.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                sheet.heightAnchor.constraint(equalToConstant: 386)
            ]
        )
        window.layoutIfNeeded()
        return sheet.frame
    }
}
