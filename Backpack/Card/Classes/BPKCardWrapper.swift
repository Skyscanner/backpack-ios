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

    private let card: BPKObjcUIKitCard
    
    private var color: UIColor {
        didSet {
            updateLookAndFeel()
        }
    }
    
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
            updateLookAndFeel()
        }
    }

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true

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
        card: BPKObjcUIKitCard,
        backgroundColor: UIColor
    ) {
        self.header = header
        self.card = card
        self.color = backgroundColor
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLookAndFeel()
    }
    
    private func setup() {
        layer.addSublayer(backgroundLayer)

        stackView.addArrangedSubview(header)
        stackView.addArrangedSubview(card)
        
        addSubview(stackView)

        layer.addSublayer(borderLayer)

        updateLookAndFeel()

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: lineWidth),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -lineWidth)
        ])
    }
    
    private func updateLookAndFeel() {
        stackView.layer.cornerRadius = card.layer.cornerRadius

        backgroundLayer.frame = bounds
        backgroundLayer.backgroundColor = color.cgColor
        backgroundLayer.cornerRadius = card.layer.cornerRadius

        borderLayer.frame = bounds
        borderLayer.borderColor = color.cgColor
        borderLayer.cornerRadius = card.layer.cornerRadius
        
        if let shadow = elevation.shadow {
            shadow.apply(to: layer)
        } else {
            layer.shadowOpacity = 0
        }
    }
}
