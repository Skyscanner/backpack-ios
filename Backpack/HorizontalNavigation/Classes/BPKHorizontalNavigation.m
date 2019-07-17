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
#import "BPKHorizontalNavigationOption.h"
#import "BPKHorizontalNavigationItem.h"
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKHorizontalNavigation ()
@property(nonatomic, strong) UIStackView *stackView;
@end

@implementation BPKHorizontalNavigation

- (instancetype)initWithOptions:(NSArray<NSString *> *)options selected:(NSInteger *)selectedItem {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithOptions:options selected:selectedItem];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithOptions:@[] selected:-1];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithOptions:@[] selected:-1];
    }

    return self;
}

- (void)setSelectedItem:(NSInteger)selectedItem {
    if (_selectedItem != selectedItem) {
        _selectedItem = selectedItem;

        for (int i = 0; i < self.stackView.arrangedSubviews.count; i += 1) {
            NSAssert([self.stackView.arrangedSubviews[i] isKindOfClass:[BPKHorizontalNavigationItem class]],
                     @"HorizontalNav subview is not of type BPKHorizontalNavigationItem as expected.");
            if (![self.stackView.arrangedSubviews[i] isKindOfClass:[BPKHorizontalNavigationItem class]]) {
                continue;
            }

            BPKHorizontalNavigationItem *navigationCell =
                (BPKHorizontalNavigationItem *)self.stackView.arrangedSubviews[i];

            if (navigationCell != nil) {
                navigationCell.active = selectedItem == i;
            }
        }
    }
}

- (void)updateSelection:(UIButton *)sender {
    NSInteger newIndex = [self.stackView.arrangedSubviews indexOfObject:sender];
    [self setSelectedItem:newIndex];

    if ([self.delegate respondsToSelector:@selector(horizontalNavigation:didSelectItem:)]) {
        [self.delegate horizontalNavigation:self didSelectItem:newIndex];
    }
}

- (BPKHorizontalNavigationItem *)createHorizontalNavigationItemWithDefinition:(BPKHorizontalNavigationOption *)definition {
    return [[BPKHorizontalNavigationItem alloc] initWithDefinition:definition];
}

- (void)setSelectedColor:(UIColor *_Nullable)selectedColor {
    if (_selectedColor != selectedColor) {
        _selectedColor = selectedColor;

        for (UIView *subView in self.stackView.arrangedSubviews) {
            NSAssert([subView isKindOfClass:[BPKHorizontalNavigationItem class]],
                     @"HorizontalNav subview is not of type BPKHorizontalNavigationItem as expected.");
            if (![subView isKindOfClass:[BPKHorizontalNavigationItem class]]) {
                continue;
            }

            BPKHorizontalNavigationItem *navigationCell = (BPKHorizontalNavigationItem *)subView;
            navigationCell.selectedColor = selectedColor;
        }
    }
}

#pragma mark - Private

- (void)setupWithOptions:(NSArray<BPKHorizontalNavigationOption *> *)options selected:(NSInteger *)selectedItem {
    _options = options;

    self.stackView = [UIStackView new];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.stackView];

    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:BPKSpacingBase],
        [self.trailingAnchor constraintEqualToAnchor:self.stackView.trailingAnchor constant:BPKSpacingBase],
        [self.bottomAnchor constraintEqualToAnchor:self.stackView.bottomAnchor],
        [self.heightAnchor constraintEqualToConstant:40.0f]
    ]];

    self.stackView.backgroundColor = UIColor.redColor;
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.distribution = UIStackViewDistributionFillProportionally;
    self.stackView.spacing = BPKSpacingXl;

    [self rePopulateStackview];

    self.selectedItem = selectedItem;
}

- (void)rePopulateStackview {
    // Remove all current arranged views:
    for (UIView *subView in self.stackView.arrangedSubviews) {
        [self.stackView removeArrangedSubview:subView];
    }

    for (int i = 0; i < self.options.count; i += 1) {
        BPKHorizontalNavigationItem *newCell = [self createHorizontalNavigationItemWithDefinition:self.options[i]];
        [newCell addTarget:self action:@selector(updateSelection:) forControlEvents:UIControlEventTouchUpInside];
        [self.stackView addArrangedSubview:newCell];
    }

    // Reset user selection:
    self.selectedItem = 0;

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setOptions:(NSArray<BPKHorizontalNavigationOption *> *)options {
    if (_options != options) {
        _options = options;

        [self rePopulateStackview];
    }
}

@end
NS_ASSUME_NONNULL_END
