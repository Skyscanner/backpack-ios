/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

@objcMembers
@objc(BPKBadgeIcon)
public final class BPKBadgeIcon: UIView {
    
    public var type: BPKBadgeType = .success {
        didSet {
            setType(type)
        }
    }
    
    public var message: String? {
        get {
            self.label.text
        }
        
        set {
            self.label.text = newValue
        }
    }
    
    public var icons: [BPKIconView]?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = BPKSpacingSm
        
        return stackView
    }()
    
    private lazy var label: BPKLabel = {
        let label = BPKLabel(fontStyle: .textXs)
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(message: String) {
        self.init(type: .success, message: message, icons: [])
    }
    
    public convenience init(type: BPKBadgeType, message: String) {
        self.init(type: type, message: message, icons: [])
    }
    
    public convenience init(type: BPKBadgeType, message: String, icons: [BPKIconName]) {
        self.init(frame: .zero)
        
        self.type = type
        self.message = message
        self.icons = icons.map { BPKIconView(iconName: $0, size: .small) }
        
        self.setupContent()
    }
}

extension BPKBadgeIcon {
    private func setup() {
        [stackView, label].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
       
        self.addSubview(stackView)
        self.layer.cornerRadius = BPKCornerRadiusXs
        self.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BPKSpacingMd),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: BPKSpacingSm),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: BPKSpacingMd),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: BPKSpacingSm)
        ])
    }
    
    private func changeContentContenColor(color: UIColor) {
        if type == .outline {
            self.backgroundColor = .bpk_clear
            self.layer.borderColor = color.cgColor
            self.label.textColor = color
        }
    }
    
    private func setupContent() {
        icons?.forEach { icon in
            icon.setContentCompressionResistancePriority(.required, for: .horizontal)
            stackView.addArrangedSubview(icon)
        }

        if let message = message, !message.isEmpty {
            stackView.addArrangedSubview(label)
        }
    }
    
    private func setType(_ type: BPKBadgeType) {
        switch type {
        case .success:
            self.backgroundColor = .bpk_glencoe
        case .warning:
            self.backgroundColor = .bpk_erfoud
        case .destructive:
            self.backgroundColor = .bpk_panjin
        case .light:
            self.backgroundColor = .bpk_skyGrayTint07
        case .inverse:
            self.backgroundColor = .bpk_white
        case .outline:
            self.backgroundColor = BPKColor.white.withAlphaComponent(0.2)
            self.layer.borderColor = BPKColor.white.cgColor
            self.layer.borderWidth = BPKBorderWidthSm
        default:
            break
        }
        
        if type == .outline || type == .destructive {
            label.textColor = .bpk_white
            icons?.forEach { $0.tintColor = .bpk_white }
        } else {
            label.textColor = .bpk_skyGray
            icons?.forEach { $0.tintColor = .bpk_skyGray }
        }
    }
}
