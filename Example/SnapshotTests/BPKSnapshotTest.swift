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

import Foundation
import XCTest
import UIKit

import FBSnapshotTestCase

private let expectedDeviceName: String = "iPhone 8"
private let expectedMajorVersion: Int = 15
private let expectedMinorVersion: Int = 2

func BPKVerifySnapshotOS() {
    let deviceName = UIDevice.current.name
    let deviceOSVersion = ProcessInfo.processInfo.operatingSystemVersion

    let isValidDevice = deviceName == expectedDeviceName &&
        deviceOSVersion.majorVersion == expectedMajorVersion &&
        deviceOSVersion.minorVersion == expectedMinorVersion

    let correctOSVersion = "\(expectedMajorVersion).\(expectedMinorVersion)"
    let actualOSVersion = "\(deviceOSVersion.majorVersion).\(deviceOSVersion.minorVersion)"
    XCTAssertTrue(
        isValidDevice,
        """
        Snapshot tests are only valid on an \(expectedDeviceName) running iOS \
        \(correctOSVersion). Device was \(deviceName) running iOS \(actualOSVersion)
        """
    )
}

extension FBSnapshotTestCase {
    func BPKSnapshotVerifyViewLight(_ view: UIView, identifier: String? = nil) {
        BPKVerifySnapshotOS()

        var finalIdentifier = "light-mode"

        if let identifier = identifier {
            finalIdentifier = "\(finalIdentifier)_\(identifier)"
        }
        view.overrideUserInterfaceStyle = .light
        FBSnapshotVerifyView(view, identifier: finalIdentifier)
    }

    func BPKSnapshotVerifyViewDark(_ view: UIView, identifier: String? = nil) {
        BPKVerifySnapshotOS()

        var finalIdentifier = "dark-mode"

        if let identifier = identifier {
            finalIdentifier = "\(finalIdentifier)_\(identifier)"
        }
        view.overrideUserInterfaceStyle = .dark
        applyDarkMode(view)
        
        FBSnapshotVerifyView(view, identifier: finalIdentifier)
    }
    
    private func applyDarkMode(_ view: UIView?) {
        guard let view = view else { return }
        view.subviews.forEach { subview in
            subview.overrideUserInterfaceStyle = .dark
            usesDrawViewHierarchyInRect = true
            subview.traitCollectionDidChange(UITraitCollection(userInterfaceStyle: .dark))
            applyDarkMode(subview)
        }
    }
}
