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
import UIKit
import Backpack

enum GradientType {
    case primary
    case baselinesSrim
}

class GradientViewController: UIViewController {
    @IBOutlet weak var gradientView: Backpack.GradientView!
    var gradientType: GradientType = .primary

    override func viewDidLoad() {
        super.viewDidLoad()

        switch gradientType {
        case .primary:
            self.gradientView.gradient = Backpack.Gradient.primary()
        case .baselinesSrim:
            self.gradientView.gradient = Backpack.Gradient.baselineScrim()
        }
    }
}
