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

import UIKit

import Backpack
import Backpack_SwiftUI
import Backpack_Common

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = BPKColor.textPrimaryColor
        BPKAppearance.apply()
    }
    
    private func setupRelativeFont() {
        guard !ProcessInfo.processInfo.arguments.contains("DISABLE_RELATIVE") else { return }
        let relativeFontDefinition = BPKRelativeFontDefinition()
        let relativeTestFont = UIFont(name: relativeFontDefinition.regularFontFace as String, size: 12)
        if relativeTestFont != nil {
#if BACKPACK_SPM_EXAMPLE
            // Swift Package consumption already sets the Swift definition below.
#else
            Backpack.BPKFont.setFontDefinition(relativeFontDefinition)
#endif
            BPKFont.setSwiftFontDefinition(relativeFontDefinition)
        }
        Backpack.BPKFont.setDynamicTypeEnabled(true)
        BPKFont.setDynamicType(enabled: true)
    }
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupRelativeFont()
        setupAppearance()
        return true
    }
}
