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

#import "BPKRatingBubble.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKRatingBubble ()
@property(nonatomic) BPKLabel *ratingBubbleLabel;
@end

@implementation BPKRatingBubble

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

- (void)setUp {
    self.lowRatingColor = BPKColor.red500;
    self.mediumRatingColor = BPKColor.yellow500;
    self.highRatingColor = BPKColor.green500;

    self.backgroundColor = BPKColor.gray200;

    self.ratingBubbleLabel = [[BPKLabel alloc] initWithFrame:CGRectZero];
    self.ratingBubbleLabel.fontStyle = BPKFontStyleTextLgEmphasized;
    self.ratingBubbleLabel.textColor = BPKColor.white;
    self.ratingBubbleLabel.lineBreakMode = NSLineBreakByClipping;
    [self addSubview:self.ratingBubbleLabel];

    [self setUpConstraints];
    [self updateStyle];
}

#pragma mark - State setters

- (void)setLowRatingColor:(UIColor *)lowRatingColor {
    if (_lowRatingColor != lowRatingColor) {
        _lowRatingColor = lowRatingColor;

        [self updateStyle];
    }
}

- (void)setMediumRatingColor:(UIColor *)mediumRatingColor {
    if (_mediumRatingColor != mediumRatingColor) {
        _mediumRatingColor = mediumRatingColor;

        [self updateStyle];
    }
}

- (void)setHighRatingColor:(UIColor *)highRatingColor {
    if (_highRatingColor != highRatingColor) {
        _highRatingColor = highRatingColor;

        [self updateStyle];
    }
}

- (void)setRatingValue:(CGFloat)ratingValue {
    BPKAssertMainThread();
    if (_ratingValue != ratingValue) {
        _ratingValue = ratingValue;

        double cappedRatingBubbleValue = MIN(10.0, MAX(0, self.ratingValue));
        if (fabs(10.0 - cappedRatingBubbleValue) < 0.01 || fabs(0.0 - cappedRatingBubbleValue) < 0.01) {
            self.ratingBubbleLabel.text = [NSString stringWithFormat:@"%.f", cappedRatingBubbleValue];
        } else {
            self.ratingBubbleLabel.text = [NSString stringWithFormat:@"%.1f", cappedRatingBubbleValue];
        }

        [self updateStyle];
    }
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat radius = CGRectGetHeight(self.bounds) / 2.0f;
    [self.layer setCornerRadius:radius];
}

- (void)setUpConstraints {
    CGFloat ratingBubbleVerticalSpacing = [self ratingBubbleVerticalSpacing];

    self.ratingBubbleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.heightAnchor constraintEqualToAnchor:self.ratingBubbleLabel.heightAnchor
                                          constant:2 * ratingBubbleVerticalSpacing],
        [self.widthAnchor constraintEqualToAnchor:self.heightAnchor],

        [self.ratingBubbleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.ratingBubbleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
    [super systemLayoutSizeFittingSize:targetSize];
    CGSize ratingLabelSize = [self.ratingBubbleLabel systemLayoutSizeFittingSize:targetSize];

    CGFloat height = ratingLabelSize.height + 2 * [self ratingBubbleVerticalSpacing];

    return CGSizeMake(height, height);
}

#pragma mark - Updates

- (void)updateStyle {
    if (self.ratingValue < 6.00) {
        self.backgroundColor = self.lowRatingColor;
    } else if (self.ratingValue < 8.00) {
        self.backgroundColor = self.mediumRatingColor;
    } else {
        self.backgroundColor = self.highRatingColor;
    }
}

#pragma mark - Helpers

- (CGFloat)ratingBubbleVerticalSpacing {
    return BPKSpacingBase;
}

@end

NS_ASSUME_NONNULL_END
