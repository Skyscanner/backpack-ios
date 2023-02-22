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

protocol FloatingNotificationAnimatorDelegate: AnyObject {
    func upAnimation()
    func downAnimation()
    func animationDidFinish()
}

final class FloatingNotificationAnimator: NSObject {
    
    weak var delegate: FloatingNotificationAnimatorDelegate?
    private var upAnimator = UIViewPropertyAnimator()
    private var downAnimator = UIViewPropertyAnimator()
    private let animationDuration: TimeInterval = 0.5
    private(set) var isNotificationDisplayed = false
    
    func animateUp(hideAfter: TimeInterval, shouldAnimateDownAutomatically: Bool) {
        prepareUpAnimation(
            hideAfter: hideAfter,
            shouldAnimateDownAutomatically: shouldAnimateDownAutomatically
        )
    }
    
    func animateDownNow() {
        upAnimator.stopAnimation(true)
        downAnimator.stopAnimation(true)
        NSObject.cancelPreviousPerformRequests(
            withTarget: self,
            selector: #selector(prepareDownAnimation),
            object: nil
        )
        prepareDownAnimation()
    }
    
    private func prepareUpAnimation(hideAfter: TimeInterval, shouldAnimateDownAutomatically: Bool) {
        upAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        upAnimator.addAnimations { [weak self] in
            self?.delegate?.upAnimation()
        }
        
        if shouldAnimateDownAutomatically {
            upAnimator.addCompletion { [weak self] _ in
                self?.perform(#selector(self?.prepareDownAnimation), with: nil, afterDelay: hideAfter)
            }
        }

        upAnimator.startAnimation()
        isNotificationDisplayed = true
    }
    
    @objc
    private func prepareDownAnimation() {
        downAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        downAnimator.addAnimations { [weak self] in
            self?.delegate?.downAnimation()
        }
        downAnimator.addCompletion { [weak self] _ in
            self?.isNotificationDisplayed = false
            self?.delegate?.animationDidFinish()
        }
        downAnimator.startAnimation()
    }
}
