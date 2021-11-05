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

import Foundation

class BPKHorizontalNavigationItemWithBadge<Size: BPKHorizontalNavigationSize>: UIControl, BPKHorizontalNavigationItem {

    override var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }

    dynamic var selectedColor: UIColor? {
        didSet {
            updateStyle()
        }
    }

    var appearance: BPKHorizontalNavigationAppearance = .normal {
        didSet {
            updateStyle()
        }
    }

    private(set) var showNotificationDot: Bool = false

    private lazy var titleLabel: BPKLabel = {
        let label = BPKLabel(fontStyle: Size.fontStyle)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = contentColor

        return label
    }()

    private lazy var badge: BPKHorizontalNavigationBadge = {
        let badge = BPKHorizontalNavigationBadge(frame: .zero)
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.isUserInteractionEnabled = false
        badge.color = contentColor

        return badge
    }()

    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.spacing = BPKSpacingMd
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .center

        return view
    }()

    private var contentColor: UIColor {
        if isSelected {
            return selectedColor ?? .bpk_primary
        } else {
            switch appearance {
            case .normal: return .bpk_textPrimary
            case .alternate: return .bpk_skyGrayTint07
            }
        }
    }

    init(title: String, badgeMessage: String) {
        super.init(frame: .zero)

        setUp(title: title, badgeMessage: badgeMessage)
    }

    private func notificationLocation(for labelFrame: CGRect) -> CGPoint {
        if BPKRTLSupport.viewIsRTL(self) {
            return CGPoint(x: labelFrame.minX - BPKSpacingMd, y: labelFrame.minY - BPKSpacingSm)
        } else {
            return CGPoint(x: labelFrame.maxX, y: labelFrame.minY - BPKSpacingSm)
        }
    }

    private func setUp(title: String, badgeMessage: String) {
        addSubview(containerView)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(badge)
        badge.message = badgeMessage
        titleLabel.text = title

        setContentCompressionResistancePriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: BPKSpacingBase),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: containerView.trailingAnchor, constant: BPKSpacingBase),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        updateStyle()
    }

    private func updateStyle() {
        titleLabel.textColor = contentColor
        badge.color = contentColor
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
