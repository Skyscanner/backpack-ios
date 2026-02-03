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
import Backpack

class ThemeHelpers: NSObject {

    @objc
    class func overrideUserInterfaceStyle() -> Bool {
        return ProcessInfo.processInfo.environment["OVERRIDE_INTERFACE_STLYE"] == "YES"
    }

    class func forceDarkMode() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("FORCE_DARK_MODE")
    }
    
    class func forceLightMode() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("FORCE_LIGHT_MODE")
    }
}
