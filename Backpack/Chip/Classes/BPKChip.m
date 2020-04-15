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

#import "BPKChip.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/DarkMode.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Shadow.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKChip ()
@property(nonatomic) BPKLabel *titleLabel;
@property(nonatomic) CALayer *tintLayer;
@property(nonatomic) UIColor *contentColor;
@property(nullable, nonatomic) BPKIconView *iconView;
@property(nullable, nonatomic) NSArray<NSLayoutConstraint *> *iconConstraints;
@end

@implementation BPKChip

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setUp];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setUp];
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
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

- (void)setPrimaryColor:(UIColor *_Nullable)primaryColor {
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
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:chipVerticalSpacing],
        [self.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:chipHorizontalSpacing],
        [self.bottomAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:chipVerticalSpacing]
    ]];

    [self updateIconConstraints];
}

#pragma mark - Updates

- (UIColor *)currentPrimaryColor {
    return self.primaryColor != nil ? self.primaryColor : BPKColor.skyBlue;
}

- (UIColor *)selectedBackgroundColor {
    if (self.backgroundTint != nil) {
        return self.backgroundTint;
    }

    return self.currentPrimaryColor;
}

- (UIColor *)unselectedBackgroundColor {
    if (self.colorUnselectedState) {
        return [BPKColor blend:[self selectedBackgroundColor] with:BPKColor.backgroundTertiaryColor weight:0.2];
    }

    return [self defaultUnselectedBackgroundColor];
}

- (UIColor *)defaultUnselectedBackgroundColor {
    if (self.shadowEnabled) {
        return BPKColor.backgroundTertiaryColor;
    }

    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint07
                                      darkVariant:BPKColor.backgroundTertiaryDarkColor];
}

- (void)updateStyle {
    if (self.selected) {
        self.backgroundColor = [self selectedBackgroundColor];
        self.contentColor = BPKColor.white;
    } else {
        self.backgroundColor = [self unselectedBackgroundColor];
        self.contentColor = BPKColor.textPrimaryColor;
    }

    if (!self.enabled) {
        self.backgroundColor = [self.class disabledBackgroundColor];
        self.contentColor = [self.class disabledContentColor];
    }

    uint64_t selectedTraitBits = self.selected ? UIAccessibilityTraitSelected : 0;
    uint64_t enabledTraitBits = !self.enabled ? UIAccessibilityTraitNotEnabled : 0;
    self.accessibilityTraits = UIAccessibilityTraitButton | selectedTraitBits | enabledTraitBits;

    [self updateTitle];
    [self updateIcon];
}

- (void)updateIcon {
    if (self.iconView == nil) {
        return;
    }

    self.iconView.tintColor = self.contentColor;
}

- (void)updateTitle {
    if (self.title == nil) {
        return;
    }

    self.accessibilityLabel = self.title;
    self.titleLabel.text = self.title;
    [self.titleLabel setTextColor:self.contentColor];
}

- (void)setIconName:(BPKIconName _Nullable)iconName {
    if (_iconName != iconName) {
        _iconName = iconName;

        if (iconName == nil && self.iconView != nil) {
            [self.iconView removeFromSuperview];
            self.iconView = nil;
        } else {
            self.iconView = [[BPKIconView alloc] initWithIconName:iconName size:BPKIconSizeLarge];
            [self addSubview:self.iconView];
            [self updateStyle];
        }
        [self updateIconConstraints];
    }
}

- (void)updateIconConstraints {
    CGFloat chipHorizontalSpacing = [self chipHorizontalSpacing];
    CGFloat chipIconSpacing = [self chipIconSpacing];

    if (self.iconConstraints != nil) {
        [NSLayoutConstraint deactivateConstraints:self.iconConstraints];
    }

    if (self.iconView == nil) {
        self.iconConstraints = @[[self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                                               constant:chipHorizontalSpacing]];
    } else {
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        self.iconConstraints = @[
            [self.iconView.centerYAnchor constraintEqualToAnchor:self.titleLabel.centerYAnchor],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:chipHorizontalSpacing],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.iconView.trailingAnchor
                                                          constant:chipIconSpacing]
        ];
    }

    [NSLayoutConstraint activateConstraints:self.iconConstraints];
}

// This is required as the colours that are blended will not be dynamic values
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle) {
            [self updateStyle];
        }
    }
#endif
}

#pragma mark - Actions

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self setSelected:!self.selected];
}

#pragma mark - Helpers

- (CGFloat)chipIconSpacing {
    return BPKSpacingSm;
}

- (CGFloat)chipHorizontalSpacing {
    return BPKSpacingBase;
}

- (CGFloat)chipVerticalSpacing {
    return BPKSpacingMd;
}

+ (UIColor *)disabledBackgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.blackTint02];
}

+ (UIColor *)disabledContentColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint06 darkVariant:BPKColor.blackTint05];
}

@end

NS_ASSUME_NONNULL_END
