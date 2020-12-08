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

#import "BPKRatingBubble.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKRatingBubble ()
@property(nonatomic) BPKLabel *ratingBubbleLabel;
@property(nonatomic) NSLayoutConstraint *heightConstraint;
@property(nonatomic) NSLayoutConstraint *widthConstraint;
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
    self.ratingBubbleLabel = [[BPKLabel alloc] initWithFrame:CGRectZero];
    self.ratingBubbleLabel.fontStyle = BPKFontStyleTextBaseEmphasized;
    self.ratingBubbleLabel.textColor = BPKColor.white;
    self.ratingBubbleLabel.lineBreakMode = NSLineBreakByClipping;
    [self addSubview:self.ratingBubbleLabel];

    [self setUpConstraints];
    [self updateLayout];
}

#pragma mark - State setters
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
    }
}

- (void)setSize:(BPKRatingSize)size {
    BPKAssertMainThread();
    if (_size != size) {
        _size = size;

        [self updateLayout];
    }
}

- (void)setLayout:(BPKRatingLayout)layout {
    BPKAssertMainThread();
    if (_layout != layout) {
        _layout = layout;

        [self updateLayout];
    }
}

#pragma mark - Layout

- (void)updateLayout {
    CGFloat newWidth = 0;
    CGFloat newHeight = 0;

    switch (self.size) {
    case BPKRatingSizeLarge:
        newWidth = 2 * BPKSpacingLg;
        self.ratingBubbleLabel.fontStyle = BPKFontStyleTextLgEmphasized;
        break;
    case BPKRatingSizeBase:
        newWidth = BPKSpacingXxl;
        self.ratingBubbleLabel.fontStyle = BPKFontStyleTextBaseEmphasized;
        break;
    case BPKRatingSizeSmall:
        newWidth = 2 * BPKSpacingBase;
        self.ratingBubbleLabel.fontStyle = BPKFontStyleTextSmEmphasized;
        break;
    case BPKRatingSizeExtraSmall:
        newWidth = BPKSpacingXl;
        self.ratingBubbleLabel.fontStyle = BPKFontStyleTextSmEmphasized;
        break;
    }

    if (self.layout == BPKRatingLayoutHorizontalPill) {
        newHeight = newWidth * 2.0 / 3.0;
    } else {
        newHeight = newWidth;
    }

    self.heightConstraint.constant = newHeight;
    self.widthConstraint.constant = newWidth;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat radius = CGRectGetHeight(self.bounds) / 2.0f;
    [self.layer setCornerRadius:radius];
}

- (void)setUpConstraints {
    self.ratingBubbleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.heightConstraint = [self.heightAnchor constraintEqualToConstant:BPKSpacingXxl];
    self.widthConstraint = [self.widthAnchor constraintEqualToConstant:BPKSpacingXxl];

    [NSLayoutConstraint activateConstraints:@[
        self.heightConstraint, self.widthConstraint,

        [self.ratingBubbleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.ratingBubbleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
    [super systemLayoutSizeFittingSize:targetSize];
    CGFloat height = self.heightConstraint.constant;

    return CGSizeMake(height, height);
}
@end

NS_ASSUME_NONNULL_END
