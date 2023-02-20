//
//  FloatingNotificationAnimator.swift
//  Backpack
//
//  Created by Pontus Ekhem on 17/02/2023.
//

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
    private let animationDuration: TimeInterval = 3// 0.5
    private var hideAfter: TimeInterval = 4.0
    
    private var isRunningAnimation = false
    private var shouldReanimate = false
    
    func animate(hideAfter: TimeInterval) {
        self.hideAfter = hideAfter
        prepareUpAnimation()
        prepareDownAnimation()
    }
    
    private func interceptAnimationIfRequired() {
        if isRunningAnimation {
            print("isRunning 2: \(upAnimator.isRunning)")
            if upAnimator.isRunning == false {
                shouldReanimate = true
//                upAnimator.stopAnimation(false)
                upAnimator.pauseAnimation() // test
                upAnimator.stopAnimation(true)
                downAnimator.pauseAnimation()
                downAnimator.startAnimation()
            }
        }// what if DOWN animator?
    }
    
    // test intercepting during animation
    
    private func prepareUpAnimation() {
        upAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        interceptAnimationIfRequired()
        guard !isRunningAnimation else { return }
            
        upAnimator.addAnimations { [weak self] in
            self?.delegate?.upAnimation()
        }
        upAnimator.addCompletion { [weak self] _ in
            guard let self = self else { return }
            self.prepareDownAnimation()
            self.downAnimator.startAnimation(afterDelay: self.hideAfter)
        }
        isRunningAnimation = true
        upAnimator.startAnimation()
        print("isRunning: \(upAnimator.isRunning)")
    }
    
    private func prepareDownAnimation() {
        downAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        
        downAnimator.addAnimations { [weak self] in
            self?.delegate?.downAnimation()
        }
        
        downAnimator.addCompletion { [weak self] _ in
            self?.delegate?.animationDidFinish()
            self?.isRunningAnimation = false
            
            if self?.shouldReanimate == true {
                self?.shouldReanimate = false
                self?.downAnimator.stopAnimation(true)
                self?.upAnimator.stopAnimation(true)
                self?.prepareUpAnimation()
            }
        }
    }
}

struct FloatingNotificationViewModel {
    let parentView: UIView
    let text: String
    let buttonTitle: String?
    let onTap: (() -> Void)?
    let iconName: BPKIconName?
    let hideAfter: Double
    let didDismiss: (() -> Void)?
}
