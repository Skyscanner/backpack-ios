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
    let selected: Bool
    let enabled: Bool
    let icon: BPKSmallIconName?
}

class ChipsViewController: UIViewController {
    private var style: BPKChipStyle

    init(style: BPKChipStyle) {
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let chips: [ChipConfig] = [
        ChipConfig(
            title: "Jamaica",
            selected: false,
            enabled: true,
            icon: nil
        ),
        ChipConfig(
            title: "Kosovo",
            selected: false,
            enabled: false,
            icon: nil
        ),
        ChipConfig(
            title: "Lesotho",
            selected: false,
            enabled: true,
            icon: .close
        ),
        ChipConfig(
            title: "Madagascar",
            selected: true,
            enabled: true,
            icon: .camera
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = BPKSpacingMd
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        chips.map {
            let chip = BPKChip(title: $0.title, icon: $0.icon)
            chip.isEnabled = $0.enabled
            chip.style = style
            return chip
        }.forEach(stack.addArrangedSubview)
    }
}
