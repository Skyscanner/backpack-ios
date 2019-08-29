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
#import "BPKNavigationBar.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Label.h>

#import "BPKNavigationBarLargeTitleView.h"
#import "BPKNavigationBarTitleView.h"

const CGFloat BPKNavigationBarExpandedFullHeight = 96;

NS_ASSUME_NONNULL_BEGIN

@interface BPKNavigationBar ()
// Title views
@property(nonatomic, strong, readonly) BPKNavigationBarLargeTitleView *largeTitleView;
@property(nonatomic, strong, readonly) BPKNavigationBarTitleView *titleView;

// Background
@property(nonatomic, strong, readonly) UIVisualEffectView *backgroundView;
@property(nonatomic, strong, readonly) UIView *borderView;

// Constraints
@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *backgroundViewTopConstraint;

/**
 * Keeps track of the state of the navigation bar. Will be `YES`
 * when the large title is hidden and the title is displayed in
 * `titleView`. Otherwise it's `NO`.
 * The default values is `NO`.
 */
@property(nonatomic, assign, getter=isCollapsed) BOOL collapsed;
@property(nonatomic) CGFloat safeAreaTopHeight;
@end

@implementation BPKNavigationBar
@synthesize largeTitleView = _largeTitleView, titleView = _titleView, backgroundView = _backgroundView,
            borderView = _borderView;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setUp];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setUp];
    }

    return self;
}

- (void)setTitle:(NSString *)title {
    BPKAssertMainThread();
    if (title != _title) {
        _title = [title copy];

        self.largeTitleView.titleLabel.text = _title;
        self.titleView.titleLabel.text = _title;
    }
}

- (void)setLargeTitleTextColor:(UIColor *_Nullable)largeTitleTextColor {
    BPKAssertMainThread();
    if (largeTitleTextColor != _largeTitleTextColor) {
        _largeTitleTextColor = largeTitleTextColor;

        if (_largeTitleTextColor) {
            self.largeTitleView.titleLabel.textColor = _largeTitleTextColor;
        } else {
            self.largeTitleView.titleLabel.textColor = BPKColor.gray900;
        }
    }
}

- (UIEdgeInsets)largeTitleLayoutMargins {
    return self.largeTitleView.layoutMargins;
}

- (void)setLargeTitleLayoutMargins:(UIEdgeInsets)largeTitleLayoutMargins {
    self.largeTitleView.layoutMargins = largeTitleLayoutMargins;
}

- (void)setUpForScrollview:(UIScrollView *)scrollView {
    scrollView.contentInset = UIEdgeInsetsMake(BPKNavigationBarExpandedFullHeight, 0, 0, 0);
    scrollView.scrollIndicatorInsets = scrollView.contentInset;
}

- (void)updateWithScrollView:(UIScrollView *)scrollView {
    CGFloat adjustedYOffset = self.safeAreaTopHeight + scrollView.contentOffset.y;

    if (adjustedYOffset >= -BPKNavigationBarTitleHeight) {
        // Collapsed state

        // Making modifications on each scroll is very expensive.
        // To prevent extra work the changes between collapsed and expanded
        // are only executed a single time per transition.
        if (!self.isCollapsed) {
            self.heightConstraint.constant = BPKNavigationBarTitleHeight;
            scrollView.scrollIndicatorInsets = scrollView.contentInset;
            self.titleView.showsContent = YES;
            self.borderView.alpha = 1.0;
            self.backgroundView.backgroundColor = UIColor.clearColor;
            self.collapsed = YES;
        }
    } else {
        // Expanded state
        self.heightConstraint.constant = fabs(adjustedYOffset);
        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(fabs(adjustedYOffset), 0, 0, 0);

        // Making modifications on each scroll is very expensive.
        // To prevent extra work the changes between collapsed and expanded
        // are only executed a single time per transition.
        if (self.isCollapsed) {
            self.titleView.showsContent = NO;
            self.borderView.alpha = 0.0;
            self.backgroundView.backgroundColor = UIColor.whiteColor;

            self.collapsed = NO;
        }
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];

    if (self.window) {
        if (@available(iOS 11.0, *)) {
            // On iOS 11 on iPhones with a 20pt tall status bar the value of
            // safeAreaInsets.top is `0` rather than 20.
            self.backgroundViewTopConstraint.constant = -MAX(self.safeAreaTopHeight, 20);
        } else {
            // Handle in layoutSubviews
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (@available(iOS 11.0, *)) {
    } else {
        self.backgroundViewTopConstraint.constant = self.safeAreaTopHeight;
    }
}

#pragma mark - Private

- (BPKNavigationBarLargeTitleView *)largeTitleView {
    if (!_largeTitleView) {
        _largeTitleView = [[BPKNavigationBarLargeTitleView alloc] initWithFrame:CGRectZero];
        _largeTitleView.translatesAutoresizingMaskIntoConstraints = NO;
        _largeTitleView.clipsToBounds = YES;
    }

    return _largeTitleView;
}

- (BPKNavigationBarTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[BPKNavigationBarTitleView alloc] initWithFrame:CGRectZero];
        _titleView.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _titleView;
}

- (UIVisualEffectView *)backgroundView {
    if (!_backgroundView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _backgroundView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView.backgroundColor = UIColor.whiteColor;
    }

    return _backgroundView;
}

- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [[UIView alloc] initWithFrame:CGRectZero];
        _borderView.translatesAutoresizingMaskIntoConstraints = NO;
        _borderView.backgroundColor = BPKColor.gray100;
        _borderView.alpha = 0.0;
    }

    return _borderView;
}

- (void)setUp {
    _collapsed = NO;
    _largeTitleTextColor = nil;
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.backgroundView];
    [self addSubview:self.borderView];
    [self addSubview:self.largeTitleView];
    [self addSubview:self.titleView];

    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        self.safeAreaTopHeight = window.safeAreaInsets.top;
    } else {
        self.safeAreaTopHeight = -[self findNearestViewController].topLayoutGuide.length;
    }
    printf("safeAreaTopHeight %f\n", self.safeAreaTopHeight);

    self.heightConstraint = [self.heightAnchor constraintEqualToConstant:BPKNavigationBarExpandedFullHeight];

    NSLayoutConstraint *largeTitleViewHeightConstraint =
        [self.largeTitleView.heightAnchor constraintGreaterThanOrEqualToConstant:BPKNavigationBarLargeTitleViewHeight];
    largeTitleViewHeightConstraint.priority = UILayoutPriorityDefaultHigh;

    self.backgroundViewTopConstraint = [self.backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor
                                                                                     constant:0.0];

    [NSLayoutConstraint activateConstraints:@[
        // Background view
        self.backgroundViewTopConstraint,
        [self.backgroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.backgroundView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.backgroundView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],

        // Title View
        [self.titleView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.titleView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.titleView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.titleView.bottomAnchor constraintLessThanOrEqualToAnchor:self.bottomAnchor],
        [self.titleView.heightAnchor constraintEqualToConstant:BPKNavigationBarTitleHeight],

        // Border
        [self.borderView.topAnchor constraintEqualToAnchor:self.titleView.bottomAnchor],
        [self.borderView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.borderView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.borderView.heightAnchor constraintEqualToConstant:(1 / self.contentScaleFactor)],

        // Large Title View
        [self.largeTitleView.topAnchor constraintGreaterThanOrEqualToAnchor:self.titleView.bottomAnchor],
        [self.largeTitleView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.largeTitleView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.largeTitleView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        largeTitleViewHeightConstraint,

        self.heightConstraint,
    ]];
}

- (UIViewController *_Nullable)findNearestViewController {
    UIResponder *responder = self;

    while (responder && ![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
    }

    return (UIViewController *)responder;
}

@end

NS_ASSUME_NONNULL_END
