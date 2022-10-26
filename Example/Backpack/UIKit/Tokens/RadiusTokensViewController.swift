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

class RadiusTokensViewController: UIViewController {
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = BPKSpacingMd
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let radiiValues = [
        ("BPKCornerRadiusXs", BPKCornerRadiusXs),
        ("BPKCornerRadiusSm", BPKCornerRadiusSm),
        ("BPKCornerRadiusMd", BPKCornerRadiusMd),
        ("BPKCornerRadiusLg", BPKCornerRadiusLg),
        ("BPKCornerRadiusPill", BPKCornerRadiusPill)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let radiiViews = radiiValues.map(radiiView(for:))
        radiiViews.forEach(verticalStackView.addArrangedSubview)
        view.addSubview(verticalStackView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: BPKSpacingLg),
            verticalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: BPKSpacingLg),
            verticalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -BPKSpacingLg),
            verticalStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -BPKSpacingLg)
        ])
        
    }

    private func radiiView(for cornerRadius: (String, CGFloat)) -> UIView {
        let view = UIView()
        view.backgroundColor = BPKColor.corePrimaryColor
        view.layer.cornerRadius = cornerRadius.1
        view.translatesAutoresizingMaskIntoConstraints = false
        let label = BPKLabel()
        label.text = "\(cornerRadius.0) = \(Int(cornerRadius.1))"
        label.textColor = BPKColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: BPKSpacingXl),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BPKSpacingLg),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -BPKSpacingLg),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -BPKSpacingXl)
        ])

        return view
    }
}
