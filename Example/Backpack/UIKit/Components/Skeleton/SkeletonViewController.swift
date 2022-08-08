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
    var rounded = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = BPKSpacingMd
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        let imageSkeleton = BPKSkeleton(type: .image)
        let circleSkeleton = BPKSkeleton(type: .circle)
        let headlineSkeleton = BPKSkeleton(type: .headline)
        let textSkeleton = BPKSkeleton(type: .bodytext)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        imageSkeleton.style = .rounded
        [imageSkeleton, circleSkeleton, headlineSkeleton, textSkeleton].forEach(stack.addArrangedSubview)
    }
}
