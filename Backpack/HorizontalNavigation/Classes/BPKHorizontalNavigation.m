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

#import "BPKHorizontalNavigation.h"

#import <Backpack/BorderSize.h>
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Spacing.h>

#import "BPKHorizontalNavigationItem.h"
#import "BPKHorizontalNavigationOption.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKHorizontalNavigation ()
@property(nonatomic, strong) UIStackView *stackView;
@property(nonatomic, strong) UIView *barView;
@property(nonatomic) CGFloat barHeight;
@property(nonatomic) CGFloat barSpacing;
@property(nonatomic, strong) NSLayoutConstraint *barTopConstraint;
@property(nonatomic, strong) NSLayoutConstraint *barHeightConstraint;
@property(nonatomic, strong, nullable) NSArray<NSLayoutConstraint *> *barConstraints;
@end

@implementation BPKHorizontalNavigation

- (instancetype)initWithOptions:(NSArray<BPKHorizontalNavigationOption *> *)options
                       selected:(NSInteger)selectedItemIndex {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithOptions:options selected:selectedItemIndex];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithOptions:@[] selected:0];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithOptions:@[] selected:0];
    }

    return self;
}

- (void)setShowsSelectedBar:(BOOL)showsSelectedBar {
    if (_showsSelectedBar != showsSelectedBar) {
        _showsSelectedBar = showsSelectedBar;

        [self updateBarAppearance];
    }
}

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex {
    if (self.options.count > 0) {
#if DEBUG
        NSString *errorMessage =
            [NSString stringWithFormat:@"selectedItemIndex must be within range of the number of options available. "
                                       @"The number of options is %lu but the index selected was %ld",
                                       (unsigned long)self.options.count, (long)selectedItemIndex];
        NSAssert(selectedItemIndex >= 0 && selectedItemIndex < self.options.count, errorMessage);
#endif
    }

    if (_selectedItemIndex != selectedItemIndex) {
        _selectedItemIndex = selectedItemIndex;

        [self setItemSelectionStates];
    }
}

- (void)updateBarAppearance {
    if (!self.showsSelectedBar || self.selectedItemIndex >= self.stackView.arrangedSubviews.count) {
        self.barView.hidden = YES;
        self.barTopConstraint.constant = 0;
        self.barHeightConstraint.constant = 0;
    } else {
        self.barView.hidden = NO;
        self.barTopConstraint.constant = self.barSpacing;
        self.barHeightConstraint.constant = self.barHeight;

        UIView *selectedButton = self.stackView.arrangedSubviews[self.selectedItemIndex];

        CGFloat animationDuration = 0.2;
        if (UIAccessibilityIsReduceMotionEnabled()) {
            animationDuration = 0.0;
        }

        [self layoutIfNeeded];
        [UIView animateWithDuration:animationDuration
                         animations:^{
                           [self adjustBarConstraintsForView:selectedButton];

                           [self layoutIfNeeded];
                         }];
    }
}

- (void)adjustBarConstraintsForView:(UIView *)view {
    if (self.barConstraints != nil) {
        [NSLayoutConstraint deactivateConstraints:self.barConstraints];
    }
    self.barConstraints = @[
        [self.barView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor constant:self.barSpacing],
        [self.barView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor constant:-self.barSpacing]
    ];
    [NSLayoutConstraint activateConstraints:self.barConstraints];
}

- (void)updateSelection:(UIButton *)sender {
    NSInteger newIndex = [self.stackView.arrangedSubviews indexOfObject:sender];
    [self setSelectedItemIndex:newIndex];

    if ([self.delegate respondsToSelector:@selector(horizontalNavigation:didSelectItem:withTag:)]) {
        [self.delegate horizontalNavigation:self didSelectItem:newIndex withTag:sender.tag];
    } else if ([self.delegate respondsToSelector:@selector(horizontalNavigation:didSelectItem:)]) {
        [self.delegate horizontalNavigation:self didSelectItem:newIndex];
    }
}

- (BPKHorizontalNavigationItem *)createHorizontalNavigationItemWithDefinition:
    (BPKHorizontalNavigationOption *)definition {
    BPKHorizontalNavigationItem *newItem = [[BPKHorizontalNavigationItem alloc] initWithName:definition.name
                                                                                    iconName:definition.iconName];
    newItem.tag = definition.tag;
    return newItem;
}

- (void)forEachNavigationItem:(void (^)(BPKHorizontalNavigationItem *))callback {
    for (UIView *subView in self.stackView.arrangedSubviews) {
        NSAssert([subView isKindOfClass:[BPKHorizontalNavigationItem class]],
                 @"HorizontalNav subview is not of type BPKHorizontalNavigationItem as expected.");
        if (![subView isKindOfClass:[BPKHorizontalNavigationItem class]]) {
            continue;
        }
        callback((BPKHorizontalNavigationItem *)subView);
    }
}

- (void)updateSelectedItemsColor {
    [self forEachNavigationItem:^(BPKHorizontalNavigationItem *navigationItem) {
      navigationItem.selectedColor = self.selectedColor;
    }];
}

- (void)updateItemsSize {
    [self forEachNavigationItem:^(BPKHorizontalNavigationItem *navigationItem) {
      navigationItem.size = self.size;
    }];
}

- (void)setSelectedColor:(UIColor *_Nullable)selectedColor {
    if (_selectedColor != selectedColor) {
        _selectedColor = selectedColor;

        [self updateBarColor];
        [self updateSelectedItemsColor];
    }
}

- (void)setSize:(BPKHorizontalNavigationSize)size {
    if (_size != size) {
        _size = size;

        [self updateItemsSize];
    }
}

#pragma mark - Private

- (CGFloat)barHeight {
    return BPKBorderSizeXl;
}

- (CGFloat)barSpacing {
    return 3 * BPKSpacingSm;
}

- (UIColor *_Nonnull)updateBarColor {
    if (self.selectedColor != nil) {
        return self.barView.backgroundColor = self.selectedColor;
    } else {
        return self.barView.backgroundColor = BPKColor.primaryColor;
    }
}

- (void)setupWithOptions:(NSArray<BPKHorizontalNavigationOption *> *)options selected:(NSInteger)selectedItemIndex {
    self.stackView = [UIStackView new];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.stackView];

    self.barView = [UIView new];
    [self updateBarColor];
    self.barView.translatesAutoresizingMaskIntoConstraints = NO;
    self.barView.hidden = YES;
    [self addSubview:self.barView];

    self.barTopConstraint = [self.barView.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor
                                                                   constant:self.barSpacing];
    self.barHeightConstraint = [self.barView.heightAnchor constraintEqualToConstant:self.barHeight];

    [NSLayoutConstraint activateConstraints:@[self.barTopConstraint, self.barHeightConstraint]];

    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.trailingAnchor constraintEqualToAnchor:self.stackView.trailingAnchor],
        [self.bottomAnchor constraintEqualToAnchor:self.barView.bottomAnchor]
    ]];

    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.distribution = UIStackViewDistributionFillProportionally;

    self.options = options;
    self.selectedItemIndex = selectedItemIndex;
    [self setItemSelectionStates];
}

- (void)repopulateStackview {
    // Remove all current arranged views:
    for (UIView *subView in self.stackView.arrangedSubviews) {
        [self.stackView removeArrangedSubview:subView];
        [subView removeFromSuperview];
    }

    for (BPKHorizontalNavigationOption *option in self.options) {
        BPKHorizontalNavigationItem *newCell = [self createHorizontalNavigationItemWithDefinition:option];
        [newCell addTarget:self action:@selector(updateSelection:) forControlEvents:UIControlEventTouchUpInside];
        [self.stackView addArrangedSubview:newCell];
    }

    // Reset user selection:
    self.selectedItemIndex = 0;
    [self setItemSelectionStates];

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setOptions:(NSArray<BPKHorizontalNavigationOption *> *)options {
    if (![_options isEqualToArray:options]) {
        _options = [options copy];

        [self repopulateStackview];
    }
}
- (void)setItemSelectionStates {
    __block int index = 0;
    [self forEachNavigationItem:^(BPKHorizontalNavigationItem *navigationItem) {
      navigationItem.selected = self.selectedItemIndex == index;
      index += 1;
    }];

    [self updateBarAppearance];
}

@end
NS_ASSUME_NONNULL_END
