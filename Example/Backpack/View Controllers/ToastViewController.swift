//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019 Skyscanner Ltd. All rights reserved.
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
import MBProgressHUD

enum ToastType {
    case defaultToast
    case onlyLabels
}

class ToastViewController: UIViewController {
    @IBOutlet weak var showButton: Backpack.Button!
    var type: ToastType = .defaultToast

    @IBAction func show(_ sender: Backpack.Button) {
        switch type {
        case .defaultToast:
            showDefaultToast()
        case .onlyLabels:
            showToastOnlyLabels()
        }
    }

    func showDefaultToast() {
        let toast = Toast.showAdded(to: self.view, animated: true)
        toast.mode = .indeterminate
        toast.labelText = "This is the title"
        toast.detailsLabelText = "Details label text"
        toast.hide(true, afterDelay: 1.2)
    }

    func showToastOnlyLabels() {
        let toast = Toast.showAdded(to: self.view, animated: true)
        toast.mode = .text
        toast.labelText = "This is the title"
        toast.detailsLabelText = "Details label text"
        toast.hide(true, afterDelay: 2)
    }
}
