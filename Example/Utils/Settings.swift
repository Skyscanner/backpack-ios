/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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

let THEMEKEY = "theme"

class Settings: NSObject {

    let userDefaults: UserDefaults
    @objc static let sharedSettings = Settings(userDefaults: UserDefaults.standard)

    @objc var activeTheme: ThemeHelpers.ThemeName {
        get {
            guard let currentTheme = userDefaults.value(forKey: THEMEKEY) as? String else {
                return .none
            }

            switch currentTheme {
            case "Spring clean":
                return .springClean
            case "London":
                return .london
            case "Hong Kong":
                return .hongKong
            case "Doha":
                return .doha
            case "Silver":
                return .silver
            default:
                return .none
            }
        }
        set {
            let themeDefinition = ThemeHelpers.themeDefinition(forTheme: newValue)
            let themeName = themeDefinition.themeName
            userDefaults.set(themeName, forKey: THEMEKEY)
        }
    }

    init (userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        super.init()
    }
}
