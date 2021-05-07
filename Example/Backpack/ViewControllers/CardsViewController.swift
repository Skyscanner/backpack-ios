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

import Backpack.Card

class CardsViewController: UIViewController {
    @IBOutlet weak var card: BPKCard!
    var padded: Bool = true
    var selected: Bool = false
    var accessibilityConfiguration: BPKCardAccessibilityConfiguration = BPKCardAccessibilityConfigurationContainer()
    var backgroundColor: UIColor?
    var cornerStyle: BPKCardCornerStyle = .small

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCard()
    }

    func setupCard() {
        let label = BPKLabel(fontStyle: .textBase)
        label.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. " +
            "Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, " +
            "nascetur ridiculus mus."
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        card.subview = label
        card.isPadded = padded
        card.cornerStyle = cornerStyle
        card.isSelected = selected
        card.accessibilityConfiguration = accessibilityConfiguration
        if backgroundColor != nil {
            card.backgroundColor = backgroundColor
            label.textColor = BPKColor.textPrimaryLightColor
        }
    }
}
