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

    private let header: UIView

    private let card: BPKCard
    
    private var color: UIColor
    
    public override var backgroundColor: UIColor? {
        get {
            return color
        }
        set {
            color = newValue ?? color
        }
    }
    
    public var elevation: BPKCardElevation = .default {
        didSet {
            updateShadows()
        }
    }

    private lazy var stackView: UIStackView = {
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
    
    private lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.masksToBounds = true
        return layer
    }()
    
    public init(
        header: UIView,
        card: BPKCard,
        backgroundColor: UIColor
    ) {
        self.header = header
        self.card = card
        self.color = backgroundColor
        super.init(frame: .zero)
        
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundLayer.frame = bounds
        backgroundLayer.backgroundColor = color.cgColor
        
        borderLayer.frame = bounds
        borderLayer.borderColor = color.cgColor
    }
    
    private func setup() {
        layer.addSublayer(backgroundLayer)
        backgroundLayer.cornerRadius = card.layer.cornerRadius

        addSubview(stackView)
        stackView.addArrangedSubview(header)
        stackView.addArrangedSubview(card)
        stackView.layer.cornerRadius = card.layer.cornerRadius
        stackView.layer.masksToBounds = true

        layer.addSublayer(borderLayer)
        borderLayer.cornerRadius = card.layer.cornerRadius

        updateShadows()

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: lineWidth),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -lineWidth)])
    }
    
    private func updateShadows() {
        guard let shadow = elevation.shadow else {
            layer.shadowOpacity = 0
            return
        }
        shadow.apply(to: layer)
    }
}
