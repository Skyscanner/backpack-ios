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

import SnapshotTesting

final class BPKFloatingNotificationSnapshotTest: XCTestCase {
    
    private let longTitle = "This is a very long text for testing purposes. Test test test test test test test test"
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    // iPad as well!
    // RTL is wrong in snapshots
    
    func testViewSnapshotWithJustText() {
        let parent = createPhoneParent()
        let notification = BPKFloatingNotification()
        notification.show(.titleOnly(parentView: parent, title: "Test"))
        sleep(2)
        assertSnapshot(parent)
    }
    
    func testViewSnapshotWithIconAndText() {
        let parent = createPhoneParent()
        let notification = BPKFloatingNotification()
        notification.show(.titleWithIcon(parentView: parent, title: "Saved", iconName: .heart))
        sleep(2)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithTextAndButton() {
        let parent = createPhoneParent()
        let notification = BPKFloatingNotification()
        notification.show(.titleWithAction(
            parentView: parent,
            title: "Saved",
            action: .action(title: "View", action: { })
        ))
        sleep(2)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithTextIconAndButton() {
        let parent = createPhoneParent()
        let notification = BPKFloatingNotification()
        notification.show(.titleWithIconAndAction(
            parentView: parent,
            title: "Saved",
            iconName: .heart,
            action: .action(title: "View", action: { }),
            didDismiss: { }
        ))
        sleep(2)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithJustLongText() {
        let parent = createPhoneParent()
        let notification = BPKFloatingNotification()
        notification.show(.titleOnly(parentView: parent, title: longTitle))
        sleep(2)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithIconAndLongText() {
        let parent = createPhoneParent()
        let notification = BPKFloatingNotification()
        notification.show(.titleWithIcon(parentView: parent, title: longTitle, iconName: .heart))
        sleep(2)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithLongTextAndButton() {
        let parent = createPhoneParent()
        let notification = BPKFloatingNotification()
        notification.show(.titleWithAction(
            parentView: parent,
            title: longTitle,
            action: .action(title: "View", action: { })
        ))
        sleep(2)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithLongTextIconAndButton() {
        let parent = createPhoneParent()
        let notification = BPKFloatingNotification()
        notification.show(.titleWithIconAndAction(
            parentView: parent,
            title: longTitle,
            iconName: .heart,
            action: .action(title: "View", action: { }),
            didDismiss: { }
        ))
        sleep(2)
        assertSnapshot(parent)
    }

    private func createPhoneParent() -> UIView {
        let parentView = UIView(frame: .zero)
        parentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            parentView.heightAnchor.constraint(equalToConstant: 667),
            parentView.widthAnchor.constraint(equalToConstant: 375)
        ])
        return parentView
    }
}
