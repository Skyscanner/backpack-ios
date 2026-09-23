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
@property(nullable, nonatomic, strong) UIView *graphicView;

@property(nonatomic, strong) NSMutableArray<BPKDialogScrimAction *> *scrimActions;

@property(nonatomic, strong) NSLayoutConstraint *bottomAnchorConstraint;
// Holds the dialog so it can scroll when it is taller than the window.
@property(nonatomic, strong) UIScrollView *dialogScrollView;
@property(nonatomic, strong) UIColor *scrimViewBackgroundColor;
@property(nonatomic) NSTextAlignment textAlignment;

- (instancetype)initWithTitle:(NSString *_Nullable)title
                      message:(NSString *)message
               iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition;
@end

@implementation BPKDialogController

- (instancetype)initWithTitle:(NSString *_Nullable)title
                      message:(NSString *)message
               iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition {
    return [self initWithTitle:title message:message iconDefinition:iconDefinition graphicView:nil textAlignment:NSTextAlignmentCenter];
}

- (instancetype)initWithTitle:(NSString *_Nullable)title
                      message:(NSString *)message
               iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition
                  graphicView:(UIView *_Nullable)graphicView
                textAlignment:(NSTextAlignment)textAlignment {
    self = [super init];

    if (self) {
        self.buttonSize = BPKButtonSizeLarge;
        self.titleText = title;
        self.messageText = message;
        self.iconDefinition = iconDefinition;
        self.graphicView = graphicView;
        self.scrimActions = [NSMutableArray new];
        self.transitioningDelegate = self;
        self.textAlignment = textAlignment;

        [self setupViews];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addViews];
    [self setupConstraints];
}

+ (instancetype)dialogControllerWithTitle:(NSString *_Nullable)title
                                  message:(NSString *)message
                           iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition {
    return [[self alloc] initWithTitle:title message:message iconDefinition:iconDefinition];
}

+ (instancetype)dialogControllerWithTitle:(NSString *_Nullable)title
                                  message:(NSString *)message
                           iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition
                                flareView:(BPKObjcUIKitFlareView *_Nullable)flareView {
    return [[self alloc] initWithTitle:title message:message iconDefinition:iconDefinition graphicView:flareView textAlignment:NSTextAlignmentCenter];
}

+ (instancetype)dialogControllerWithTitle:(NSString *_Nullable)title
                                  message:(NSString *)message
                                imageView:(UIImageView *_Nullable)imageView
                            textAlignment:(NSTextAlignment)textAlignment {
    return [[self alloc] initWithTitle:title message:message iconDefinition:nil graphicView:imageView textAlignment:textAlignment];
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
                                               graphicView:self.graphicView
                                             textAlignment:self.textAlignment];
    self.dialogView.translatesAutoresizingMaskIntoConstraints = NO;
    self.dialogView.delegate = self;
    self.dialogView.accessibilityIdentifier = @"dialogView";

    self.dialogScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.dialogScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.dialogScrollView.showsVerticalScrollIndicator = NO;
    self.dialogScrollView.showsHorizontalScrollIndicator = NO;
    self.dialogScrollView.alwaysBounceVertical = NO;
    self.dialogScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    // Clip only while the dialog scrolls, so its shadow shows whenever it fits.
    self.dialogScrollView.clipsToBounds = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat contentHeight = self.dialogScrollView.contentSize.height;
    self.dialogScrollView.clipsToBounds = contentHeight > CGRectGetHeight(self.dialogScrollView.bounds) + 0.5;
}

- (void)setupConstraints {
    UIScrollView *scrollView = self.dialogScrollView;
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;

    NSLayoutConstraint *lowerWidthConstraint = [scrollView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.view.widthAnchor multiplier:0.8];
    lowerWidthConstraint.priority = UILayoutPriorityDefaultHigh;

    // The scroll view is as tall as the dialog. When the window is too short for that, it takes the
    // height it's given instead and the dialog scrolls, so its buttons stay reachable. The priority sits
    // below the message's compression resistance (UILayoutPriorityDefaultLow), so the dialog keeps its
    // full text instead of shrinking and truncating it to fit.
    NSLayoutConstraint *fitDialogHeight = [scrollView.heightAnchor constraintEqualToAnchor:self.dialogView.heightAnchor];
    fitDialogHeight.priority = UILayoutPriorityDefaultLow - 2;

    [NSLayoutConstraint activateConstraints:@[
        [self.scrimView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrimView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrimView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.scrimView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],

        [scrollView.leadingAnchor constraintGreaterThanOrEqualToAnchor:margins.leadingAnchor],
        [margins.trailingAnchor constraintGreaterThanOrEqualToAnchor:scrollView.trailingAnchor],

        [scrollView.widthAnchor constraintLessThanOrEqualToConstant:BPKSpacingXxl * 13],
        lowerWidthConstraint,
        [scrollView.heightAnchor constraintLessThanOrEqualToConstant:BPKSpacingXxl * 18],
        fitDialogHeight,

        // Centred horizontally in the safe area, so a side safe area such as the iPhone Duo's rail
        // doesn't push the dialog off-centre. Vertical centring is unchanged.
        [scrollView.centerXAnchor constraintEqualToAnchor:safeArea.centerXAnchor],
        [scrollView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [scrollView.topAnchor constraintGreaterThanOrEqualToAnchor:margins.topAnchor constant:BPKSpacingLg],
        [margins.bottomAnchor constraintGreaterThanOrEqualToAnchor:scrollView.bottomAnchor constant:BPKSpacingLg],

        [self.dialogView.topAnchor constraintEqualToAnchor:scrollView.contentLayoutGuide.topAnchor],
        [self.dialogView.bottomAnchor constraintEqualToAnchor:scrollView.contentLayoutGuide.bottomAnchor],
        [self.dialogView.leadingAnchor constraintEqualToAnchor:scrollView.contentLayoutGuide.leadingAnchor],
        [self.dialogView.trailingAnchor constraintEqualToAnchor:scrollView.contentLayoutGuide.trailingAnchor],
        [self.dialogView.widthAnchor constraintEqualToAnchor:scrollView.frameLayoutGuide.widthAnchor],
    ]];
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
    [self.view addSubview:self.dialogScrollView];
    [self.dialogScrollView addSubview:self.dialogView];
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
    self.dialogView.alpha = 0.0;
    [UIView addKeyframeWithRelativeStartTime:startTime
                            relativeDuration:duration
                                  animations:^{
                                    self.dialogView.alpha = 1.0;
                                  }];
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
    return BPKColor.scrimColor;
}
@end

NS_ASSUME_NONNULL_END
