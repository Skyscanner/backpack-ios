/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

final class FloatingNotificationView: UIView {
    
    private let shouldAnimateDown: ((FloatingNotificationView) -> Void)
    private let hiddenBottomConstraintConstant: CGFloat
    private let buttonHeight: CGFloat = 20.0
    private let maxWidth: CGFloat = 400.0
    private var onButtonTap: (() -> Void)?
    var onDismissal: (() -> Void)?
    var bottomConstraint = NSLayoutConstraint()
    
    // MARK: Subviews
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.spacing = BPKSpacingMd
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let iconView: BPKIconView = {
        let iconView = BPKIconView(iconName: .none, size: .small)
        iconView.tintColor = BPKColor.textOnDarkColor
        iconView.isAccessibilityElement = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.setContentHuggingPriority(.required, for: .horizontal)
        iconView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return iconView
    }()
    
    let messageLabel: BPKLabel = {
        let label = BPKLabel()
        label.fontStyle = .textFootnote
        label.textColor = BPKColor.textOnDarkColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let button: BPKButton = {
        let button = BPKButton(size: .default, style: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        return button
    }()
    
    // MARK: Initialisation
    public init(
        _ viewModel: FloatingNotificationViewModel,
        hiddenBottomConstraintConstant: CGFloat,
        shouldAnimateDown: @escaping ((FloatingNotificationView) -> Void)
    ) {
        self.hiddenBottomConstraintConstant = hiddenBottomConstraintConstant
        self.shouldAnimateDown = shouldAnimateDown
        super.init(frame: .zero)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        alpha = 0
        backgroundColor = BPKColor.corePrimaryColor
        layer.cornerRadius = BPKCornerRadiusMd
        translatesAutoresizingMaskIntoConstraints = false
        setup()
        setUpAccessibility()
    
        render(viewModel: viewModel)
        setupConstraints(
            relativeTo: viewModel.parentView,
            shouldDisplayButton: viewModel.action != nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(*, unavailable)
    override public init(frame: CGRect) {
        fatalError("init(frame: CGRect) has not been implemented")
    }
    
    private func setup() {
        [iconView, messageLabel, button].forEach { stackView.addArrangedSubview($0) }
        addSubview(stackView)
        BPKShadow.shadowLg().apply(to: layer)
    }
    
    private func render(viewModel: FloatingNotificationViewModel) {
        viewModel.parentView.addSubview(self)
        iconView.iconName = viewModel.iconName
        messageLabel.text = viewModel.title
        button.title = viewModel.action?.title
        onButtonTap = viewModel.action?.action
        onDismissal = viewModel.didDismiss
        
        iconView.isHidden = viewModel.iconName == nil
        button.isHidden = viewModel.action == nil
    }

    private func setupConstraints(
        relativeTo parent: UIView,
        shouldDisplayButton: Bool
    ) {
        bottomConstraint = bottomAnchor.constraint(
            equalTo: parent.safeAreaLayoutGuide.bottomAnchor,
            constant: hiddenBottomConstraintConstant
        )
        
        let stackViewTrailingConstant = shouldDisplayButton ? 0 : -BPKSpacingBase
                
        var constraints = [
            bottomConstraint,
            messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: buttonHeight),
            iconView.heightAnchor.constraint(equalToConstant: buttonHeight),
            button.heightAnchor.constraint(equalToConstant: buttonHeight),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BPKSpacingBase),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: BPKSpacingBase),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: stackViewTrailingConstant),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -BPKSpacingBase),
            centerXAnchor.constraint(equalTo: parent.centerXAnchor)
        ]
        
        let largeScreenWidth = maxWidth + (BPKSpacingBase * 2)
        let isLargeScreen = parent.bounds.width > largeScreenWidth
        
        if isLargeScreen {
            constraints.append(widthAnchor.constraint(equalToConstant: maxWidth))
        } else {
            constraints.append(leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: BPKSpacingBase))
            constraints.append(trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -BPKSpacingBase))
        }
        NSLayoutConstraint.activate(constraints)
        parent.layoutIfNeeded()
    }
    
    @objc
    private func buttonTapped() {
        onButtonTap?()
    }
}

// MARK: Accessibility
extension FloatingNotificationView {
    @objc
    private func setUpAccessibility() {
        if UIAccessibility.isVoiceOverRunning {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(setUpAccessibility),
                name: UIAccessibility.voiceOverStatusDidChangeNotification,
                object: nil
            )
            
            NotificationCenter.default.addObserver(
                forName: UIAccessibility.elementFocusedNotification,
                object: nil,
                queue: OperationQueue.main
            ) { [weak self] (notification: Notification) in
                self?.accessibilityElementChanged(notification)
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel))
            messageLabel.addGestureRecognizer(tap)
            messageLabel.isUserInteractionEnabled = true
        } else {
            NotificationCenter.default.removeObserver(
                self,
                name: UIAccessibility.elementFocusedNotification,
                object: nil
            )
            messageLabel.gestureRecognizers?.removeAll()
        }
    }
    
    @objc
    private func accessibilityElementChanged(_ notification: Notification) {
        guard
            let focusedView = notification.userInfo?[UIAccessibility.focusedElementUserInfoKey] as? UIView,
            focusedView != button,
            focusedView != messageLabel
        else { return }
        shouldAnimateDown(self)
    }

    @objc
    private func didTapLabel() {
        shouldAnimateDown(self)
    }
}
