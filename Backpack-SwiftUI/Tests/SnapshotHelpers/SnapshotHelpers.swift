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
import SwiftUI
import XCTest
import SnapshotTesting

private let expectedDeviceName: String = "iPhone 8"
private let expectedMajorVersion: Int = 15
private let expectedMinorVersion: Int = 2

private func BPKVerifySnapshotOS() {
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

func assertSnapshot<V: View>(
    _ view: V,
    modes: [UIUserInterfaceStyle] = [.light, .dark],
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    BPKVerifySnapshotOS()
    let identifier: (UIUserInterfaceStyle) -> String = { mode in mode == .dark ? "dark-mode" : "light-mode" }
    modes.forEach { mode in
        let vc = UIHostingController(rootView: view)
        
        vc.overrideUserInterfaceStyle = mode
        isRecording = false
        assertSnapshot(matching: vc, as: .image, named:identifier(mode), file: file, testName: testName, line:line)
    }
}
