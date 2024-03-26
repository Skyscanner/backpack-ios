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

func assertSnapshot<V: View>(
    _ view: V,
    modes: [SnapshotModes] = [.light, .dark, .rtl],
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    BPKFont.setDynamicType(enabled: true)
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

func assertA11ySnapshot<V: View>(
    _ view: V,
    sizes: [ContentSizeCategory] = [.large, .extraExtraExtraLarge, .accessibilityExtraLarge],
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
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
    
    assertSnapshot(
        a11yView,
        modes: [.custom(name: "a11y", trait: UITraitCollection(userInterfaceStyle: .light))],
        file: file,
        testName: testName,
        line: line
    )
}

// MARK: Helper enums
enum SnapshotModes {
    case light, dark, rtl, custom(name: String, trait: UITraitCollection)
    
    var trait: UITraitCollection {
        switch self {
        case .light:
            UITraitCollection(userInterfaceStyle: .light)
        case .dark:
            UITraitCollection(userInterfaceStyle: .dark)
        case .rtl:
            UITraitCollection(layoutDirection: .rightToLeft)
        case .custom(_, let collection):
            collection
        }
    }
    
    ///  Used in the file name of the snapshot.
    ///  Appended right before the file name
    var name: String {
        switch self {
        case .light:
            "light-mode"
        case .dark:
            "dark-mode"
        case .rtl:
            "rtl"
        case .custom(let name, _):
            name
        }
    }
}
