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
import Backpack.Switch

class SwitchesViewController: UIViewController {
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
        
        stackView.addArrangedSubview(createHeader("Default"))
        stackView.addArrangedSubview(createSwitchRow(style: .default))
        
        stackView.addArrangedSubview(createHeader("On Contrast"))
        stackView.addArrangedSubview(createSwitchRow(
            style: .onContrast,
            backgroundColor: BPKColor.surfaceContrastColor
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
    
    private func createSwitchRow(
        style: BPKSwitchStyle,
        backgroundColor: UIColor = BPKColor.surfaceDefaultColor
    ) -> UIView {
        let bpkSwitch = BPKSwitch(style: style)
        bpkSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = backgroundColor
        containerView.addSubview(bpkSwitch)
        
        NSLayoutConstraint.activate([
            bpkSwitch.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bpkSwitch.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            bpkSwitch.topAnchor.constraint(equalTo: containerView.topAnchor, constant: BPKSpacingBase),
            bpkSwitch.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -BPKSpacingBase)
        ])
        
        return containerView
    }
    
    private func createHeader(_ text: String) -> BPKLabel {
        let label = BPKLabel(fontStyle: .textHeading4)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
