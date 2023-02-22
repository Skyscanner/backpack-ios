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
    
    // MARK: iPhoneSE screen size
    func testViewSnapshotWithJustText() {
        let parent = createParent(for: .iPhoneSE())
        let notification = BPKFloatingNotification()
        notification.show(.titleOnly(parentView: parent, title: "Test"))
        sleep(1)
        assertSnapshot(parent)
    }
    
    func testViewSnapshotWithIconAndText() {
        let parent = createParent(for: .iPhoneSE())
        let notification = BPKFloatingNotification()
        notification.show(.titleWithIcon(parentView: parent, title: "Saved", iconName: .heart))
        sleep(1)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithTextAndButton() {
        let parent = createParent(for: .iPhoneSE())
        let notification = BPKFloatingNotification()
        notification.show(.titleWithAction(
            parentView: parent,
            title: "Saved",
            action: .action(title: "View", action: { })
        ))
        sleep(1)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithTextIconAndButton() {
        let parent = createParent(for: .iPhoneSE())
        let notification = BPKFloatingNotification()
        notification.show(.titleWithIconAndAction(
            parentView: parent,
            title: "Saved",
            iconName: .heart,
            action: .action(title: "View", action: { }),
            didDismiss: { }
        ))
        sleep(1)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithJustLongText() {
        let parent = createParent(for: .iPhoneSE())
        let notification = BPKFloatingNotification()
        notification.show(.titleOnly(parentView: parent, title: longTitle))
        sleep(1)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithIconAndLongText() {
        let parent = createParent(for: .iPhoneSE())
        let notification = BPKFloatingNotification()
        notification.show(.titleWithIcon(parentView: parent, title: longTitle, iconName: .heart))
        sleep(1)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithLongTextAndButton() {
        let parent = createParent(for: .iPhoneSE())
        let notification = BPKFloatingNotification()
        notification.show(.titleWithAction(
            parentView: parent,
            title: longTitle,
            action: .action(title: "View", action: { })
        ))
        sleep(1)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithLongTextIconAndButton() {
        let parent = createParent(for: .iPhoneSE())
        let notification = BPKFloatingNotification()
        notification.show(.titleWithIconAndAction(
            parentView: parent,
            title: longTitle,
            iconName: .heart,
            action: .action(title: "View", action: { }),
            didDismiss: { }
        ))
        sleep(1)
        assertSnapshot(parent)
    }

    // MARK: iPad screen size
    func testViewSnapshotWithJustLongTextForiPad() {
        let parent = createParent(for: .iPadAir())
        let notification = BPKFloatingNotification()
        notification.show(.titleOnly(parentView: parent, title: longTitle))
        sleep(1)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithIconAndLongTextForiPad() {
        let parent = createParent(for: .iPadAir())
        let notification = BPKFloatingNotification()
        notification.show(.titleWithIcon(parentView: parent, title: longTitle, iconName: .heart))
        sleep(1)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithLongTextAndButtonForiPad() {
        let parent = createParent(for: .iPadAir())
        let notification = BPKFloatingNotification()
        notification.show(.titleWithAction(
            parentView: parent,
            title: longTitle,
            action: .action(title: "View", action: { })
        ))
        sleep(1)
        assertSnapshot(parent)
    }

    func testViewSnapshotWithLongTextIconAndButtonForiPad() {
        let parent = createParent(for: .iPadAir())
        print(parent.frame)
        let notification = BPKFloatingNotification()
        notification.show(.titleWithIconAndAction(
            parentView: parent,
            title: longTitle,
            iconName: .heart,
            action: .action(title: "View", action: { }),
            didDismiss: { }
        ))
        sleep(1)
        assertSnapshot(parent)
    }
    
    // MARK: Helpers
    private enum DeviceSize {
        case iPhoneSE(height: CGFloat = 667, width: CGFloat = 375)
        case iPadAir(height: CGFloat = 1180, width: CGFloat = 820)
    }
    
    private func createParent(for deviceSize: DeviceSize) -> UIView {
        switch deviceSize {
        case .iPhoneSE(let height, let width):
            return view(with: height, width: width)
        case .iPadAir(let height, let width):
            return view(with: height, width: width)
        }
    }
    
    private func view(with height: CGFloat, width: CGFloat) -> UIView {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let parentView = UIView(frame: frame)
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            parentView.heightAnchor.constraint(equalToConstant: height),
            parentView.widthAnchor.constraint(equalToConstant: width)
        ])
        return parentView
    }
}
