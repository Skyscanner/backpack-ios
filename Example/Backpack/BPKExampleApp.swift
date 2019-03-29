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

import Backpack.Theme

@objc class BPKExampleApp: UIApplication {
    override func sendEvent(_ event: UIEvent) {
        if event.type == .motion && event.subtype == .motionShake {
            let storyboardName = "Main"
            let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
            let settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")

            self.keyWindow?.topMostController()?.present(settingsViewController, animated: true, completion: nil)
        }

        super.sendEvent(event)
    }
}
