//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

import Foundation
import Backpack

class PageIndicatorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.surfaceDefaultColor
        createView()
    }
    
    private func createView() {
        let defaultPageIndicator = BPKPageIndicator(
            variant: .default,
            currentIndex: 0,
            totalIndicators: 3
        )
        
        let imageBackground = UIImageView(image: UIImage(named: "dialog_image")!)
        imageBackground.isUserInteractionEnabled = true
        
        let overImagePageIndicator = BPKPageIndicator(
            variant: .overImage,
            currentIndex: 0,
            totalIndicators: 3
        )
        overImagePageIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        imageBackground.addSubview(overImagePageIndicator)
        
        let stackView = UIStackView(arrangedSubviews: [defaultPageIndicator, imageBackground])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = BPKSpacingBase
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            overImagePageIndicator.centerXAnchor.constraint(equalTo: imageBackground.centerXAnchor),
            overImagePageIndicator.bottomAnchor.constraint(
                equalTo: imageBackground.bottomAnchor,
                constant: -BPKSpacingBase
            )
        ])
    }
}
