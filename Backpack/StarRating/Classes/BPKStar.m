/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

#import "BPKStar.h"

#import <Backpack/BPKRTLSupport.h>
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Icon.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKStar ()

@property(nonatomic) BPKIconView *starView;

/**
 * Base color of the star when it's empty, its default value is BPKColor.skyGrayTint06. Setting updates
 * the displayed star.
 */
@property(nullable, nonatomic, strong) UIColor *starColor;

@end

@implementation BPKStar

- (instancetype)initWithSize:(BPKStarSize)size {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithSize:size];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithSize:BPKStarSizeSmall];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithSize:BPKStarSizeSmall];
    }

    return self;
}

- (void)setupWithSize:(BPKStarSize)size {

    self.starView = [[BPKIconView alloc] initWithIconName:BPKIconNameStarOutline size:BPKIconSizeSmall];
    self.starView.translatesAutoresizingMaskIntoConstraints = NO;
    self.starView.flipsForRightToLeft = YES;
    [self addSubview:self.starView];

    [NSLayoutConstraint activateConstraints:@[
        [self.leadingAnchor constraintEqualToAnchor:self.starView.leadingAnchor],
        [self.trailingAnchor constraintEqualToAnchor:self.starView.trailingAnchor], [self.topAnchor constraintEqualToAnchor:self.starView.topAnchor],
        [self.bottomAnchor constraintEqualToAnchor:self.starView.bottomAnchor]
    ]];

    _size = size;
    _state = BPKStarStateDefault;

    [self updateSize];
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {
    return [BPKIcon concreteSizeForIconSize:[self iconSizeForStarSize:self.size]];
}

#pragma mark - Setters

- (void)setState:(BPKStarState)state {
    BPKAssertMainThread();
    if (_state != state) {
        _state = state;
        [self updateStarAppearance];
    }
}

- (void)setStarColor:(nullable UIColor *)starColor {
    BPKAssertMainThread();
    if (![_starColor isEqual:starColor]) {
        _starColor = starColor;
        [self updateStarAppearance];
    }
}

- (void)setStarFilledColor:(nullable UIColor *)starFilledColor {
    BPKAssertMainThread();
    if (![_starFilledColor isEqual:starFilledColor]) {
        _starFilledColor = starFilledColor;
        [self updateStarAppearance];
    }
}

- (void)setSize:(BPKStarSize)size {
    BPKAssertMainThread();
    if (_size != size) {
        _size = size;
        [self updateSize];
    }
}

#pragma mark - Helpers

- (UIColor *)currentStarFilledColor {
    return self.starFilledColor != nil ? self.starFilledColor : [self.class defaultStarFilledColor];
}

- (UIColor *)currentStarColor {
    return self.starColor != nil ? self.starColor : [self.class defaultStarColor];
}

- (BPKIconSize)iconSizeForStarSize:(BPKStarSize)size {
    switch (size) {
    case BPKStarSizeXLarge:
        return BPKIconSizeXLarge;
        break;
    case BPKStarSizeLarge:
        return BPKIconSizeLarge;
        break;
    default:
    case BPKStarSizeSmall:
        return BPKIconSizeSmall;
        break;
    }
}

- (void)updateSize {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    self.starView.size = [self iconSizeForStarSize:self.size];
#pragma GCC diagnostic push

    [self setNeedsLayout];
    [self updateStarAppearance];
}

- (void)updateStarAppearance {
    switch (self.state) {
    case BPKStarStateDefault:
        self.starView.iconName = BPKIconNameStarOutline;
        break;
    case BPKStarStateHalf:
        self.starView.iconName = BPKIconNameStarHalf;
        break;
    case BPKStarStateFull:
        self.starView.iconName = BPKIconNameStar;
        break;
    }

    self.starView.tintColor = self.state == BPKStarStateDefault ? self.currentStarColor : self.currentStarFilledColor;
}

+ (UIColor *)defaultStarFilledColor {
    return BPKColor.statusWarningSpotColor;
}

+ (UIColor *)defaultStarColor {
    return BPKColor.textDisabledColor;
}

@end

NS_ASSUME_NONNULL_END
