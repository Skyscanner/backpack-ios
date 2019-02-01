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

class RuntimeThemesViewController: UIViewController {
    @IBOutlet weak var containerView1: UIView!
    @IBOutlet weak var containerView2: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let myCustomTheme1 = ["primaryColor500": UIColor.orange,"primaryColor600": UIColor.red,"darkColor700": UIColor.black]

        let myCustomTheme2 = ["primaryColor500": UIColor.black,"primaryColor600": UIColor.red,"darkColor700": UIColor.orange]

        self.addThemedComponents(containerView: containerView1, theme: myCustomTheme1)
        self.addThemedComponents(containerView: containerView2, theme:myCustomTheme2)
    }

    func addThemedComponents(containerView: UIView, theme: [String: UIColor]){


        let themeContainer = Backpack.BPKRuntimeTheme.apply(theme)

        let sw = Backpack.Switch()
        sw.setOn(true, animated: false)
        themeContainer!.addSubview(sw)

        containerView.addSubview(themeContainer!)

        themeContainer!.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            (themeContainer!.widthAnchor.constraint(equalToConstant: 50)),
            (themeContainer!.heightAnchor.constraint(equalToConstant: 50)),
            (themeContainer!.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)),
            (themeContainer!.centerYAnchor.constraint(equalTo: containerView.centerYAnchor))
            ])
    }
}

