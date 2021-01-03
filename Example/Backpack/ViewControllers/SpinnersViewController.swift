/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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
import Backpack.Spinner
import Backpack.BPKColor

class SpinnersViewController: UIViewController {
    @IBOutlet weak var defaultPrimarySpinner: BPKSpinner!
    @IBOutlet weak var defaultSecondarySpinner: BPKSpinner!
    @IBOutlet weak var defaultDarkSpinner: BPKSpinner!
    @IBOutlet weak var defaultLightSpinner: BPKSpinner!
    @IBOutlet weak var smallPrimarySpinner: BPKSpinner!
    @IBOutlet weak var smallSecondarySpinner: BPKSpinner!
    @IBOutlet weak var smallDarkSpinner: BPKSpinner!
    @IBOutlet weak var smallLightSpinner: BPKSpinner!
    @IBOutlet weak var darkSpinnerBackgroundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        darkSpinnerBackgroundView.backgroundColor = BPKColor.skyGray

        defaultPrimarySpinner.size = .default
        defaultPrimarySpinner.style = .primary

        defaultSecondarySpinner.size = .default
        defaultSecondarySpinner.style = .secondary

        defaultDarkSpinner.size = .default
        defaultDarkSpinner.style = .dark

        defaultLightSpinner.size = .default
        defaultLightSpinner.style = .light

        smallPrimarySpinner.size = .small
        smallPrimarySpinner.style = .primary

        smallSecondarySpinner.size = .small
        smallSecondarySpinner.style = .secondary

        smallDarkSpinner.size = .small
        smallDarkSpinner.style = .dark

        smallLightSpinner.size = .small
        smallLightSpinner.style = .light
    }
}
