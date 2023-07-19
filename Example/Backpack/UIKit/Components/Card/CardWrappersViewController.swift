/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

class CardWrappersViewController: UIViewController {
    
    public var isCardDivided: Bool = false
    public var elevation: BPKCardElevation = .default
    public var isPadded: Bool = true
    public var cornerStyle: BPKCardCornerStyle = .small
    public var backgroundColor: UIColor = BPKColor.coreAccentColor

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = BPKColor.canvasColor
        
        let wrapper = BPKCardWrapper(
            header: createHeader(),
            card: createCard(),
            backgroundColor: backgroundColor
        )
        wrapper.elevation = elevation
        wrapper.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(wrapper)
                
        NSLayoutConstraint.activate([
            wrapper.leadingAnchor.constraint(
                equalTo: view.readableContentGuide.leadingAnchor,
                constant: BPKSpacingBase),
            wrapper.trailingAnchor.constraint(
                equalTo: view.readableContentGuide.trailingAnchor,
                constant: -BPKSpacingBase),
            wrapper.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func createCard() -> BPKCard {
        let label1 = BPKLabel(fontStyle: .textHeading5)
        label1.text = "Let's explore"
        label1.numberOfLines = 0
        
        let label2 = BPKLabel(fontStyle: .textBodyDefault)
        label2.text = """
        It's your world and we'll help you
        explore it. Find the best prices across
        millions of flights, hotels and car hire
        options to create your perfect trip.
        """
        
        label2.numberOfLines = 0
        
        if isCardDivided {
            let card = BPKDividedCard()
            card.setSubviews(primarySubview: label1, secondarySubview: label2)
            card.lineStyle = .solid
            card.orientation = .vertical
            card.isElevated = false
            card.isPadded = isPadded
            card.cornerStyle = cornerStyle
            return card
        }
        
        let cardContent = UIStackView()
        cardContent.axis = .vertical
        cardContent.spacing = BPKSpacingMd
        cardContent.translatesAutoresizingMaskIntoConstraints = false
        cardContent.addArrangedSubview(label1)
        cardContent.addArrangedSubview(label2)
        
        let card = BPKCard(padded: true)
        card.subview = cardContent
        card.isElevated = false
        card.isPadded = isPadded
        card.cornerStyle = cornerStyle
        return card
    }
    
    private func createHeader() -> UIView {
        let header = UIStackView()
        header.axis = .horizontal
        header.distribution = .fill
        header.alignment = .center
        header.spacing = BPKSpacingMd
        header.translatesAutoresizingMaskIntoConstraints = false
        header.isLayoutMarginsRelativeArrangement = true
        header.layoutMargins = UIEdgeInsets(
            top: BPKSpacingMd,
            left: BPKSpacingBase,
            bottom: BPKSpacingMd,
            right: BPKSpacingBase)
                
        let label = BPKLabel(fontStyle: .textLabel1)
        label.text = "Wrapper title"
        label.textColor = BPKColor.textPrimaryInverseColor
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        header.addArrangedSubview(label)
        
        return header
    }
}
