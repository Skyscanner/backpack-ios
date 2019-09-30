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

#import "BPKChip.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Shadow.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKChip ()
@property(nonatomic) BPKLabel *titleLabel;
@property(nonatomic) CALayer *tintLayer;

@property(nonatomic) UIColor *textColor;
@end

@implementation BPKChip

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        _primaryColor = BPKColor.skyBlue;

        [self setUp];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        _primaryColor = BPKColor.skyBlue;

        [self setUp];
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        _primaryColor = BPKColor.skyBlue;

        [self setUp];
    }

    [self setTitle:title];

    return self;
}

- (void)setUp {
    self.shadowEnabled = YES;

    self.tintLayer = [CALayer layer];
    self.tintLayer.backgroundColor = BPKColor.skyGrayTint02.CGColor;
    self.tintLayer.opacity = 0;
    [self.layer addSublayer:self.tintLayer];

    self.isAccessibilityElement = YES;
    self.accessibilityTraits = UIAccessibilityTraitButton;

    self.titleLabel = [[BPKLabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.fontStyle = BPKFontStyleTextSm;
    [self addSubview:self.titleLabel];

    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    [self addTarget:self action:@selector(handleSingleTap:) forControlEvents:UIControlEventTouchUpInside];

    [self setUpConstraints];
    [self updateStyle];
}

- (void)setShadowEnabled:(BOOL)shadowEnabled {
    if (_shadowEnabled != shadowEnabled) {
        _shadowEnabled = shadowEnabled;

        [self updateShadowStyle];
        [self updateStyle];
    }
}

- (void)updateShadowStyle {
    if (self.isShadowEnabled) {
        BPKShadow *shadow = [BPKShadow shadowSm];
        [shadow applyToLayer:self.layer];
    } else {
        self.layer.shadowColor = BPKColor.clear.CGColor;
    }
}

#pragma mark - Layout overrides

- (void)layoutSubviews {
    self.tintLayer.frame = self.bounds;
    self.tintLayer.cornerRadius = CGRectGetHeight(self.bounds) / 2.0;

    self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2.0;
}

#pragma mark - State setters

- (void)setPrimaryColor:(UIColor *)primaryColor {
    if (_primaryColor != primaryColor) {
        _primaryColor = primaryColor;
        [self updateStyle];
    }
}

- (void)setTitle:(NSString *_Nullable)title {
    BPKAssertMainThread();
    _title = [title copy];

    [self updateTitle];
}

- (void)setSelected:(BOOL)selected {
    BPKAssertMainThread();
    [super setSelected:selected];
    [self updateStyle];
}

- (void)setHighlighted:(BOOL)highlighted {
    BPKAssertMainThread();
    [super setHighlighted:highlighted];

    [CATransaction begin];
    [CATransaction setAnimationDuration:highlighted ? .2 : 0];
    self.tintLayer.opacity = highlighted ? 0.2 : 0;
    [CATransaction commit];
}

- (void)setEnabled:(BOOL)enabled {
    BPKAssertMainThread();
    [super setEnabled:enabled];
    [self updateStyle];
}

- (void)setColorUnselectedState:(BOOL)colorUnselectedState {
    if (_colorUnselectedState != colorUnselectedState) {
        _colorUnselectedState = colorUnselectedState;

        [self updateStyle];
    }
}

- (void)setBackgroundTint:(UIColor *_Nullable)backgroundTint {
    if (_backgroundTint != backgroundTint) {
        _backgroundTint = backgroundTint;

        [self updateStyle];
    }
}

#pragma mark - Layout

- (void)setUpConstraints {
    CGFloat chipHorizontalSpacing = [self chipHorizontalSpacing];
    CGFloat chipVerticalSpacing = [self chipVerticalSpacing];

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:chipHorizontalSpacing],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:chipVerticalSpacing],
        [self.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:chipHorizontalSpacing],
        [self.bottomAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:chipVerticalSpacing]
    ]];
}

#pragma mark - Updates

- (UIColor *)selectedBackgroundColor {
    if (self.backgroundTint != nil) {
        return self.backgroundTint;
    }

    return self.primaryColor;
}

- (UIColor *)unselectedBackgroundColor {
    if (self.colorUnselectedState) {
        return [BPKColor blend:[self selectedBackgroundColor] with:BPKColor.white weight:0.2];
    }

    return self.shadowEnabled ? BPKColor.white : BPKColor.skyGrayTint07;
}

- (void)updateStyle {
    if (self.selected) {
        self.backgroundColor = [self selectedBackgroundColor];
        self.textColor = BPKColor.white;
    } else {
        self.backgroundColor = [self unselectedBackgroundColor];
        self.textColor = BPKColor.skyGray;
    }

    if (!self.enabled) {
        self.backgroundColor = BPKColor.white;
        self.textColor = BPKColor.skyGrayTint06;
    }

    uint64_t selectedTraitBits = self.selected ? UIAccessibilityTraitSelected : 0;
    uint64_t enabledTraitBits = !self.enabled ? UIAccessibilityTraitNotEnabled : 0;
    self.accessibilityTraits = UIAccessibilityTraitButton | selectedTraitBits | enabledTraitBits;

    [self updateTitle];
}

- (void)updateTitle {
    if (self.title == nil) {
        return;
    }

    self.accessibilityLabel = self.title;
    self.titleLabel.text = self.title;
    [self.titleLabel setTextColor:self.textColor];
}

#pragma mark - Actions

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self setSelected:!self.selected];
}

#pragma mark - Helpers

- (CGFloat)chipHorizontalSpacing {
    return BPKSpacingBase;
}

- (CGFloat)chipVerticalSpacing {
    return BPKSpacingMd;
}

@end

NS_ASSUME_NONNULL_END
