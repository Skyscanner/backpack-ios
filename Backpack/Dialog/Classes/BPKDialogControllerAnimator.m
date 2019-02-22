/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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
#import "BPKDialogControllerAnimator.h"

#import "BPKDialogController.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKDialogControllerAnimator()
@property(nonatomic, assign, class, readonly) NSTimeInterval duration;
@end

@implementation BPKDialogControllerAnimator

- (instancetype)init {
    self = [super init];

    if (self) {
        self.presenting = YES;
    }

    return self;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIViewController *_Nullable controller = self.isPresenting ? [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] : [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BPKDialogController *dialogController = [controller isKindOfClass:[BPKDialogController class]] ? (BPKDialogController *)controller : nil;
    NSAssert(dialogController, @"`UITransitionContextToViewControllerKey` for `BPKDialogControllerAnimator` should always be an instance of `BPKDialogController`");

    if (self.isPresenting) {
        [containerView addSubview:toView];
        if (dialogController) {
            [dialogController _setScrimAlpha:0.0];
        }
        [controller.view layoutIfNeeded];

        [UIView animateKeyframesWithDuration:[[self class] duration] delay:0.0 options:0 animations:^{
            if (dialogController) {
                [dialogController _setScrimAlpha:1.0];
                [dialogController _addPresentingKeyFrameContentAnimationWithRelativeStartTime:0.4 relativeDuration:0.6];
            }
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];

    } else {
        if (dialogController) {
            [dialogController _setScrimAlpha:1.0];
            [controller.view layoutIfNeeded];
        }

        [UIView animateKeyframesWithDuration:[[self class] duration] delay:0.0 options:0 animations:^{
            if (dialogController && dialogController.style == BPKDialogControllerStyleAlert) {
                dialogController.view.alpha = 0.0;
            } else if (dialogController && dialogController.style == BPKDialogControllerStyleBottomSheet) {
                [dialogController _setScrimAlpha:0.0];
                [dialogController _addDismissingKeyFrameContentAnimationWithRelativeStartTime:0.6 relativeDuration:0.4];
            }
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return [[self class] duration];
}

#pragma mark - Private

+ (NSTimeInterval)duration {
    // NOTE: Based on the duration of other transitions in UIKit.
    return 0.35;
}

@end
NS_ASSUME_NONNULL_END
