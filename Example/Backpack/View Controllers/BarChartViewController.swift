/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

class BarChartsViewController: UIViewController {
    @IBOutlet weak var barChartBar: BPKBarChartBar!

    var selected: Bool = false
    var fillValue: NSNumber?
    var realValue: String?

    override func viewDidLoad() {
        self.barChartBar.isSelected = selected
        self.barChartBar.fillValue = fillValue
        self.barChartBar.realValue = realValue
        self.barChartBar.title = "Fri"
        self.barChartBar.subtitle = "4"
    }
}
