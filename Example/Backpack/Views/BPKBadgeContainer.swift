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
import Backpack

class BPKBadgeContainer: UIView {
    var label: Label!
    var badges = [Badge]()
    let badgeMessages = ["Apples", "Bananas", "Strawberries", "Pears"]
    var currentBadgeType = BPKBadgeType.success
    var badgesRequiringDarkBackground = [BPKBadgeType.light, BPKBadgeType.inverse, BPKBadgeType.outline]

    var badgeType: BPKBadgeType {
        set {
            currentBadgeType = newValue
            for badge in badges {
                badge.type = newValue
            }
            label.text = getLegibleName(badgeType: newValue)
            label.sizeToFit()
            if badgesRequiringDarkBackground.contains(badgeType) {
                self.backgroundColor = Color.skyGrayTint01
                self.label.textColor = Color.white
            }
        }
        get { return currentBadgeType }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUp()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    func setUp() {
        label = Label(fontStyle: .textBase)
        label.text = getLegibleName(badgeType: currentBadgeType)
        label.sizeToFit()
        addSubview(label)

        populateBadges()

        let badgesStack = UIStackView(frame: .zero)
        badgesStack.alignment = .center
        badgesStack.distribution = .equalSpacing
        badgesStack.spacing = BPKSpacingMd
        for badge in badges {
            badgesStack.addArrangedSubview(badge)
        }
        addSubview(badgesStack)

        label.translatesAutoresizingMaskIntoConstraints = false
        badgesStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            label.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            badgesStack.topAnchor.constraint(equalTo: label.bottomAnchor),
            badgesStack.widthAnchor.constraint(equalToConstant: 320),
            badgesStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            badgesStack.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
            ])
    }

    func populateBadges() {
        for message in badgeMessages {
            let badge = Backpack.Badge(message: message)
            badge.type = currentBadgeType
            badges.append(badge)
        }
    }

    func getLegibleName(badgeType: BPKBadgeType) -> String {
        switch badgeType {
        case .success:
            return "Success"
        case .destructive:
            return "Destructive"
        case .warning:
            return "Warning"
        case .inverse:
            return "Inverse"
        case .light:
            return "Light"
        case .outline:
            return "Outline"
        }
    }
}
