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
import Backpack

final class BPKNavigationBarButtonTouchTargetTests: XCTestCase {
    private let minimumTouchTarget: CGFloat = 44

    func test_whenButtonIsIconSized_thenTouchesJustOutsideTheIconStillLand() {
        let button = makeButton(size: CGSize(width: 24, height: 24))

        XCTAssertTrue(button.point(inside: CGPoint(x: -9, y: 12), with: nil))
        XCTAssertTrue(button.point(inside: CGPoint(x: 33, y: 12), with: nil))
        XCTAssertTrue(button.point(inside: CGPoint(x: 12, y: -9), with: nil))
        XCTAssertTrue(button.point(inside: CGPoint(x: 12, y: 33), with: nil))
    }

    func test_whenTouchIsBeyondTheMinimumTarget_thenItDoesNotLand() {
        let button = makeButton(size: CGSize(width: 24, height: 24))
        let outset = (minimumTouchTarget - 24) / 2

        XCTAssertFalse(button.point(inside: CGPoint(x: -outset - 1, y: 12), with: nil))
        XCTAssertFalse(button.point(inside: CGPoint(x: 24 + outset + 1, y: 12), with: nil))
    }

    func test_whenButtonIsAlreadyLarge_thenTouchAreaIsItsOwnBounds() {
        let button = makeButton(size: CGSize(width: 80, height: 48))

        XCTAssertTrue(button.point(inside: CGPoint(x: 79, y: 47), with: nil))
        XCTAssertFalse(button.point(inside: CGPoint(x: 81, y: 24), with: nil))
    }

    private func makeButton(size: CGSize) -> UIView {
        let button = BPKNavigationBarButton()
        button.frame = CGRect(origin: .zero, size: size)
        return button
    }
}
