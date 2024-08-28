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
import Backpack_SwiftUI

/// Create snapshots of a SwiftUI view using several pre-defined options.
/// This will create as many png snapshots as modes are defined.
/// - Parameters:
///       - view: The SwiftUI view to take a snapshot of
///       - modes: An array of snapshot modes, by default we cover light, dark and right to left
///       - file: Reference to the calling file
///       - testName: Reference the calling function
///       - line: Reference the calling line
func assertSnapshot<V: View>(
    _ view: V,
    modes: [SnapshotModes] = [.light, .dark, .rtl],
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    let view: UIView = UIHostingController(rootView: view).view
    isRecording = false
    modes.forEach { mode in
        assertSnapshot(
            matching: view,
            as: .image(size: view.intrinsicContentSize, traits: mode.trait),
            named: mode.name,
            file: file,
            testName: testName,
            line: line
        )
    }
}

/// Test any view across a number of accessibility sizes.
/// By default we test: default, 135% and 235%
///
/// The test view is restricted to 375px in width, to simulate an iPhone SE 3rd gen size
/// The test view can expand vertically to accomodate as much space as needed (scrollView)
func assertA11ySnapshot<V: View>(
    _ view: V,
    sizes: [ContentSizeCategory] = [.large, .extraExtraExtraLarge, .accessibilityExtraLarge],
    customHeight: CGFloat? = nil,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    BPKFont.setDynamicType(enabled: true)
    let a11yView = VStack(alignment: .leading, spacing: 16) {
        ForEach(sizes, id: \.self) { size in
            VStack(alignment: .leading, spacing: 4) {
                view
                    .sizeCategory(size)
                BPKText("\(size)", style: .caption)
                    .foregroundColor(.textSecondaryColor)
                    .sizeCategory(.medium)
            }
        }
    }
    .padding()
    .frame(maxWidth: 375)
    .frame(height: customHeight)

    assertSnapshot(
        a11yView,
        modes: [.custom(named: "a11y", trait: UITraitCollection(userInterfaceStyle: .light))],
        file: file,
        testName: testName,
        line: line
    )
}

/// Standardise all snapshot types we allow
/// For Accessibility, we use .custom(...) as we want to force the view in light mode
enum SnapshotModes {
    case light, dark, rtl, custom(named: String, trait: UITraitCollection)
    
    var trait: UITraitCollection {
        switch self {
        case .light:
            return UITraitCollection(userInterfaceStyle: .light)
        case .dark:
            return UITraitCollection(userInterfaceStyle: .dark)
        case .rtl:
            return UITraitCollection(layoutDirection: .rightToLeft)
        case .custom(_, let collection):
            return collection
        }
    }
    
    ///  Used in the file name of the snapshot.
    ///  Appended right before the file name
    var name: String {
        switch self {
        case .light:
            return "light-mode"
        case .dark:
            return "dark-mode"
        case .rtl:
            return "rtl"
        case .custom(let name, _):
            return name
        }
    }
}
