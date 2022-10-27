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

class SpacingTokensViewController: UIViewController {
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = BPKSpacingMd
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let spacingValues = [
        ("BPKSpacingNone", BPKSpacingNone),
        ("BPKSpacingSm", BPKSpacingSm),
        ("BPKSpacingMd", BPKSpacingMd),
        ("BPKSpacingIconText", BPKSpacingIconText),
        ("BPKSpacingBase", BPKSpacingBase),
        ("BPKSpacingLg", BPKSpacingLg),
        ("BPKSpacingXl", BPKSpacingXl),
        ("BPKSpacingXxl", BPKSpacingXxl)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        displayTokens()
    }
    
    private func displayTokens() {
        spacingValues.map(spacingView(for:))
            .forEach(verticalStackView.addArrangedSubview)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(verticalStackView)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: BPKSpacingLg),
            verticalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: BPKSpacingLg),
            verticalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -BPKSpacingLg),
            verticalStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -BPKSpacingLg)
        ])
    }
    
    private func spacingView(for cornerRadius: (String, CGFloat)) -> UIView {
        let containerView = UIStackView()
        containerView.axis = .horizontal
        containerView.distribution = .equalSpacing
        containerView.spacing = BPKSpacingMd
        
        let spacingView = UIView()
        spacingView.backgroundColor = BPKColor.coreAccentColor
        
        let label = BPKLabel()
        label.text = "\(cornerRadius.0) = \(Int(cornerRadius.1))"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spacingView.widthAnchor.constraint(equalToConstant: cornerRadius.1),
            spacingView.heightAnchor.constraint(equalToConstant: BPKSpacingXl)
        ])
        
        containerView.addArrangedSubview(spacingView)
        containerView.addArrangedSubview(label)
        return containerView
    }
}
