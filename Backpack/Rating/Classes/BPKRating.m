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

NS_ASSUME_NONNULL_BEGIN
@interface BPKRating ()
@property(nonatomic) BPKLabel *titleLabel;
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

- (instancetype)initWithRatingValue:(CGFloat)ratingValue title:(NSString *)title {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.ratingValue = ratingValue;
        self.title = title;

        [self setUp];
    }

    [self setTitle:title];

    return self;
}

- (void)setUp {
    self.titleLabel.accessibilityElementsHidden = NO;

    self.ratingBubble = [BPKRatingBubble new];
    self.ratingBubble.accessibilityElementsHidden = YES;
    [self.ratingBubble setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                                       forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.ratingBubble];

    self.titleLabel = [[BPKLabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.accessibilityElementsHidden = YES;
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                                     forAxis:UILayoutConstraintAxisHorizontal];
    self.titleLabel.fontStyle = BPKFontStyleTextBaseEmphasized;
    [self addSubview:self.titleLabel];

    [self setUpConstraints];
    [self updateStyle];
}

#pragma mark - State setters

- (void)setLowRatingColor:(UIColor *)lowRatingColor {
    if (_lowRatingColor != lowRatingColor) {
        _lowRatingColor = lowRatingColor;

        self.ratingBubble.lowRatingColor = lowRatingColor;
    }
}

- (void)setMediumRatingColor:(UIColor *)mediumRatingColor {
    if (_mediumRatingColor != mediumRatingColor) {
        _mediumRatingColor = mediumRatingColor;

        self.ratingBubble.mediumRatingColor = mediumRatingColor;
    }
}

- (void)setHighRatingColor:(UIColor *)highRatingColor {
    if (_highRatingColor != highRatingColor) {
        _highRatingColor = highRatingColor;

        self.ratingBubble.highRatingColor = highRatingColor;
    }
}

- (void)setTitle:(NSString *_Nullable)title {
    BPKAssertMainThread();
    _title = [title copy];

    [self updateLabels];
}

- (void)setRatingValue:(CGFloat)ratingValue {
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

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.ratingBubble.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.ratingBubble.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.ratingBubble.topAnchor constraintEqualToAnchor:self.topAnchor],

        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.ratingBubble.trailingAnchor constant:BPKSpacingMd],
        [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.ratingBubble.centerYAnchor],
        [self.trailingAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.trailingAnchor],

        [self.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.ratingBubble.bottomAnchor]
    ]];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
    [super systemLayoutSizeFittingSize:targetSize];
    CGSize ratingBubbleSize = [self.ratingBubble systemLayoutSizeFittingSize:targetSize];
    CGSize titleLabelSize = [self.titleLabel systemLayoutSizeFittingSize:targetSize];

    CGFloat height = MIN(MAX(ratingBubbleSize.height, titleLabelSize.height), targetSize.height);
    CGFloat width = MIN(ratingBubbleSize.width + BPKSpacingMd + titleLabelSize.width, targetSize.width);

    return CGSizeMake(width, height);
}

#pragma mark - Updates

- (void)updateStyle {
    self.ratingBubble.ratingValue = self.ratingValue;

    [self updateLabels];
}

- (void)updateLabels {
    self.titleLabel.text = self.title;
}

#pragma mark - Helpers

@end

NS_ASSUME_NONNULL_END
