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

import UIKit
import Backpack

class OverlayForegroundViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = BPKColor.canvasColor
        setupView()
    }
    
    private func setupView() {
        let content = UIImageView(image: UIImage(named: "overlay_example"))
        
        let foregroundContent = BPKLabel(fontStyle: .textHero5)
        foregroundContent.text = "Barcelona"
        foregroundContent.textColor = BPKColor.textOnDarkColor
        foregroundContent.translatesAutoresizingMaskIntoConstraints = false
        
        let overlay = BPKOverlay(content: content, overlayType: .bottomMedium, foregroundContent: foregroundContent)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        
        overlay.clipsToBounds = true
        overlay.layer.cornerRadius = BPKCornerRadiusLg
        
        view.addSubview(overlay)
        
        NSLayoutConstraint.activate([
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BPKSpacingBase),
            overlay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: BPKSpacingBase),
            view.trailingAnchor.constraint(equalTo: overlay.trailingAnchor, constant: BPKSpacingBase),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: overlay.bottomAnchor, constant: BPKSpacingBase),
            
            foregroundContent.leadingAnchor.constraint(equalTo: overlay.leadingAnchor, constant: BPKSpacingLg),
            overlay.bottomAnchor.constraint(equalTo: foregroundContent.bottomAnchor, constant: BPKSpacingLg)
        ])
    }
}
