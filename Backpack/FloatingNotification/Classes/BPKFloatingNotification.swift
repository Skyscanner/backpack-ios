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

public final class BPKFloatingNotification: UIView {
    
    private struct Constants {
        static let buttonHeight: CGFloat = 20.0
        static let maxWidth: CGFloat = 400.0
        static let startBottomConstraint: CGFloat = 30.0
    }
    
    private var onButtonTap: (() -> Void)?
    private var onDismissal: (() -> Void)?
    
    private var bottomConstraint = NSLayoutConstraint()
    private let animator = FloatingNotificationAnimator()
    private var notificationsQueue = [FloatingNotificationViewModel]()
    
    // MARK: Subviews
    private let stackView: UIStackView = {
        let result = UIStackView()
        result.distribution = .fillProportionally
        result.alignment = .center
        result.axis = .horizontal
        result.spacing = BPKSpacingMd
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private let iconView: BPKIconView = {
        let result = BPKIconView(iconName: .none, size: .small)
        result.tintColor = BPKColor.textOnDarkColor
        result.isAccessibilityElement = false
        result.translatesAutoresizingMaskIntoConstraints = false
        result.setContentHuggingPriority(.required, for: .horizontal)
        result.setContentCompressionResistancePriority(.required, for: .horizontal)
        return result
    }()
    
    private let messageLabel: BPKLabel = {
        let result = BPKLabel()
        result.fontStyle = .textFootnote
        result.textColor = BPKColor.textOnDarkColor
        result.textAlignment = .natural
        result.numberOfLines = 0
        result.lineBreakMode = .byWordWrapping
        result.translatesAutoresizingMaskIntoConstraints = false
        result.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return result
    }()
    
    private let button: BPKButton = {
        let result = BPKButton(size: .default, style: .primary)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.setContentHuggingPriority(.required, for: .horizontal)
        result.setContentCompressionResistancePriority(.required, for: .horizontal)
        return result
    }()
    
    // MARK: Initialisation
    public init() {
        super.init(frame: .zero)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        animator.delegate = self
        alpha = 0
        backgroundColor = BPKColor.corePrimaryColor
        layer.cornerRadius = BPKCornerRadiusMd
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [iconView, messageLabel, button].forEach { stackView.addArrangedSubview($0) }
        addSubview(stackView)
    }
    
    // MARK: Animation & rendering
    public func show(
        presentOn parentView: UIView,
        text: String,
        buttonTitle: String? = nil,
        onTap: (() -> Void)? = nil,
        iconName: BPKIconName? = nil,
        hideAfter: TimeInterval = 4.0,
        didDismiss: (() -> Void)? = nil
    ) {
        let viewModel = FloatingNotificationViewModel(
            parentView: parentView,
            text: text,
            buttonTitle: buttonTitle,
            onTap: onTap,
            iconName: iconName,
            hideAfter: hideAfter,
            didDismiss: didDismiss
        )
        
        notificationsQueue.append(viewModel)
        renderNext()
    }
    
    private func renderNext() {
        if let nextViewModel = notificationsQueue.first, !animator.isNotificationDisplayed {
            render(viewModel: nextViewModel)
            animator.animateUp(hideAfter: nextViewModel.hideAfter)
        } else if animator.isNotificationDisplayed {
            animator.animateDownNow()
        }
    }
    
    private func render(viewModel: FloatingNotificationViewModel) {
        viewModel.parentView.addSubview(self)
        iconView.iconName = viewModel.iconName
        messageLabel.text = viewModel.text
        button.title = viewModel.buttonTitle
        onButtonTap = viewModel.onTap
        onDismissal = viewModel.didDismiss
        
        iconView.isHidden = viewModel.iconName == nil
        button.isHidden = viewModel.buttonTitle == nil && viewModel.onTap == nil
        
        setupConstraints(relativeTo: viewModel.parentView)
        viewModel.parentView.layoutIfNeeded()
    }

    private func setupConstraints(relativeTo parent: UIView) {
        constraints.forEach { removeConstraint($0) }
        
        bottomConstraint = bottomAnchor.constraint(
            equalTo: parent.safeAreaLayoutGuide.bottomAnchor,
            constant: Constants.startBottomConstraint
        )
        
        var constraints = [
            bottomConstraint,
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BPKSpacingBase),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: BPKSpacingBase),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -BPKSpacingBase),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -BPKSpacingBase)
        ]
        if traitCollection.userInterfaceIdiom == .pad {
            constraints.append(widthAnchor.constraint(equalToConstant: Constants.maxWidth))
            constraints.append(centerXAnchor.constraint(equalTo: parent.centerXAnchor))
        } else {
            constraints.append(leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: BPKSpacingBase))
            constraints.append(trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -BPKSpacingBase))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    private func buttonTapped() {
        onButtonTap?()
    }
}

extension BPKFloatingNotification: FloatingNotificationAnimatorDelegate {
    func upAnimation() {
        alpha = 1
        bottomConstraint.constant = -BPKSpacingLg
        superview?.layoutIfNeeded()
        messageLabel.isAccessibilityElement = true
        button.isAccessibilityElement = true
        UIAccessibility.post(notification: .layoutChanged, argument: messageLabel)
    }
    
    func downAnimation() {
        alpha = 0
        bottomConstraint.constant = Constants.startBottomConstraint
        superview?.layoutIfNeeded()
        messageLabel.isAccessibilityElement = false
        button.isAccessibilityElement = false
    }
    
    func animationDidFinish() {
        onDismissal?()
        notificationsQueue.removeFirst()
        renderNext()
    }
}
