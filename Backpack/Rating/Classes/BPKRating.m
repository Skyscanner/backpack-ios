/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import "BPKRatingScaleInternal.h"
#import "BPKRatingScaleInternalDefault.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKRating ()
@property(nonatomic, strong) BPKRatingTextWrapper *textWrapper;
@property(nonatomic, strong) BPKRatingBubble *ratingBubble;
@property(nonatomic, strong) NSLayoutConstraint *textSpacingConstraintHorizontal;
@property(nonatomic, strong) NSLayoutConstraint *textSpacingConstraintVertical;
@property(nonatomic, strong) NSArray<NSLayoutConstraint *> *horizontalLayoutConstraints;
@property(nonatomic, strong) NSArray<NSLayoutConstraint *> *verticalLayoutConstraints;
@property(nonatomic, strong) id<BPKRatingScaleInternal> internalScale;
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

- (instancetype)initWithRatingValue:(double)ratingValue strings:(id<BPKRatingStringSet>)strings {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.ratingValue = ratingValue;
        self.strings = strings;

        [self setUp];
    }

    return self;
}

- (void)setUp {
    _ratingScale = BPKRatingScale0to10;
    _internalScale = [BPKRatingScaleInternalDefault make0to10scale];

    self.ratingBubble = [BPKRatingBubble new];
    self.ratingBubble.accessibilityElementsHidden = YES;
    self.size = BPKRatingSizeBase;
    [self.ratingBubble setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.ratingBubble];

    self.textWrapper = [[BPKRatingTextWrapper alloc] initWithFrame:CGRectZero];
    self.textWrapper.accessibilityElementsHidden = YES;
    [self addSubview:self.textWrapper];

    self.isAccessibilityElement = YES;

    [self setUpConstraints];
    [self updateStyle];
}

#pragma mark - State setters

- (void)setLowRatingColor:(UIColor *_Nullable)lowRatingColor {
    BPKAssertMainThread();
    if (_lowRatingColor != lowRatingColor) {
        _lowRatingColor = lowRatingColor;

        [self updateStyle];
    }
}

- (void)setMediumRatingColor:(UIColor *_Nullable)mediumRatingColor {
    BPKAssertMainThread();
    if (_mediumRatingColor != mediumRatingColor) {
        _mediumRatingColor = mediumRatingColor;

        [self updateStyle];
    }
}

- (void)setHighRatingColor:(UIColor *_Nullable)highRatingColor {
    BPKAssertMainThread();
    if (_highRatingColor != highRatingColor) {
        _highRatingColor = highRatingColor;

        [self updateStyle];
    }
}

- (void)setStrings:(id<BPKRatingStringSet>)strings {
    BPKAssertMainThread();
    _strings = strings;

    [self updateStyle];
}

- (void)setRatingValue:(CGFloat)ratingValue {
    BPKAssertMainThread();
    if (_ratingValue != ratingValue) {
        _ratingValue = [self.internalScale clampRating:ratingValue];

        [self updateStyle];
    }
}

- (void)setSize:(BPKRatingSize)size {
    BPKAssertMainThread();
    if (_size != size) {
        _size = size;

        self.textSpacingConstraintHorizontal.constant = [self spacingForCurrentSize];
        self.textSpacingConstraintVertical.constant = [self spacingForCurrentSize];

        self.textWrapper.size = size;
        self.ratingBubble.size = size;
    }
}

- (void)setRatingScale:(BPKRatingScale)ratingScale {
    BPKAssertMainThread();

    if (_ratingScale != ratingScale) {
        _ratingScale = ratingScale;

        switch (_ratingScale) {
            case BPKRatingScale0to5:
                self.internalScale = [BPKRatingScaleInternalDefault make0to5scale];
                break;
            case BPKRatingScale0to10:
                self.internalScale = [BPKRatingScaleInternalDefault make0to10scale];
                break;
            default:
                NSAssert(NO, @"Unhandled rating scale in [BPKRating setRatingScale:]");
                self.internalScale = [BPKRatingScaleInternalDefault make0to10scale];
        }

        // Clamp the previous rating value to the new scale
        self.ratingValue = [self.internalScale clampRating:self.ratingValue];

        [self updateStyle];
    }
}

- (CGFloat)spacingForCurrentSize {
    switch (self.size) {
    case BPKRatingSizeLarge:
    case BPKRatingSizeBase:
    case BPKRatingSizeSmall:
        return BPKSpacingMd;
    case BPKRatingSizeExtraSmall:
        return BPKSpacingSm;
    }
}

- (void)setLayout:(BPKRatingLayout)layout {
    BPKAssertMainThread();
    if (_layout != layout) {
        _layout = layout;

        self.ratingBubble.layout = layout;
        self.textWrapper.layout = layout;
        [self updateLayout];
    }
}

- (void)updateLayout {
    switch (self.layout) {
    case BPKRatingLayoutHorizontal:
    case BPKRatingLayoutHorizontalPill:
        [NSLayoutConstraint deactivateConstraints:self.verticalLayoutConstraints];
        [NSLayoutConstraint activateConstraints:self.horizontalLayoutConstraints];
        break;
    case BPKRatingLayoutVertical:
        [NSLayoutConstraint deactivateConstraints:self.horizontalLayoutConstraints];
        [NSLayoutConstraint activateConstraints:self.verticalLayoutConstraints];
        break;
    }
}

#pragma mark - Layout

- (void)setUpConstraints {
    self.textWrapper.translatesAutoresizingMaskIntoConstraints = NO;
    self.ratingBubble.translatesAutoresizingMaskIntoConstraints = NO;

    self.textSpacingConstraintHorizontal = [self.textWrapper.leadingAnchor constraintEqualToAnchor:self.ratingBubble.trailingAnchor
                                                                                          constant:BPKSpacingMd];

    self.textSpacingConstraintVertical = [self.textWrapper.topAnchor constraintEqualToAnchor:self.ratingBubble.bottomAnchor constant:BPKSpacingMd];

    self.horizontalLayoutConstraints = @[
        [self.ratingBubble.leadingAnchor constraintEqualToAnchor:self.leadingAnchor], self.textSpacingConstraintHorizontal,
        [self.textWrapper.centerYAnchor constraintEqualToAnchor:self.ratingBubble.centerYAnchor]
    ];

    self.verticalLayoutConstraints = @[
        self.textSpacingConstraintVertical,
        [self.textWrapper.centerXAnchor constraintEqualToAnchor:self.ratingBubble.centerXAnchor],
        [self.trailingAnchor constraintGreaterThanOrEqualToAnchor:self.ratingBubble.trailingAnchor],

        // If the text is less wide than the bubble make sure the view in total
        // is still large enough not to clip the bubble.
        [self.widthAnchor constraintGreaterThanOrEqualToAnchor:self.ratingBubble.widthAnchor],
    ];

    [NSLayoutConstraint activateConstraints:@[
        [self.ratingBubble.topAnchor constraintEqualToAnchor:self.topAnchor],

        [self.textWrapper.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.leadingAnchor],
        [self.trailingAnchor constraintGreaterThanOrEqualToAnchor:self.textWrapper.trailingAnchor],

        [self.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.textWrapper.bottomAnchor],
        [self.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.ratingBubble.bottomAnchor]
    ]];

    [self updateLayout];
}

#pragma mark - Updates

- (void)updateStyle {
    [self.ratingBubble setRatingValue:self.ratingValue
                            isExtreme:[self.internalScale isExtreme:self.ratingValue ]];
    BPKRatingRange range = [self.internalScale rangeFor:self.ratingValue];

    switch (range) {
        case BPKRatingRangeLow:
            self.ratingBubble.backgroundColor = self.lowRatingColor ?: BPKColor.panjin;
            break;
        case BPKRatingRangeMedium:
            self.ratingBubble.backgroundColor = self.mediumRatingColor ?: BPKColor.kolkata;
            break;
        case BPKRatingRangeHigh:
            self.ratingBubble.backgroundColor = self.highRatingColor ?: BPKColor.monteverde;
            break;
        default:
            NSAssert(NO, @"[BPKRatig updateStyle] does not correctly handle all rating ranges");
            self.ratingBubble.backgroundColor = self.mediumRatingColor ?: BPKColor.kolkata;
            break;
    }

    self.textWrapper.title = [self.strings rating:self titleFor:range];
    self.textWrapper.subtitle = [self.strings rating:self subtitleFor:range];
    self.accessibilityLabel = [self.strings rating:self accessibilityLabelFor:range value:self.ratingValue];
}

@end

NS_ASSUME_NONNULL_END
