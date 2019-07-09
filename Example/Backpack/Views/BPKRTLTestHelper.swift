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

import UIKit
import Backpack.Spacing
import Backpack.Icon
import Backpack.Theme

class BPKRTLTestHelper: NSObject {

    static let didChangeNotification = "BPK_RTL_DID_CHANGE"

    @objc
    func listen() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(BPKRTLTestHelper.rtlChanged(notification:)),
            name: Notification.Name(rawValue: BPKRTLTestHelper.didChangeNotification),
            object: nil)
    }

    @objc
    func setRTL(rtl: Bool) {
        if rtl {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }

    @objc
    func rtlChanged(notification: Notification) {
        self.setRTL(rtl: (notification.object as? NSNumber ?? false).boolValue)
    }

}
