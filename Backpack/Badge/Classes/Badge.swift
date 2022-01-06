/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

@objc
public class BPKBadge: UIView {
    private let label = BPKLabel(fontStyle: .textXsEmphasized)
    
    public var message: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    public var type: BPKBadgeType = .success {
        didSet { updateLookAndFeel() }
    }
    
    public convenience init(type: BPKBadgeType = .success, message: String) {
        self.init(frame: .zero)
        self.message = message
        self.type = type
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func updateLookAndFeel() {
        layer.borderWidth = 0
        backgroundColor = type.backgroundColor
        label.textColor = type.textColor
        
        if type == .outline {
            layer.borderColor = BPKColor.white.cgColor
            layer.borderWidth = BPKBorderWidthSm
        }
    }
    
    private func setup() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BPKSpacingMd).isActive = true
        trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: BPKSpacingMd).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: BPKSpacingSm).isActive = true
        bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: BPKSpacingSm).isActive = true
        
        layer.cornerRadius = BPKCornerRadiusXs
        layer.masksToBounds = true
        
        updateLookAndFeel()
    }
    
    func changeContent(color: UIColor) {
        guard type == .outline else { return }
        backgroundColor = BPKColor.clear
        layer.borderColor = color.cgColor
        label.textColor = color
    }
}

fileprivate extension BPKBadgeType {
    var textColor: UIColor {
        guard self == .outline || self == .destructive else {
            return BPKColor.skyGray
        }
        return BPKColor.white
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .success:
            return BPKColor.glencoe
        case .warning:
            return BPKColor.erfoud
        case .destructive:
            return BPKColor.panjin
        case .light:
            return BPKColor.skyGrayTint07
        case .inverse:
            return BPKColor.white
        case .outline:
            return BPKColor.white.withAlphaComponent(0.2)
        }
    }
}
