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

#import "BPKDialogController.h"

#import <Backpack/Button.h>
#import <Backpack/Color.h>
#import <Backpack/Radii.h>
#import <Backpack/Spacing.h>

#import "BPKDialogButtonAction.h"
#import "BPKDialogControllerAnimator.h"
#import "BPKDialogIconDefinition.h"
#import "BPKDialogScrimAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKDialogController ()

@property(nullable, nonatomic, copy) NSString *titleText;
@property(nonatomic, copy) NSString *messageText;

@property(nonatomic, strong) UIView *scrimView;
@property(nonatomic, strong) BPKDialogView *dialogView;
@property(nullable, nonatomic, strong) BPKFlareView *flareView;

@property(nonatomic, strong) NSMutableArray<BPKDialogScrimAction *> *scrimActions;

@property(nonatomic, strong) NSLayoutConstraint *bottomAnchorConstraint;
@property(nonatomic, strong) UIColor *scrimViewBackgroundColor;

- (instancetype)initWithTitle:(NSString *_Nullable)title
                      message:(NSString *)message
                        style:(BPKDialogControllerStyle)style
               iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition;
@end

@implementation BPKDialogController

- (instancetype)initWithTitle:(NSString *_Nullable)title
                      message:(NSString *)message
                        style:(BPKDialogControllerStyle)style
               iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition {
    return [self initWithTitle:title message:message style:style iconDefinition:iconDefinition flareView:nil];
}

- (instancetype)initWithTitle:(NSString *_Nullable)title
                      message:(NSString *)message
                        style:(BPKDialogControllerStyle)style
               iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition
                    flareView:(BPKFlareView *_Nullable)flareView {
    self = [super init];

    if (self) {
        self.buttonSize = BPKButtonSizeLarge;
        self.titleText = title;
        self.messageText = message;
        self.style = style;
        self.iconDefinition = iconDefinition;
        self.flareView = flareView;
        self.scrimActions = [NSMutableArray new];
        self.transitioningDelegate = self;

        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }

    return self;
}

+ (instancetype)dialogControllerWithTitle:(NSString *_Nullable)title
                                  message:(NSString *)message
                                    style:(BPKDialogControllerStyle)style
                           iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition {
    return [[self alloc] initWithTitle:title message:message style:style iconDefinition:iconDefinition];
}

+ (instancetype)dialogControllerWithTitle:(NSString *_Nullable)title
                                  message:(NSString *)message
                                    style:(BPKDialogControllerStyle)style
                           iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition
                                flareView:(BPKFlareView *_Nullable)flareView {
    return [[self alloc] initWithTitle:title message:message style:style iconDefinition:iconDefinition flareView:flareView];
}

- (void)setupViews {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrimTapped:)];

    self.scrimView = [[UIView alloc] initWithFrame:CGRectZero];
    self.scrimView.clipsToBounds = YES;
    self.scrimView.userInteractionEnabled = YES;
    self.scrimView.backgroundColor = self.scrimViewBackgroundColor;
    self.scrimView.alpha = 0.5;
    self.scrimView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrimView.accessibilityIdentifier = @"dialogScrimView";
    [self.scrimView addGestureRecognizer:tapGesture];

    self.dialogView = [[BPKDialogView alloc] initWithTitle:self.titleText
                                                   message:self.messageText
                                            iconDefinition:self.iconDefinition
                                                 flareView:self.flareView];
    self.dialogView.translatesAutoresizingMaskIntoConstraints = NO;
    self.dialogView.delegate = self;
    self.dialogView.style = self.style;
    self.dialogView.accessibilityIdentifier = @"dialogView";
}

- (void)setupConstraints {
    NSLayoutConstraint *lowerWidthConstraint = [self.dialogView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.view.widthAnchor
                                                                                                      multiplier:0.8];
    lowerWidthConstraint.priority = UILayoutPriorityDefaultHigh;

    [NSLayoutConstraint activateConstraints:@[
        [self.scrimView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrimView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrimView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.scrimView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],

        [self.dialogView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor],
        [self.view.layoutMarginsGuide.trailingAnchor constraintGreaterThanOrEqualToAnchor:self.dialogView.trailingAnchor],

        [self.dialogView.widthAnchor constraintLessThanOrEqualToConstant:BPKSpacingXxl * 13],
        lowerWidthConstraint,
        [self.dialogView.heightAnchor constraintLessThanOrEqualToConstant:BPKSpacingXxl * 18],
    ]];

    [self.dialogView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    if (self.style == BPKDialogControllerStyleBottomSheet) {
        self.bottomAnchorConstraint = [self.dialogView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
        self.bottomAnchorConstraint.active = YES;
    } else if (self.style == BPKDialogControllerStyleAlert) {
        [NSLayoutConstraint activateConstraints:@[
            [self.dialogView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
            [self.dialogView.topAnchor constraintGreaterThanOrEqualToAnchor:self.view.layoutMarginsGuide.topAnchor constant:BPKSpacingLg],
            [self.view.layoutMarginsGuide.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.dialogView.bottomAnchor constant:BPKSpacingLg]
        ]];
    }
}

- (void)setCornerStyle:(BPKDialogCornerStyle)cornerStyle {
    if (_cornerStyle != cornerStyle) {
        _cornerStyle = cornerStyle;

        self.dialogView.cornerStyle = cornerStyle;
    }
}

- (void)setButtonSize:(BPKButtonSize)buttonSize {
    if (_buttonSize != buttonSize) {
        _buttonSize = buttonSize;

        self.dialogView.buttonSize = buttonSize;
    }
}

- (void)setIconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition {
    _iconDefinition = iconDefinition;
    if (self.dialogView != nil) {
        self.dialogView.iconDefinition = iconDefinition;
    }
}

- (void)addViews {
    [self.view addSubview:self.scrimView];
    [self.view addSubview:self.dialogView];
}

- (void)scrimTapped:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
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

- (void)addButtonAction:(BPKDialogButtonAction *)action {
    [self.dialogView addButtonAction:action];
}

- (void)_addPresentingKeyFrameContentAnimationWithRelativeStartTime:(double)startTime relativeDuration:(double)duration {
    if (self.style == BPKDialogControllerStyleBottomSheet) {
        CGSize sheetSize = [self.dialogView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        self.bottomAnchorConstraint.constant = sheetSize.height;
        [self.view layoutIfNeeded];

        self.bottomAnchorConstraint.constant = 0.0;
        [UIView addKeyframeWithRelativeStartTime:startTime
                                relativeDuration:duration
                                      animations:^{
                                        [self.view layoutIfNeeded];
                                      }];
    } else {
        self.dialogView.alpha = 0.0;
        [UIView addKeyframeWithRelativeStartTime:startTime
                                relativeDuration:duration
                                      animations:^{
                                        self.dialogView.alpha = 1.0;
                                      }];
    }
}

- (void)_addDismissingKeyFrameContentAnimationWithRelativeStartTime:(double)startTime relativeDuration:(double)duration {
    if (self.style == BPKDialogControllerStyleBottomSheet) {
        CGSize sheetSize = [self.dialogView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        self.bottomAnchorConstraint.constant = 0;
        [self.view layoutIfNeeded];

        self.bottomAnchorConstraint.constant = sheetSize.height;
        [UIView addKeyframeWithRelativeStartTime:startTime
                                relativeDuration:duration
                                      animations:^{
                                        [self.view layoutIfNeeded];
                                      }];
    }
}

- (void)_setScrimAlpha:(double)scrimAlpha {
    double multiplier = UIAccessibilityIsReduceTransparencyEnabled() ? 0.9 : 0.5;
    self.scrimView.alpha = multiplier * fmax(fmin(scrimAlpha, 1.0), 0.0);
}

#pragma mark - BPKDialogViewDelegate

- (void)didInvokeButtonAction:(BPKDialogButtonAction *)action {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self dismissViewControllerAnimated:YES
                               completion:^{
                                 action.handler(action);
                               }];
    });
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                           presentingController:(UIViewController *)presenting
                                                                               sourceController:(UIViewController *)source {
    return [BPKDialogControllerAnimator new];
}

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    BPKDialogControllerAnimator *animator = [BPKDialogControllerAnimator new];
    animator.presenting = NO;

    return animator;
}

#pragma mark - Dynamic colors
- (UIColor *)scrimViewBackgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGray darkVariant:BPKColor.backgroundDarkColor];
}
@end

NS_ASSUME_NONNULL_END
