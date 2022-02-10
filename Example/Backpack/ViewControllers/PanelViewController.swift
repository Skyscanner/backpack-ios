/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

class PanelViewController: UIViewController {
    @IBOutlet weak var panel: BPKPanel!

    var padded: Bool = true
    var style: BPKPanelStyle = .default

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = BPKLabel(fontStyle: .textBodyDefault)
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit." +
        "Nulla tempus nec velit sit amet volutpat. Suspendisse potenti." +
        "Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 50
        panel.addSubview(label)

        panel.isPadded = padded
        panel.style = style

    }
}
