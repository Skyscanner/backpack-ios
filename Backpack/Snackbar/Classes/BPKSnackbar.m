/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import "BPKSnackbar.h"

#import <Backpack/Button.h>
#import <Backpack/Color.h>
#import <Backpack/Duration.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

NSString *const SnackbarAccessibilityIdentifier = @"snackbarView";

@interface BPKSnackbar ()
@property(strong, nonatomic) BPKLabel *titleLabel;
@property(strong, nonatomic) BPKButton *actionButton;
@property(strong, nonatomic) UIImageView *leftIconContainer;
@property(strong, nonatomic) UIView *snackbarView;
@property(weak, nonatomic) id<BPKSnackbarProtocol> delegate;
@property(nonatomic) BPKSnackbarDuration duration;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic) long durationInMillis;
@property(nonatomic) CGFloat keyboardHeight;
@property(nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *snackbarViewTopConstraint;
@property(nonatomic, strong) NSLayoutConstraint *labelButtonSpacing;
@property(nonatomic, strong) NSLayoutConstraint *labelLeadingSpacing;
@property(nonatomic, strong) UIViewController *containerViewController;

@end

static int const BPKSnackbarHeight = 60;

@implementation BPKSnackbar

- (instancetype)initWithTitle:(NSString *)title
                     duration:(BPKSnackbarDuration)duration
               viewController:(UIViewController *)viewController
                     delegate:(id<BPKSnackbarProtocol> _Nullable)delegate {

    return [self initWithTitle:title
                   buttonTitle:nil
                    buttonIcon:nil
                      leftIcon:nil
                      duration:duration
                viewController:viewController
                      delegate:delegate];
}

- (instancetype)initWithTitle:(NSString *)title
                  buttonTitle:(NSString *_Nullable)buttonTitle
                   buttonIcon:(UIImage *_Nullable)buttonIcon
                     leftIcon:(UIImage *_Nullable)leftIcon
                     duration:(BPKSnackbarDuration)duration
               viewController:(UIViewController *)viewController
                     delegate:(id<BPKSnackbarProtocol> _Nullable)delegate {

    self = [self init];
    [self setUpSnackbarWithTitle:title
                     buttonTitle:buttonTitle
                      buttonIcon:buttonIcon
                        leftIcon:leftIcon
                        duration:duration
                  viewController:viewController
                        delegate:delegate];

    return self;
}

- (id)init {
    self = [super init];

    if (self) {
        self.snackbarView = [[UIView alloc] init];
        self.leftIconContainer = [[UIImageView alloc] init];
        self.titleLabel = [[BPKLabel alloc] initWithFrame:CGRectZero];
        self.actionButton = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStyleLink];

        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.snackbarView.translatesAutoresizingMaskIntoConstraints = NO;
        self.actionButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.leftIconContainer.translatesAutoresizingMaskIntoConstraints = NO;

        self.titleLabel.textColor = BPKColor.white;
        self.leftIconContainer.tintColor = BPKColor.white;
        self.actionButton.linkContentColor = BPKColor.monteverde;
        [self.actionButton addTarget:self
                              action:@selector(actionButtonDismissSnackbar)
                    forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:self.snackbarView];
        [self.snackbarView addSubview:self.actionButton];
        [self.snackbarView addSubview:self.titleLabel];
        [self.snackbarView addSubview:self.leftIconContainer];

        [NSLayoutConstraint activateConstraints:@[
            [self.snackbarView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
            [self.snackbarView.heightAnchor constraintEqualToAnchor:self.heightAnchor],
            [self.leftIconContainer.leadingAnchor constraintEqualToAnchor:self.snackbarView.leadingAnchor
                                                                 constant:BPKSpacingLg],
            [self.leftIconContainer.centerYAnchor constraintEqualToAnchor:self.snackbarView.centerYAnchor],
            [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.snackbarView.centerYAnchor],
            [self.snackbarView.trailingAnchor constraintEqualToAnchor:self.actionButton.trailingAnchor
                                                             constant:BPKSpacingLg],
            [self.actionButton.centerYAnchor constraintEqualToAnchor:self.snackbarView.centerYAnchor]
        ]];

        self.snackbarViewTopConstraint = [self.snackbarView.topAnchor constraintEqualToAnchor:self.topAnchor];
        self.snackbarViewTopConstraint.active = YES;

        self.labelButtonSpacing =
            [self.actionButton.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.trailingAnchor
                                                                         constant:BPKSpacingBase];
        self.labelButtonSpacing.active = YES;

        self.labelLeadingSpacing =
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leftIconContainer.trailingAnchor
                                                          constant:BPKSpacingMd];
        self.labelLeadingSpacing.active = YES;

        self.snackbarView.accessibilityIdentifier = SnackbarAccessibilityIdentifier;

        self.keyboardHeight = 0.0f;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillChange:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
    }

    return self;
}

- (void)setUpSnackbarWithTitle:(NSString *)title
                   buttonTitle:(NSString *_Nullable)buttonTitle
                    buttonIcon:(UIImage *_Nullable)buttonIcon
                      leftIcon:(UIImage *_Nullable)leftIcon
                      duration:(BPKSnackbarDuration)duration
                viewController:(UIViewController *)viewController
                      delegate:(id<BPKSnackbarProtocol> _Nullable)delegate {
    self.titleLabel.text = title;
    self.delegate = delegate;
    self.snackbarView.backgroundColor = BPKColor.skyBlueShade02;
    self.containerViewController = viewController;
    self.actionButton.title = buttonTitle;
    self.actionButton.image = buttonIcon;
    self.leftIconContainer.image = leftIcon;

    if (buttonTitle != nil || buttonIcon != nil) {
        self.actionButton.hidden = NO;
        self.labelButtonSpacing.constant = BPKSpacingLg;
        [self.actionButton setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
    } else {
        self.actionButton.hidden = YES;
        self.labelButtonSpacing.constant = 0;
        [self.actionButton setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                                           forAxis:UILayoutConstraintAxisHorizontal];
    }

    if (leftIcon != nil) {
        self.leftIconContainer.hidden = NO;
        self.labelLeadingSpacing.constant = BPKSpacingMd;
    } else {
        self.leftIconContainer.hidden = YES;
        self.labelLeadingSpacing.constant = 0;
    }

    if (duration != BPKSnackbarDurationIndefinite) {
        self.durationInMillis = [self durationInMilliseconds:duration];
        if (self.durationInMillis > 0) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.durationInMillis / 1000.0
                                                          target:self
                                                        selector:@selector(snackbarTimeOut)
                                                        userInfo:nil
                                                         repeats:NO];
        }
    }

    [self updateLayout];
}

- (void)updateLayout {
    UIView *presentingView = self.containerViewController.view;
    [presentingView addSubview:self];

    if (self.superview) {
        [NSLayoutConstraint activateConstraints:@[
            [self.leftAnchor constraintEqualToAnchor:self.superview.leftAnchor],
            [self.rightAnchor constraintEqualToAnchor:self.superview.rightAnchor]
        ]];

        NSLayoutYAxisAnchor *bottomAnchor = self.superview.safeAreaLayoutGuide.bottomAnchor;

        self.bottomConstraint =
            [self.bottomAnchor constraintEqualToAnchor:bottomAnchor
                                              constant:[self bottomInsetWithKeyboardHeight:self.keyboardHeight]];
        self.bottomConstraint.active = YES;

        self.heightConstraint = [self.heightAnchor constraintEqualToConstant:BPKSnackbarHeight];
        self.heightConstraint.active = YES;

        [self layoutIfNeeded];
    }
}

- (void)show {
    // First check if there's another snackbar presented
    [self findAndRemoveSnackbars];

    CGFloat distance = self.heightConstraint.constant;
    self.snackbarViewTopConstraint.constant = distance;
    [self layoutIfNeeded];

    [UIView animateWithDuration:BPKDuration.animationDurationSm
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                       self.snackbarViewTopConstraint.constant = 0;
                       [self layoutIfNeeded];
                     }
                     completion:nil];
}

- (void)findAndRemoveSnackbars {
    for (UIView *subview in self.containerViewController.view.subviews) {
        if ([subview isKindOfClass:[self class]]) {
            if ((BPKSnackbar *)subview != self) {
                [(BPKSnackbar *)subview dismiss];
            }
        }
    }
}

- (void)removeSnackbarWithAnimation:(BPKSnackbarDismissCause)cause {
    [UIView animateWithDuration:BPKDuration.animationDurationSm
        delay:0
        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseOut
        animations:^{
          [self.timer invalidate];
          CGFloat distance = self.heightConstraint.constant;
          self.snackbarViewTopConstraint.constant = distance;
          [self layoutIfNeeded];
        }
        completion:^(BOOL finished) {
          [self removeFromSuperview];
          [self.delegate snackbarDismissed:self cause:cause];
        }];
}

- (void)updateBottomConstraintWithBottomInset:(CGFloat)inset
                withKeyboardAnimationDuration:(NSTimeInterval)animationDuration {
    [UIView animateWithDuration:animationDuration
                     animations:^{
                       self.bottomConstraint.constant = inset;
                       [self layoutIfNeeded];
                     }];
}

- (void)snackbarTimeOut {
    [self removeSnackbarWithAnimation:BPKSnackbarDismissCauseDuration];
}

- (void)dismiss {
    [self removeSnackbarWithAnimation:BPKSnackbarDismissCauseNone];
}

- (void)actionButtonDismissSnackbar {
    [self removeSnackbarWithAnimation:BPKSnackbarDismissCauseActionButton];
}

- (long)durationInMilliseconds:(BPKSnackbarDuration)duration {
    switch (duration) {
    case BPKSnackbarDurationShort: {
        return 2000;
        break;
    }

    case BPKSnackbarDurationLong: {
        return 3500;
        break;
    }

    case BPKSnackbarDurationIndefinite: {
        return -1;
        break;
    }
    }
}

- (CGFloat)bottomInsetWithKeyboardHeight:(CGFloat)keyboardHeight {
    UITabBar *tabBar = [self findTabBarForViewController:self.containerViewController];
    CGFloat tabBarOffsetHeight = (tabBar && !tabBar.hidden) ? CGRectGetHeight(tabBar.bounds) : 0;
    CGFloat offset = 0;

    // To define the offset height, the only thing I do care is if the view extends or not at bottom behind the tabbar.
    if ([self viewExtendsAtBottomForViewController:self.containerViewController]) {
        /* If it extends,
         * If the keyboard exists, the maximum value is going to be the keyboardHeight.
         * If the keyboard does not exist, the maximum value will be the tabBarOffset.
         */
        offset = MAX(keyboardHeight, tabBarOffsetHeight);
    } else {
        /* If it does not extend,
         * If the keyboard does not exist, the 0 is actually 49 (the tabBar height) so the offset needs to be 0.
         * If it exists, the offset can't be just the keyboard height because it also starts in 49, so I need to
         * substract 49 (the tabBarHeight).
         */
        offset = MAX(0, keyboardHeight - tabBarOffsetHeight);
    }

    return -offset;
}

/*
 * Returns the tabbar if exists.
 */
- (nullable __kindof UITabBar *)findTabBarForViewController:(UIViewController *)viewController {
    UIViewController *current = viewController;

    while (current) {
        UIViewController *parent = current.parentViewController;

        if ([parent isKindOfClass:[UITabBarController class]]) {
            return ((UITabBarController *)parent).tabBar;
        }

        current = parent;
    }
    return nil;
}

/*
 * Checks if the view can extend behind the tabbar, filling the whole screen or not.
 */
- (BOOL)viewExtendsAtBottomForViewController:(UIViewController *)viewController {
    BOOL bottomEdgesCanExtend = ((viewController.edgesForExtendedLayout & UIRectEdgeBottom) == UIRectEdgeBottom);

    return bottomEdgesCanExtend && viewController.extendedLayoutIncludesOpaqueBars;
}

- (void)keyboardWillChange:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGFloat mainScreenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat keyboardEndPosition = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    UIWindow *window = [self window];
    CGFloat bottomPadding = window.safeAreaInsets.bottom;
    keyboardEndPosition += bottomPadding;
    CGFloat newKeyboardHeight = mainScreenHeight - keyboardEndPosition;
    self.keyboardHeight = newKeyboardHeight;

    CGFloat finalHeight = [self bottomInsetWithKeyboardHeight:newKeyboardHeight];
    NSTimeInterval animationDuration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self updateBottomConstraintWithBottomInset:finalHeight withKeyboardAnimationDuration:animationDuration];
}
@end
