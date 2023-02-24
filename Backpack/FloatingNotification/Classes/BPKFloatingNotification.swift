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

public final class BPKFloatingNotification: NSObject {
    private static var currentNotification: FloatingNotificationView?
    private static let animator = FloatingNotificationAnimator()
    
    private struct Constants {
        static let displayedBottomConstraintConstant = -BPKSpacingLg
        static let hiddenBottomConstraintConstant: CGFloat = 30.0
    }
    
    public static func show(_ viewModel: FloatingNotificationViewModel) {
        if let notification = currentNotification {
            clearPendingDownAnimation(for: notification)
            animator.animatedDown(
                notification,
                hiddenBottomConstraintConstant: Constants.hiddenBottomConstraintConstant
            ) {
                currentNotification?.onDismissal?()
                currentNotification = nil
                animateUp(with: viewModel)
            }
        } else {
            animateUp(with: viewModel)
        }
    }
    
    private static func animateUp(with viewModel: FloatingNotificationViewModel) {
        let notification = FloatingNotificationView(
            viewModel,
            hiddenBottomConstraintConstant: Constants.hiddenBottomConstraintConstant
        ) { notification in
            animateDown(notification)
        }
        
        animator.animateUp(
            notification: notification,
            displayedBottomConstraintConstant: Constants.displayedBottomConstraintConstant
        )
        currentNotification = notification
        
        guard !UIAccessibility.isVoiceOverRunning else { return }
        perform(#selector(animateDown), with: notification, afterDelay: viewModel.hideAfter)
    }
    
    @objc
    private static func animateDown(_ notification: FloatingNotificationView) {
        animator.animatedDown(
            notification,
            hiddenBottomConstraintConstant: Constants.hiddenBottomConstraintConstant
        ) {
            currentNotification?.onDismissal?()
            currentNotification = nil
        }
    }
    
    private static func clearPendingDownAnimation(for notification: FloatingNotificationView) {
        NSObject.cancelPreviousPerformRequests(
            withTarget: self,
            selector: #selector(animateDown),
            object: notification
        )
    }
}
