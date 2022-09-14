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

import UIKit
import Backpack.Spinner
import Backpack.BPKColor

class SpinnersViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.surfaceDefaultColor
        createView()
    }
    
    private func createView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = BPKSpacingBase
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(createHeader("TextPrimary"))
        stackView.addArrangedSubview(createRow(forStyle: .textPrimary))
        
        stackView.addArrangedSubview(createHeader("Disabled"))
        stackView.addArrangedSubview(createRow(forStyle: .disabled))
        
        stackView.addArrangedSubview(createHeader("OnDarkSurface"))
        stackView.addArrangedSubview(createRow(
            forStyle: .onDarkSurface,
            backgroundColor: BPKColor.surfaceContrastColor,
            textColor: BPKColor.textOnDarkColor
        ))
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func createRow(
        forStyle style: BPKSpinnerStyle,
        backgroundColor: UIColor = BPKColor.surfaceDefaultColor,
        textColor: UIColor = BPKColor.textPrimaryColor) -> UIView {

        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [
            createSpinner(withStyle: style, size: .sm, textColor: textColor),
            createSpinner(withStyle: style, size: .lg, textColor: textColor),
            createSpinner(withStyle: style, size: .xl, textColor: textColor)
        ].forEach(stackView.addArrangedSubview(_:))
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = backgroundColor
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: BPKSpacingBase),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: BPKSpacingBase),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -BPKSpacingBase),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -BPKSpacingBase)
        ])
        
        return containerView
    }
    
    private func createSpinner(
        withStyle style: BPKSpinnerStyle,
        size: BPKSpinnerSize,
        textColor: UIColor = BPKColor.textPrimaryColor) -> UIView {

        let label = BPKLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.textColor = textColor
        
        switch size {
        case .sm:
            label.text = "Small"
        case .lg:
            label.text = "Large"
        case .xl:
            label.text = "ExtraLarge"
        default:
            label.text = "Deprecated"
        }
        
        let spinner = BPKSpinner(style: style, size: size)
        spinner.startAnimating()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [spinner, label].forEach(stackView.addArrangedSubview(_:))
        
        return stackView
    }
    
    private func createHeader(_ text: String) -> BPKLabel {
        let label = BPKLabel(fontStyle: .textHeading4)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}
