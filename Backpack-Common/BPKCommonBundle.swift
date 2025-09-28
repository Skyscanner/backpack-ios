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

@objc
public class BPKCommonBundle: NSObject {
    @objc public static var iconsBundle: Bundle {
        #if SWIFT_PACKAGE
        // For SPM builds, icons are available through Bundle.module
        return Bundle.module
        #else
        // For CocoaPods builds, use the traditional Icons.bundle lookup
        guard
            let url = Bundle(for: BPKCommonBundle.self).resourceURL?.appendingPathComponent("Icons.bundle"),
            let bundle = Bundle(url: url)
        else {
            return .main
        }
        return bundle
        #endif
    }
}