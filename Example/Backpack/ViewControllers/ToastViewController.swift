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
import Backpack

enum ToastType {
    case docs
    case defaultToast
    case onlyLabels
}

class ToastViewController: UIViewController {
    @IBOutlet weak var showButton: BPKButton!
    var type: ToastType = .defaultToast

    @IBAction func show(_ sender: BPKButton) {
        switch type {
        case .docs:
            showPersistentToast()
        case .defaultToast:
            showDefaultToast()
        case .onlyLabels:
            showToastOnlyLabels()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showButton.title = "Show Toast"
    }
    
    func showPersistentToast() {
        let toast = BPKToast.showAdded(to: self.view, animated: true, accessibilityAnnouncement: "Saving your changes")
        toast.mode = .indeterminate
        toast.labelText = "This is the title"
        toast.detailsLabelText = "Details label text"
    }

    func showDefaultToast() {
        let toast = BPKToast.showAdded(to: self.view, animated: true, accessibilityAnnouncement: "Saving your changes")
        toast.mode = .indeterminate
        toast.labelText = "This is the title"
        toast.detailsLabelText = "Details label text"
        toast.hide(true, afterDelay: isUITesting ? 1.5: 5)
    }

    func showToastOnlyLabels() {
        let toast = BPKToast.showAdded(to: self.view, animated: true, accessibilityAnnouncement: "Saving your changes")
        toast.mode = .text
        toast.labelText = "This is the title"
        toast.detailsLabelText = "Details label text"
        toast.hide(true, afterDelay: isUITesting ? 0.1: 6)
    }
}
