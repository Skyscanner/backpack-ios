//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

class ColorTokensViewController: UIViewController {
    private let colorTokens = Tokens(tokens: [
        .init(name: "Text", colors: [
            .init(color: BPKColor.textPrimaryColor, name: ".textPrimaryColor"),
            .init(color: BPKColor.textSecondaryColor, name: ".textSecondaryColor"),
            .init(color: BPKColor.textDisabledColor, name: ".textDisabledColor"),
            .init(color: BPKColor.textLinkColor, name: ".textLinkColor"),
            .init(color: BPKColor.textErrorColor, name: ".textErrorColor"),
            .init(color: BPKColor.textPrimaryInverseColor, name: ".textPrimaryInverseColor"),
            .init(color: BPKColor.textOnDarkColor, name: ".textOnDarkColor"),
            .init(color: BPKColor.textOnLightColor, name: ".textOnLightColor")
        ]),
        .init(name: "Core", colors: [
            .init(color: BPKColor.corePrimaryColor, name: ".corePrimaryColor"),
            .init(color: BPKColor.coreAccentColor, name: ".coreAccentColor"),
            .init(color: BPKColor.coreEcoColor, name: ".coreEcoColor")
        ]),
        .init(name: "Status", colors: [
            .init(color: BPKColor.statusSuccessSpotColor, name: ".statusSuccessSpotColor"),
            .init(color: BPKColor.statusSuccessFillColor, name: ".statusSuccessFillColor"),
            .init(color: BPKColor.statusWarningSpotColor, name: ".statusWarningSpotColor"),
            .init(color: BPKColor.statusWarningFillColor, name: ".statusWarningFillColor"),
            .init(color: BPKColor.statusDangerSpotColor, name: ".statusDangerSpotColor"),
            .init(color: BPKColor.statusDangerFillColor, name: ".statusDangerFillColor")
        ]),
        .init(name: "Surface", colors: [
            .init(color: BPKColor.surfaceDefaultColor, name: ".surfaceDefaultColor"),
            .init(color: BPKColor.surfaceElevatedColor, name: ".surfaceElevatedColor"),
            .init(color: BPKColor.surfaceContrastColor, name: ".surfaceContrastColor"),
            .init(color: BPKColor.surfaceHighlightColor, name: ".surfaceHighlightColor")
        ]),
        .init(name: "Canvas", colors: [
            .init(color: BPKColor.canvasColor, name: ".canvasColor"),
            .init(color: BPKColor.canvasContrastColor, name: ".canvasContrastColor")
        ]),
        .init(name: "Other", colors: [
            .init(color: BPKColor.lineColor, name: ".lineColor"),
            .init(color: BPKColor.scrimColor, name: ".scrimColor")
        ])
    ])
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = BPKSpacingBase
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        displayTokens()
    }
    
    private func displayTokens() {
        colorTokens.tokens
            .map(colorSection(section:))
            .forEach(verticalStackView.addArrangedSubview)
    }
    
    private func setupView() {
        view.backgroundColor = BPKColor.canvasColor
        view.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: BPKSpacingLg),
            verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: BPKSpacingLg),
            verticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: BPKSpacingLg),
            verticalStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func colorSection(section: Tokens.Section) -> UIView {
        let sectionStackView = UIStackView()
        sectionStackView.axis = .vertical
        sectionStackView.spacing = BPKSpacingMd
        sectionStackView.alignment = .leading
        sectionStackView.distribution = .fill
        sectionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let sectionLabel = BPKLabel(fontStyle: .textHeading3)
        sectionLabel.text = section.name
        sectionStackView.addArrangedSubview(sectionLabel)
        section.colors
            .map(tokenView(colorToken:))
            .forEach(sectionStackView.addArrangedSubview)
        
        return sectionStackView
    }
    
    private func tokenView(colorToken: Tokens.Section.Color) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let colorView = UIView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.layer.cornerRadius = BPKSpacingMd
        colorView.layer.masksToBounds = true
        colorView.layer.borderWidth = 1
        colorView.backgroundColor = colorToken.color
        
        let colorLabel = BPKLabel(fontStyle: .textLabel1)
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.text = colorToken.name
        
        container.addSubview(colorView)
        container.addSubview(colorLabel)
        
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: BPKSpacingMd),
            colorView.widthAnchor.constraint(equalToConstant: BPKSpacingLg),
            colorView.heightAnchor.constraint(equalToConstant: BPKSpacingLg),
            colorView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            colorLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: BPKSpacingMd),
            colorLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: BPKSpacingMd),
            container.bottomAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: BPKSpacingMd),
            container.trailingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: BPKSpacingMd)
        ])
        
        let card = BPKCard(padded: false)
        card.subview = container
        return card
    }
}

extension ColorTokensViewController {
    struct Tokens {
        let tokens: [Section]
    }
}

extension ColorTokensViewController.Tokens {
    struct Section {
        let name: String
        let colors: [Color]
    }
}

extension ColorTokensViewController.Tokens.Section {
    struct Color {
        let color: UIColor
        let name: String
    }
}
