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

final class FloatingNotificationWidthTests: XCTestCase {
    func test_whenWindowIsPhoneSized_thenFillsTheWidthLessMargins() {
        let parent = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
        let notification = makeNotification(in: parent)

        parent.layoutIfNeeded()

        XCTAssertEqual(notification.frame.width, 375 - BPKSpacingBase * 2, accuracy: 0.5)
    }

    func test_whenWindowIsWide_thenIsCappedAt400() {
        let parent = UIView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
        let notification = makeNotification(in: parent)

        parent.layoutIfNeeded()

        XCTAssertEqual(notification.frame.width, 400, accuracy: 0.5)
        XCTAssertEqual(notification.frame.midX, parent.bounds.midX, accuracy: 0.5)
    }

    // MARK: - Helpers

    /// A short title, so the notification's content alone would make it narrow.
    private func makeNotification(in parent: UIView) -> FloatingNotificationView {
        FloatingNotificationView(
            .titleOnly(parentView: parent, title: "Saved"),
            hiddenBottomConstraintConstant: 100,
            shouldAnimateDown: { _ in }
        )
    }
}
