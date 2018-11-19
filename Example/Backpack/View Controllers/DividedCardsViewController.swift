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

import Backpack

class DividedCardsViewController: CardsViewController {
    @IBOutlet weak var dividedCard: Backpack.DividedCard!
    #if swift(>=4.2)
    var divisionDirection: NSLayoutConstraint.Axis = .horizontal
    #else
    var divisionDirection: UILayoutConstraintAxis = .horizontal
    #endif

    override func setupCard() {
        let label1 = Label(fontStyle: .textBase)
        label1.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. " +
                        "Aenean commodo ligula eget dolor. Aenean massa."
        label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        label1.numberOfLines = 0
        let label2 = Label(fontStyle: .textBase)
        label2.text = "Lorem ipsum dolor sit amet."
        label2.lineBreakMode = NSLineBreakMode.byWordWrapping
        label2.numberOfLines = 0
        dividedCard.setSubviews(primarySubview: label1, secondarySubview: label2)
        dividedCard.cornerStyle = cornerStyle
        dividedCard.isPadded = padded
        dividedCard.isSelected = selected
        dividedCard.orientation = divisionDirection
    }
}
