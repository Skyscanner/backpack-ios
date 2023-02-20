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

final class FloatingNotificationAnimator {
    
    weak var delegate: FloatingNotificationAnimatorDelegate?
    private var upAnimator = UIViewPropertyAnimator()
    private var downAnimator = UIViewPropertyAnimator()
    private let animationDuration: TimeInterval = 0.5
    private(set) var isNotificationDisplayed = false
    
    func animateUp(hideAfter: TimeInterval) {
        prepareUpAnimation(hideAfter: hideAfter)
    }
    
    func animateDownNow() {
        if upAnimator.isRunning {
            upAnimator.isReversed = true
        } else {
            upAnimator.stopAnimation(true)
            downAnimator.pauseAnimation()
            downAnimator.startAnimation()
        }
    }
    
    private func prepareUpAnimation(hideAfter: TimeInterval) {
        upAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        upAnimator.addAnimations { [weak self] in
            self?.delegate?.upAnimation()
        }
        upAnimator.addCompletion { [weak self] _ in
            self?.prepareDownAnimation(hideAfter: hideAfter)
        }
        isNotificationDisplayed = true
        upAnimator.startAnimation()
    }
    
    private func prepareDownAnimation(hideAfter: TimeInterval) {
        downAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        downAnimator.addAnimations { [weak self] in
            self?.delegate?.downAnimation()
        }
        downAnimator.addCompletion { [weak self] _ in
            self?.isNotificationDisplayed = false
            self?.delegate?.animationDidFinish()
        }
        downAnimator.startAnimation(afterDelay: hideAfter)
    }
}
