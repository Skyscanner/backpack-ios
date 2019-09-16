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

#import "BPKRating.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

#import "BPKRatingBubble.h"
#import "BPKRatingTextWrapper.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKRating ()
@property(nonatomic) BPKRatingTextWrapper *textWrapper;
@property(nonatomic) BPKRatingBubble *ratingBubble;
@end

@implementation BPKRating

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setUp];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setUp];
    }

    return self;
}

- (instancetype)initWithRatingValue:(CGFloat)ratingValue title:(NSString *)title subtitle:(NSString *_Nullable)subtitle {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.ratingValue = ratingValue;
        self.title = title;
        self.subtitle = subtitle;

        [self setUp];
    }

    [self setTitle:title];

    return self;
}

- (void)setUp {
    self.ratingBubble = [BPKRatingBubble new];
    self.ratingBubble.accessibilityElementsHidden = YES;
    [self.ratingBubble setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                                       forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.ratingBubble];

    self.textWrapper = [[BPKRatingTextWrapper alloc] initWithFrame:CGRectZero];
    self.textWrapper.accessibilityElementsHidden = YES;
    [self addSubview:self.textWrapper];

    [self setUpConstraints];
    [self updateStyle];
}

#pragma mark - State setters

- (void)setLowRatingColor:(UIColor *)lowRatingColor {
    BPKAssertMainThread();
    if (_lowRatingColor != lowRatingColor) {
        _lowRatingColor = lowRatingColor;

        self.ratingBubble.lowRatingColor = lowRatingColor;
    }
}

- (void)setMediumRatingColor:(UIColor *)mediumRatingColor {
    BPKAssertMainThread();
    if (_mediumRatingColor != mediumRatingColor) {
        _mediumRatingColor = mediumRatingColor;

        self.ratingBubble.mediumRatingColor = mediumRatingColor;
    }
}

- (void)setHighRatingColor:(UIColor *)highRatingColor {
    BPKAssertMainThread();
    if (_highRatingColor != highRatingColor) {
        _highRatingColor = highRatingColor;

        self.ratingBubble.highRatingColor = highRatingColor;
    }
}

- (void)setTitle:(NSString *)title {
    BPKAssertMainThread();
    _title = [title copy];

    self.textWrapper.title = self.title;
}

- (void)setSubtitle:(NSString *_Nullable)subtitle {
    BPKAssertMainThread();
    _subtitle = [subtitle copy];

    self.textWrapper.subtitle = self.subtitle;
}

- (void)setRatingValue:(CGFloat)ratingValue {
    BPKAssertMainThread();
    if (_ratingValue != ratingValue) {
        _ratingValue = ratingValue;

        self.ratingBubble.ratingValue = ratingValue;
    }
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat radius = CGRectGetHeight(self.ratingBubble.bounds) / 2.0f;
    [self.ratingBubble.layer setCornerRadius:radius];
}

- (void)setUpConstraints {

    self.textWrapper.translatesAutoresizingMaskIntoConstraints = NO;
    self.ratingBubble.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.ratingBubble.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.ratingBubble.topAnchor constraintEqualToAnchor:self.topAnchor],

        [self.textWrapper.leadingAnchor constraintEqualToAnchor:self.ratingBubble.trailingAnchor constant:BPKSpacingMd],
        [self.textWrapper.centerYAnchor constraintEqualToAnchor:self.ratingBubble.centerYAnchor],
        [self.trailingAnchor constraintGreaterThanOrEqualToAnchor:self.textWrapper.trailingAnchor],

        [self.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.textWrapper.bottomAnchor],
        [self.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.ratingBubble.bottomAnchor]
    ]];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
    [super systemLayoutSizeFittingSize:targetSize];
    CGSize ratingBubbleSize = [self.ratingBubble systemLayoutSizeFittingSize:targetSize];
    CGSize textWrapperSize = [self.textWrapper systemLayoutSizeFittingSize:targetSize];

    CGFloat height = MIN(MAX(ratingBubbleSize.height, textWrapperSize.height), targetSize.height);
    CGFloat width = MIN(ratingBubbleSize.width + BPKSpacingMd + textWrapperSize.width, targetSize.width);

    return CGSizeMake(width, height);
}

#pragma mark - Updates

- (void)updateStyle {
    self.ratingBubble.ratingValue = self.ratingValue;
}

@end

NS_ASSUME_NONNULL_END
