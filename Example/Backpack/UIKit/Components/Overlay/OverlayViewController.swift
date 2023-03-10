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

class OverlayViewController: UIViewController {
    
    private let types: [BPKOverlayType]
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = BPKSpacingBase
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(types: [BPKOverlayType]) {
        self.types = types
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = BPKColor.canvasColor
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: BPKSpacingBase)
        ])
        
        setupOverlays()
    }
    
    private func setupOverlays() {
//        let levels: [BPKOverlayLevel] = [.off, .low, .medium, .high]
        
//        levels.forEach { level in
//            if type != .solid && level == .off {
//                return
//           }
//
//            let innerStackView = UIStackView()
//            innerStackView.translatesAutoresizingMaskIntoConstraints = false
//            innerStackView.axis = .vertical
//            innerStackView.spacing = BPKSpacingSm
//
//            let overlay = getOverlayView(level)
//
//            let label = BPKLabel(fontStyle: .textCaption)
//            label.text = "\(self.type) / \(level)"
//
//            innerStackView.addArrangedSubview(overlay)
//            innerStackView.addArrangedSubview(label)
//
//            stackView.addArrangedSubview(innerStackView)
//
//            NSLayoutConstraint.activate([
//                overlay.widthAnchor.constraint(equalToConstant: 110),
//                overlay.heightAnchor.constraint(equalToConstant: 110)
//            ])
//        }
    }
    
    private func getOverlayView() -> UIView {
        let overlay = BPKOverlayView(overlayType: .leftLow)
        
        let overlayVignette = BPKOverlayView(overlayType: .vignette)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(named: "overlay_example"))
        overlay.setImageView(imageView)
        
        overlay.clipsToBounds = true
        overlay.layer.cornerRadius = BPKCornerRadiusLg
        
        return overlay
    }
}
