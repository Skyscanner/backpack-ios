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
import Backpack

struct ChipConfig {
    let title: String
    let icon: BPKSmallIconName?
    let type: BPKChipType
}

class ChipsViewController: UIViewController {
    private var style: BPKChipStyle
    private var titleColor: UIColor

    init(style: BPKChipStyle, titleColor: UIColor) {
        self.style = style
        self.titleColor = titleColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let chips: [ChipConfig] = [
        ChipConfig(
            title: "Option",
            icon: nil,
            type: .option
        ),
        ChipConfig(
            title: "Dropdown",
            icon: nil,
            type: .dropdown
        ),
        ChipConfig(
            title: "Dismiss",
            icon: nil,
            type: .dismiss
        ),
        ChipConfig(
            title: "With icon",
            icon: .deals,
            type: .option
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        view.backgroundColor = BPKColor.surfaceDefaultColor
        
        setupDemo()
    }
    
    private func setupDemo() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = BPKSpacingSm
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        stack.addArrangedSubview(createColumn(title: "Off", selected: false, enabled: true))
        stack.addArrangedSubview(createColumn(title: "On", selected: true, enabled: true))
        stack.addArrangedSubview(createColumn(title: "Disabled", selected: false, enabled: false))
    }
    
    func chippy() {
let chip = BPKChip(title: "Chip text")
chip.type = .dropdown
    }
    
    private func createColumn(title: String, selected: Bool, enabled: Bool) -> UIView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = BPKSpacingMd
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = BPKLabel(fontStyle: .textHeading5)
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(titleLabel)
        
        chips.map {
            let chip = BPKChip(title: $0.title, icon: $0.icon)
            chip.isEnabled = enabled
            chip.style = style
            chip.type = $0.type
            chip.isSelected = selected
            
            chip.accessibilityIdentifier = "chip_\($0.title.lowercased())_enabled_\(enabled)_selected_\(selected)"
            
            // This chip version should not exist
            // But we still want it to occupy the space
            if $0.type == .dismiss && !selected {
                chip.alpha = 0
                chip.isUserInteractionEnabled  = false
            }

            return chip
        }.forEach(stack.addArrangedSubview)
        
        return stack
    }
}
