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
        stackView.alignment = .center
        stackView.spacing = BPKSpacingMd
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(containerView)

        let imageSkeleton = BPKSkeleton(type: .image)
        let circleSkeleton = BPKSkeleton(type: .circle)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        circleSkeleton.translatesAutoresizingMaskIntoConstraints = false
        imageSkeleton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addArrangedSubview(imageSkeleton)
        containerView.addArrangedSubview(circleSkeleton)
    
//        circleSkeleton.size = .default
//        let headlineSkeleton = BPKSkeleton(type: .headline)
//        let textSkeleton = BPKSkeleton(type: .bodytext)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func imageSkeletonRow() {
        
    }
}
