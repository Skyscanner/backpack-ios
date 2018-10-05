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

#import "BPKDialogController.h"

#import "BPKDialogButtonAction.h"
#import "BPKDialogScrimAction.h"
#import "BPKDialogControllerAnimator.h"

#import <Backpack/Color.h>
#import <Backpack/Spacing.h>
#import <Backpack/Font.h>
#import <Backpack/Color.h>
#import <Backpack/Button.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKDialogController()

@property(nonatomic, strong) UIColor *headColor;
@property(nonatomic, strong) UIImage *iconImage;
@property(nonatomic, copy) NSString *titleText;
@property(nonatomic, copy) NSString *messageText;

@property(nonatomic, strong) UIView *scrimView;
@property(nonatomic, strong) BPKDialogView *dialogView;

@property(nonatomic, strong) BPKDialogScrimAction *scrimAction;

@property(nonatomic, strong) NSLayoutConstraint *bottomAnchorConstraint;
@end

@implementation BPKDialogController

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                        style:(BPKDialogControllerStyle)style
                  shadowStyle:(BPKDialogControllerShadowStyle)shadowStyle
                    headColor:(UIColor *)headColor
                    iconImage:(UIImage *)iconImage {
    self = [super init];

    if (self) {
        self.titleText = title;
        self.messageText = message;
        self.style = style;
        self.shadowStyle = shadowStyle;
        self.headColor = headColor;
        self.iconImage = iconImage;
        self.transitioningDelegate = self;

        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }
    
    return self;
}

+ (instancetype)dialogControllerWithTitle:(NSString *)title
                                  message:(NSString *)message
                                    style:(BPKDialogControllerStyle)style
                              shadowStyle:(BPKDialogControllerShadowStyle)shadowStyle
                                headColor:(UIColor *)headColor
                                iconImage:(UIImage *)iconImage {
    return [[self alloc] initWithTitle:title message:message style:style shadowStyle:shadowStyle headColor:headColor iconImage:iconImage];
}

- (void)setupViews {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrimTapped:)];
    
    self.scrimView = [UIView new];
    self.scrimView.clipsToBounds = YES;
    self.scrimView.userInteractionEnabled = YES;
    self.scrimView.backgroundColor = BPKColor.gray900;
    self.scrimView.alpha = 0.5;
    self.scrimView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrimView addGestureRecognizer:tapGesture];

    self.dialogView = [[BPKDialogView alloc] initWithFrame:CGRectZero];
    self.dialogView.translatesAutoresizingMaskIntoConstraints = NO;
    self.dialogView.delegate = self;
    [self.dialogView setTitle:self.titleText];
    [self.dialogView setIconImage:self.iconImage];
    self.dialogView.hasShadow = self.shadowStyle == BPKDialogControllerShadowStyleShadow;
    [self.dialogView setDescription:self.messageText];
    [self.dialogView setIconBackgroundColor:self.headColor];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
                                              [self.scrimView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.scrimView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.scrimView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [self.scrimView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],

                                              [self.dialogView.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor constant:(BPKSpacingMd + BPKSpacingSm)],
                                              [self.view.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:self.dialogView.trailingAnchor constant:(BPKSpacingMd + BPKSpacingSm)],
                                              ]];
    
    [self.dialogView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    if (self.style == BPKDialogControllerStyleBottomSheet) {
        self.bottomAnchorConstraint = [self.dialogView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
        self.bottomAnchorConstraint.active = YES;
    } else if (self.style == BPKDialogControllerStyleAlert) {
        [self.dialogView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    }
}

- (void)addViews {
    [self.view addSubview:self.scrimView];
    [self.view addSubview:self.dialogView];
}

- (void)scrimTapped:(UITapGestureRecognizer *)gestureRecognizer {
    if( gestureRecognizer.state == UIGestureRecognizerStateRecognized ) {
        [self dismissDialogWithScrimTap];
    }
}

- (void)dismissDialogWithScrimTap {
    if (self.scrimAction.handler) {
        self.scrimAction.handler(self.scrimAction.shouldDismiss);
    }
    
    if (self.scrimAction.shouldDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

- (UIModalTransitionStyle)modalTransitionStyle {
    return UIModalTransitionStyleCoverVertical;
}

#pragma mark - Public

- (void)addScrimAction:(BPKDialogScrimAction *)action {
    self.scrimAction = action;
}

- (void)addButtonAction:(BPKDialogButtonAction *)action {
    [self.dialogView addButtonAction:action];
}

- (void)addPresentingKeyFrameContentAnimationWithRelativeStartTime:(double)startTime relativeDuration:(double)duration {
    if (self.style == BPKDialogControllerStyleBottomSheet) {
        CGSize sheetSize = [self.dialogView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        self.bottomAnchorConstraint.constant = sheetSize.height;
        [self.view layoutIfNeeded];

        self.bottomAnchorConstraint.constant = 0.0;
        [UIView addKeyframeWithRelativeStartTime:startTime relativeDuration:duration animations:^{
            [self.view layoutIfNeeded];
        }];
    } else {
        self.dialogView.alpha = 0.0;
        [UIView addKeyframeWithRelativeStartTime:startTime relativeDuration:duration animations:^{
            self.dialogView.alpha = 1.0;
        }];
    }
}

- (void)addDismissingKeyFrameContentAnimationWithRelativeStartTime:(double)startTime relativeDuration:(double)duration {
    if (self.style == BPKDialogControllerStyleBottomSheet) {
        CGSize sheetSize = [self.dialogView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        self.bottomAnchorConstraint.constant = 0;
        [self.view layoutIfNeeded];

        self.bottomAnchorConstraint.constant = sheetSize.height;
        [UIView addKeyframeWithRelativeStartTime:startTime relativeDuration:duration animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)setScrimAlpha:(double)scrimAlpha {
    self.scrimView.alpha = 0.5 * fmax(fmin(scrimAlpha, 1.0), 0.0);
}

#pragma mark - BPKDialogViewDelegate

- (void)didInvokeButtonAction:(BPKDialogButtonAction *)action {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            action.handler(action);
        }];
    });
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [BPKDialogControllerAnimator new];
}

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    BPKDialogControllerAnimator *animator = [BPKDialogControllerAnimator new];
    animator.presenting = NO;

    return animator;
}

@end

NS_ASSUME_NONNULL_END
