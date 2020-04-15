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
@property(strong, nonatomic) BPKLabel *textLabel;
@property(strong, nonatomic) BPKButton *actionButton;
@property(strong, nonatomic) UIImageView *leftIconContainer;
@property(strong, nonatomic) UIView *snackbarView;
@property(strong, nonatomic) UIStackView *stackView;
@property(weak, nonatomic) id<BPKSnackbarDelegate> delegate;
@property(nonatomic) BPKSnackbarDuration duration;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic) long durationInMillis;
@property(nonatomic) CGFloat keyboardHeight;
@property(nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *snackbarViewTopConstraint;
@property(nonatomic, weak) UIViewController *containerViewController;

@end

static int const BPKSnackbarHeight = 60;

@implementation BPKSnackbar

- (instancetype)initWithTitle:(NSString *)title
                         text:(NSString *_Nullable)text
                     duration:(BPKSnackbarDuration)duration
               viewController:(UIViewController *)viewController
                     delegate:(id<BPKSnackbarDelegate> _Nullable)delegate {

    return [self initWithTitle:title
                          text:text
                   buttonTitle:nil
                    buttonIcon:nil
                      leftIcon:nil
                      duration:duration
                viewController:viewController
                      delegate:delegate];
}

- (instancetype)initWithTitle:(NSString *)title
                         text:(NSString *_Nullable)text
                  buttonTitle:(NSString *_Nullable)buttonTitle
                   buttonIcon:(UIImage *_Nullable)buttonIcon
                     leftIcon:(UIImage *_Nullable)leftIcon
                     duration:(BPKSnackbarDuration)duration
               viewController:(UIViewController *)viewController
                     delegate:(id<BPKSnackbarDelegate> _Nullable)delegate {

    self = [self init];
    [self setUpSnackbarWithTitle:title
                            text:text
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
        self.snackbarView = [UIView new];
        self.stackView = [UIStackView new];
        self.leftIconContainer = [[UIImageView alloc] init];
        self.titleLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextSmEmphasized];
        self.textLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextSm];
        self.actionButton = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStyleLink];

        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.snackbarView.translatesAutoresizingMaskIntoConstraints = NO;
        self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
        self.stackView.alignment = UIStackViewAlignmentCenter;
        self.stackView.axis = UILayoutConstraintAxisHorizontal;
        self.stackView.layoutMargins = UIEdgeInsetsMake(0, BPKSpacingLg, 0, BPKSpacingLg);

        // Don't grow the icon
        [self.leftIconContainer setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                                  forAxis:UILayoutConstraintAxisHorizontal];
        // Don't grow title
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                           forAxis:UILayoutConstraintAxisHorizontal];

        // Trunacte title if needed
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                                         forAxis:UILayoutConstraintAxisHorizontal];

        // Truncate text before title if needed
        [self.textLabel setContentCompressionResistancePriority:(UILayoutPriorityDefaultLow - 1)
                                                        forAxis:UILayoutConstraintAxisHorizontal];

        // Make the text label wider to distribute remaining space
        [self.textLabel setContentHuggingPriority:UILayoutPriorityDefaultLow
                                          forAxis:UILayoutConstraintAxisHorizontal];

        // Don't compress the button
        [self.actionButton setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                                           forAxis:UILayoutConstraintAxisHorizontal];
        // Don't grow the button
        [self.actionButton setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                             forAxis:UILayoutConstraintAxisHorizontal];

        self.titleLabel.textColor = BPKColor.white;
        self.textLabel.textColor = BPKColor.white;
        self.leftIconContainer.tintColor = BPKColor.white;
        self.actionButton.linkContentColor = BPKColor.monteverde;
        [self.actionButton addTarget:self
                              action:@selector(actionButtonDismissSnackbar)
                    forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:self.snackbarView];
        [self.snackbarView addSubview:self.stackView];
        [self.stackView addArrangedSubview:self.leftIconContainer];
        [self.stackView addArrangedSubview:self.titleLabel];
        [self.stackView addArrangedSubview:self.textLabel];
        [self.stackView addArrangedSubview:self.actionButton];
        [self.stackView addSubview:self.actionButton];

        [self.stackView setCustomSpacing:BPKSpacingMd afterView:self.leftIconContainer];
        [self.stackView setCustomSpacing:BPKSpacingSm afterView:self.titleLabel];
        [self.stackView setCustomSpacing:BPKSpacingLg afterView:self.textLabel];

        self.snackbarView.layoutMargins = UIEdgeInsetsMake(0, BPKSpacingLg, 0, BPKSpacingLg);

        [NSLayoutConstraint activateConstraints:@[
            [self.snackbarView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
            [self.snackbarView.heightAnchor constraintEqualToAnchor:self.heightAnchor],

            [self.stackView.leadingAnchor constraintEqualToAnchor:self.snackbarView.layoutMarginsGuide.leadingAnchor],
            [self.stackView.trailingAnchor constraintEqualToAnchor:self.snackbarView.layoutMarginsGuide.trailingAnchor],
            [self.stackView.heightAnchor constraintEqualToAnchor:self.snackbarView.heightAnchor],
        ]];

        self.snackbarViewTopConstraint = [self.snackbarView.topAnchor constraintEqualToAnchor:self.topAnchor];
        self.snackbarViewTopConstraint.active = YES;

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
                          text:(NSString *_Nullable)text
                   buttonTitle:(NSString *_Nullable)buttonTitle
                    buttonIcon:(UIImage *_Nullable)buttonIcon
                      leftIcon:(UIImage *_Nullable)leftIcon
                      duration:(BPKSnackbarDuration)duration
                viewController:(UIViewController *)viewController
                      delegate:(id<BPKSnackbarDelegate> _Nullable)delegate {
    self.titleLabel.text = title;
    self.textLabel.text = text;
    self.delegate = delegate;
    self.snackbarView.backgroundColor = BPKColor.skyBlueShade02;
    self.containerViewController = viewController;
    self.actionButton.title = buttonTitle;
    self.actionButton.image = buttonIcon;
    self.leftIconContainer.image = leftIcon;

    self.actionButton.hidden = buttonTitle == nil && buttonIcon == nil;
    self.leftIconContainer.hidden = leftIcon == nil;

    if (text) {
        // If we have some text let the text label grow as large as possible to create space between it
        // and the button/edge of the stackview
        [self.textLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    } else {
        // If we don't have text we can't let it grow because its intrinsic content size will be 0
        // instead we let `titleLabel` grow
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
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
            [self.leadingAnchor constraintEqualToAnchor:self.superview.leadingAnchor],
            [self.trailingAnchor constraintEqualToAnchor:self.superview.trailingAnchor]
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
                     completion:^(BOOL finished){
                        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self);
                     }];
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
          UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self);
          [self removeFromSuperview];
          [self.delegate snackbar:self dismissedWithCause:cause];
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
        NSArray *subviews = [parent.view subviews];

        for (UIView *subview in subviews) {
            if ([subview isKindOfClass:[UITabBar class]]) {
                return (UITabBar *)subview;
            }
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

#pragma mark - UIAccessibility

- (NSArray<id> *)accessibilityElements {
    return @[self.titleLabel, self.textLabel, self.actionButton];
}


@end
