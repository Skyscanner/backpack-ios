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

    #if swift(>=4.2)
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            BPKExampleApp.showSettingsView()
        }

        super.motionEnded(motion, with: event)
    }
    #else
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            BPKExampleApp.showSettingsView()
        }

        super.motionEnded(motion, with: event)
    }
    #endif

    @objc class func showSettingsView() {
        let storyboardName = "Main"
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
        guard let rvc = UIApplication.shared.keyWindow?.rootViewController as? ThemeContainerController else {
            return
        }

        let modalController = rvc.createIdenticalThemeContainer(forRootController: viewController)
        UIApplication.shared.keyWindow?.topMostController()?.present(modalController, animated: true, completion: nil)
    }
}
