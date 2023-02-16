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
import UIKit

public class BPKCardWrapper: UIView {

    private let lineWidth: CGFloat = 2

    public let header: UIView

    public let card: BPKCard

    private lazy var stactView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var borderLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = BPKColor.clear.cgColor
        layer.borderWidth = lineWidth
        
        return layer
    }()
    
    public init(
        header: UIView,
        card: BPKCard,
        backgroundColor: UIColor
    ) {
        self.header = header
        self.card = card
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        borderLayer.frame = bounds
        borderLayer.borderColor = self.backgroundColor?.cgColor
        borderLayer.cornerRadius = card.layer.cornerRadius
    }
    
    private func setup() {
        self.addSubview(stactView)
        stactView.addArrangedSubview(header)
        stactView.addArrangedSubview(card)
        
        layer.cornerRadius = card.layer.cornerRadius
        layer.masksToBounds = true
        layer.addSublayer(borderLayer)
        
        NSLayoutConstraint.activate([
            stactView.topAnchor.constraint(equalTo: topAnchor),
            stactView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stactView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: lineWidth),
            stactView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -lineWidth)])
    }
}
