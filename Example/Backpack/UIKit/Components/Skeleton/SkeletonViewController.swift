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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = BPKColor.canvasColor
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BPKSkeleton.startShimmer(view: containerView)
    }
    
    private func setupView() {
        view.addSubview(containerView)
        
        containerView.addArrangedSubview(generate(title: "Image"))
        containerView.addArrangedSubview(generateRow(type: .image))
        
        containerView.addArrangedSubview(generate(title: "Circle"))
        containerView.addArrangedSubview(generateRow(type: .circle))
        
        containerView.addArrangedSubview(generate(title: "Headline"))
        containerView.addArrangedSubview(generateRow(type: .headline))
        
        containerView.addArrangedSubview(generate(title: "BodyText"))
        containerView.addArrangedSubview(generateRow(type: .bodytext))
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            containerView.topAnchor.constraint(
                equalTo: view.readableContentGuide.topAnchor,
                constant: BPKSpacingBase
            ),
            containerView.bottomAnchor.constraint(
                equalTo: view.readableContentGuide.bottomAnchor,
                constant: -BPKSpacingBase
            )
        ])
    }
}

// MARK: Helper functions
extension SkeletonViewController {
    private func generateRow(type: BPKSkeletonType) -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .bottom
        stackView.spacing = BPKSpacingBase
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        generateSkeletons(
            withType: type,
            sizes: sizes(forType: type),
            styles: styles(forType: type)
        ).forEach(stackView.addArrangedSubview(_:))
        
        return stackView
    }
    
    private func generate(title: String) -> BPKLabel {
        let label = BPKLabel(fontStyle: .textHeading5)
        label.text = title
        
        return label
    }
    
    private func generateSkeletons(
        withType type: BPKSkeletonType,
        sizes: [BPKSkeletonSize],
        styles: [BPKSkeletonStyle]) -> [BPKSkeleton] {
        var skeletons = [BPKSkeleton]()
        
        sizes.forEach { size in
            styles.forEach { style in
                skeletons.append(BPKSkeleton(type: type, size: size, style: style))
            }
        }
        
        return skeletons
    }
    
    private func sizes(forType type: BPKSkeletonType) -> [BPKSkeletonSize] {
        switch type {
        case .image:
            return [.default]
        case .headline:
            return [.small, .default, .large]
        case .circle:
            return [.small, .default]
        case .bodytext:
            return [.default]
        }
    }
    
    private func styles(forType type: BPKSkeletonType) -> [BPKSkeletonStyle] {
        switch type {
        case .image:
            return [.default, .rounded]
        default:
            return [.default]
        }
    }
}
