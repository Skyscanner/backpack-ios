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

final class FloatingNotificationAnimator {
    
    private var upAnimator = UIViewPropertyAnimator()
    private var downAnimator = UIViewPropertyAnimator()
    private let animationDuration: TimeInterval = 0.5
    
    func animateUp(
        notification: FloatingNotificationView,
        displayedBottomConstraintConstant: CGFloat
    ) {
        upAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        upAnimator.addAnimations {
            notification.alpha = 1
            notification.bottomConstraint.constant = displayedBottomConstraintConstant
            notification.superview?.layoutIfNeeded()
            UIAccessibility.post(notification: .layoutChanged, argument: notification.messageLabel)
        }
        upAnimator.startAnimation()
    }

    func animatedDown(
        _ notification: FloatingNotificationView,
        hiddenBottomConstraintConstant: CGFloat,
        completion: (() -> Void)?
    ) {
        upAnimator.stopAnimation(true)
        downAnimator.stopAnimation(false)
        downAnimator.finishAnimation(at: .current)
        
        downAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        
        downAnimator.addAnimations {
            notification.alpha = 0
            notification.bottomConstraint.constant = hiddenBottomConstraintConstant
            notification.superview?.layoutIfNeeded()
        }
        downAnimator.addCompletion { _ in
            completion?()
        }
        downAnimator.startAnimation()
    }
}
