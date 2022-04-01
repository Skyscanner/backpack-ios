//
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
import AppCenter
import AppCenterDistribute
import AppCenterAnalytics
import AppCenterCrashes

import Backpack

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var isUITestingEnabled = false
    
    // swiftlint:disable indentation_width
    fileprivate func setupAppearance() {
        UINavigationBar.appearance().tintColor = BPKColor.textPrimaryColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: BPKColor.textPrimaryColor,
            NSAttributedString.Key.font: BPKFontManager.sharedInstance().semiboldFont(withSize: 17)
        ]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: BPKColor.textPrimaryColor,
            NSAttributedString.Key.font: BPKFontManager.sharedInstance().semiboldFont(withSize: 34)
        ]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: BPKColor.textPrimaryColor,
            NSAttributedString.Key.font: BPKFontManager.sharedInstance().semiboldFont(withSize: 17)
        ], for: .normal)
        
        BPKAppearance.apply()
    }
    
    private func setupRelativeFont() {
        guard !ProcessInfo.processInfo.arguments.contains("DISABLE_RELATIVE") else { return }
        let relativeFontDefinition = BPKRelativeFontDefinition()
        let relativeTestFont = UIFont(name: relativeFontDefinition.regularFontFace, size: 12)
        if relativeTestFont != nil {
            BPKFont.setFontDefinition(relativeFontDefinition)
        }
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.isUITestingEnabled = ProcessInfo.processInfo.arguments.contains("UITests")
        setupRelativeFont()
        setupAppearance()
        AppCenter.start(withAppSecret: "$(APP_CENTER_SECRET)",
                        services: [Analytics.self, Crashes.self, Distribute.self])
        return true
    }
}
