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

class SkeletonViewController: UIViewController {
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = BPKSpacingBase
        return stackView
    }()
    
    private lazy var imageRow: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .bottom
        stackView.spacing = BPKSpacingBase
        return stackView
    }()
    
    private lazy var headlineRow: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .bottom
        stackView.spacing = BPKSpacingBase
        return stackView
    }()
    
    private lazy var circleRow: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .bottom
        stackView.spacing = BPKSpacingBase
        return stackView
    }()
    
    private lazy var bodytextRow: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .bottom
        stackView.spacing = BPKSpacingBase
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(containerView)

        imageSkeletonRow()
        circleSkeletonRow()
        headlineSkeletonRow()
        bodytextSkeletonRow()
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BPKSpacingLg),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func imageSkeletonRow() {
        let defaultImage = BPKSkeleton(type: .image)
        let roundedImage = BPKSkeleton(type: .image, size: .default, style: .rounded)
        let title = BPKLabel(fontStyle: .textHeading5)
        title.text = "ImageSKeleton"
        
        imageRow.translatesAutoresizingMaskIntoConstraints = false
        containerView.addArrangedSubview(title)
        containerView.addArrangedSubview(imageRow)
        imageRow.addArrangedSubview(defaultImage)
        imageRow.addArrangedSubview(roundedImage)
    }
    
    private func circleSkeletonRow() {
        let defaultCircle = BPKSkeleton(type: .circle)
        let small = BPKSkeleton(type: .circle, size: .small, style: .default)
        let title = BPKLabel(fontStyle: .textHeading5)
        title.text = "CircleSKeleton"
        
        circleRow.translatesAutoresizingMaskIntoConstraints = false
        containerView.addArrangedSubview(title)
        containerView.addArrangedSubview(circleRow)
        circleRow.addArrangedSubview(small)
        circleRow.addArrangedSubview(defaultCircle)
    }
    
    private func headlineSkeletonRow() {
        let defaultImage = BPKSkeleton(type: .headline)
        let small = BPKSkeleton(type: .headline, size: .small, style: .default)
        let large = BPKSkeleton(type: .headline, size: .large, style: .default)
        let title = BPKLabel(fontStyle: .textHeading5)
        title.text = "HeadlineSKeleton"
        
        headlineRow.translatesAutoresizingMaskIntoConstraints = false
        containerView.addArrangedSubview(title)
        containerView.addArrangedSubview(headlineRow)
        headlineRow.addArrangedSubview(small)
        headlineRow.addArrangedSubview(defaultImage)
        headlineRow.addArrangedSubview(large)
    }
    
    private func bodytextSkeletonRow() {
        let bodytext = BPKSkeleton(type: .bodytext)
        let title = BPKLabel(fontStyle: .textHeading5)
        title.text = "BodytextSKeleton"
        
        bodytextRow.translatesAutoresizingMaskIntoConstraints = false
        containerView.addArrangedSubview(title)
        containerView.addArrangedSubview(bodytextRow)
        bodytextRow.addArrangedSubview(bodytext)
    }
}
