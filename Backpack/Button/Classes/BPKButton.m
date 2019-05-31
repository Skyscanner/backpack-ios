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

#import "BPKButton.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Spacing.h>
#import <Backpack/UIView+BPKRTL.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKButton ()
@property(nonatomic, getter=isInitializing) BOOL initializing;

@property(nonatomic) BPKGradientLayer *gradientLayer;

@property(nonatomic, readonly, getter=isIconOnly) BOOL iconOnly;
@property(nonatomic, readonly, getter=isTextOnly) BOOL textOnly;
@property(nonatomic, readonly, getter=isTextAndIcon) BOOL textAndIcon;

@property(nonatomic, readonly) UIColor *currentContentColor;
@property(nonatomic, readonly) BPKFontStyle currentFontStyle;
@property(nonatomic, class, readonly) UIColor *highlightedWhite;
@property(nonatomic, class, readonly) UIColor *highlightedOutline;
@property(nonatomic, class, readonly) UIColor *highlightedBlue;
@property(nonatomic, class, readonly) UIColor *highlightedRed;
@property(nonatomic, class, readonly) CGFloat buttonTitleIconSpacing;
@end

@implementation BPKButton

- (instancetype)initWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithSize:size style:style];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
    }

    return self;
}

- (void)setupWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style {
    self.initializing = YES;

    self.layer.masksToBounds = YES;
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;

    // Use this to get the title value if one has been set in storyboard.
    if (self.titleLabel != nil && self.titleLabel.text != nil) {
        _title = self.titleLabel.text;
    }

    self.size = size;
    self.style = style;
    self.imagePosition = BPKButtonImagePositionTrailing;

    self.gradientLayer = [[BPKGradientLayer alloc] init];
    [self.layer insertSublayer:self.gradientLayer atIndex:0];

    [self updateEdgeInsets];
    [self updateContentColor];
    [self updateFont];
    [self updateBackgroundAndStyle];
    self.initializing = NO;
}

- (BOOL)isIconOnly {
    return self.currentImage && self.titleLabel.text.length == 0;
}

- (BOOL)isTextOnly {
    return (self.currentImage == nil) && self.titleLabel.text.length > 0;
}

- (BOOL)isTextAndIcon {
    return self.currentImage && self.titleLabel.text.length > 0;
}

#pragma mark - Style setters

- (void)setSize:(BPKButtonSize)size {
    BPKAssertMainThread();
    if (_size != size || self.isInitializing) {
        _size = size;

        [self updateFont];
        [self updateEdgeInsets];
    }
}

- (void)setStyle:(BPKButtonStyle)style {
    BPKAssertMainThread();
    if (_style != style || self.isInitializing) {
        _style = style;

        [self updateBackgroundAndStyle];
        [self updateContentColor];
        [self updateEdgeInsets];
    }
}

- (void)setImagePosition:(BPKButtonImagePosition)imagePosition {
    if (_imagePosition != imagePosition || self.isInitializing) {
        _imagePosition = imagePosition;

        [self setNeedsLayout];
    }
}

- (void)setTitle:(NSString *_Nullable)title {
    BPKAssertMainThread();
    _title = [title copy];

    if (title) {
        NSAttributedString *attributedTitle = [BPKFont attributedStringWithFontStyle:self.currentFontStyle
                                                                             content:title
                                                                           textColor:self.currentContentColor
                                                                         fontMapping:nil];
        [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    } else {
        [self setAttributedTitle:nil forState:UIControlStateNormal];
    }

    [self updateFont];
    [self updateEdgeInsets];
}

- (void)setImage:(UIImage *_Nullable)image {
    BPKAssertMainThread();
    [super setImage:image forState:UIControlStateNormal];

    [self updateContentColor];
    [self updateFont];
    [self updateEdgeInsets];
}

#pragma mark - State setters

- (void)setEnabled:(BOOL)enabled {
    BPKAssertMainThread();
    BOOL changed = self.isEnabled != enabled;

    [super setEnabled:enabled];

    if (changed) {
        [self updateBackgroundAndStyle];
        [self updateFont];
        [self updateContentColor];
    }
}

- (void)setSelected:(BOOL)selected {
    BPKAssertMainThread();
    NSAssert(NO, @"The Backpack button does not support selected");
    [super setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted {
    BPKAssertMainThread();
    BOOL changed = self.isHighlighted != highlighted;

    [super setHighlighted:highlighted];

    if (changed) {
        [self updateBackgroundAndStyle];
        [self updateContentColor];
    }
}

- (void)setCornerRadius:(nullable NSNumber *)cornerRadius {
    if (_cornerRadius != cornerRadius) {
        _cornerRadius = cornerRadius;

        [self setNeedsLayout];
    }
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];

    self.gradientLayer.frame = self.layer.bounds;

    if (self.style != BPKButtonStyleLink) {
        if (self.cornerRadius != nil) {
            self.layer.cornerRadius = self.cornerRadius.doubleValue;
        } else {
            // Pill shape
            CGFloat radius = CGRectGetHeight(self.bounds) / 2.0f;
            [self.layer setCornerRadius:radius];
        }
    } else {
        self.layer.cornerRadius = 0;
    }
    CGFloat buttonTitleIconSpacing = [[self class] buttonTitleIconSpacing];

    if (self.isTextAndIcon) {
        if (self.imagePosition == BPKButtonImagePositionTrailing) {
            UIEdgeInsets titleEdgeInsets =
                [self bpk_makeRTLAwareEdgeInsetsWithTop:0
                                                leading:-(CGRectGetWidth(self.imageView.bounds) +
                                                          buttonTitleIconSpacing / 2.0)
                                                 bottom:0
                                               trailing:(CGRectGetWidth(self.imageView.bounds) +
                                                         buttonTitleIconSpacing / 2.0)];
            self.titleEdgeInsets = titleEdgeInsets;

            UIEdgeInsets imageEdgeInsets =
                [self bpk_makeRTLAwareEdgeInsetsWithTop:0
                                                leading:(CGRectGetWidth(self.titleLabel.bounds) +
                                                         buttonTitleIconSpacing / 2.0)
                                                 bottom:0
                                               trailing:-(CGRectGetWidth(self.titleLabel.bounds) +
                                                          buttonTitleIconSpacing / 2.0)];
            self.imageEdgeInsets = imageEdgeInsets;
        } else {
            UIEdgeInsets titleEdgeInsets = [self bpk_makeRTLAwareEdgeInsetsWithTop:0
                                                                           leading:(buttonTitleIconSpacing / 2.0)
                                                                            bottom:0
                                                                          trailing:-(buttonTitleIconSpacing / 2.0)];
            self.titleEdgeInsets = titleEdgeInsets;

            UIEdgeInsets imageEdgeInsets = [self bpk_makeRTLAwareEdgeInsetsWithTop:0
                                                                           leading:-(buttonTitleIconSpacing / 2.0)
                                                                            bottom:0
                                                                          trailing:(buttonTitleIconSpacing / 2.0)];
            self.imageEdgeInsets = imageEdgeInsets;
        }
    } else {
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        self.contentEdgeInsets = self.contentEdgeInsets = [self contentEdgeInsetsForStyle:self.style size:self.size];
    }
}

- (CGSize)intrinsicContentSize {
    CGSize superSize = [super intrinsicContentSize];
    if (self.isIconOnly || self.isTextOnly) {
        return superSize;
    }

    return CGSizeMake(superSize.width + [[self class] buttonTitleIconSpacing], superSize.height);
}

#pragma mark Spacing

- (UIEdgeInsets)contentEdgeInsetsForStyle:(BPKButtonStyle)style size:(BPKButtonSize)size {
    switch (style) {
    case BPKButtonStyleLink:
        return UIEdgeInsetsMake(BPKSpacingNone, BPKSpacingNone, BPKSpacingNone, BPKSpacingNone);

        // NOTE: Explicit fall-through
    case BPKButtonStylePrimary:
    case BPKButtonStyleFeatured:
    case BPKButtonStyleSecondary:
    case BPKButtonStyleDestructive:
    case BPKButtonStyleOutline:
        switch (size) {
        case BPKButtonSizeDefault: {
            if (self.isIconOnly) {
                return UIEdgeInsetsMake(BPKSpacingMd, BPKSpacingMd, BPKSpacingMd, BPKSpacingMd);
            } else {
                return UIEdgeInsetsMake(BPKSpacingMd, BPKSpacingSm * 3, BPKSpacingMd, BPKSpacingSm * 3);
            }
        }
        case BPKButtonSizeLarge: {
            if (self.isIconOnly) {
                return UIEdgeInsetsMake(BPKSpacingSm * 3, BPKSpacingSm * 3, BPKSpacingSm * 3, BPKSpacingSm * 3);
            } else {
                return UIEdgeInsetsMake(BPKSpacingSm * 3, BPKSpacingBase, BPKSpacingSm * 3, BPKSpacingBase);
            }
        }
        default:
            NSAssert(NO, @"Unknown size %d", (int)size);
            break;
        }
        break;
    default:
        NSAssert(NO, @"Unknown style %d", (int)style);
    }
}

#pragma mark - Updates

- (void)updateBackgroundAndStyle {
    UIColor *highlightedOutline = [BPKColor.gray900 colorWithAlphaComponent:0.2];

    if (self.isEnabled) {

        // We need this here so that if the button was disabled, and is now enabled, opacity is reset.
        self.layer.opacity = 1;

        switch (self.style) {
        case BPKButtonStylePrimary: {
            UIColor *startColor = self.primaryGradientStartColor ? self.primaryGradientStartColor : BPKColor.green500;
            UIColor *endColor = self.primaryGradientEndColor ? self.primaryGradientEndColor : BPKColor.green600;

            [self setFilledStyleWithNormalBackgroundColorGradientOnTop:startColor gradientOnBottom:endColor];
            break;
        }
        case BPKButtonStyleSecondary: {
            UIColor *backgroundColor = self.secondaryBackgroundColor ? self.secondaryBackgroundColor : BPKColor.white;
            UIColor *borderColor = self.secondaryBorderColor ? self.secondaryBorderColor : BPKColor.gray100;
            [self setBorderedStyleWithColor:borderColor withGradientColor:backgroundColor];
            if (self.isHighlighted) {
                self.gradientLayer.gradient = [self gradientWithSingleColor:[BPKColor blend:backgroundColor
                                                                                       with:BPKColor.gray900
                                                                                     weight:0.85f]];
                [self.gradientLayer setNeedsDisplay];
            }
            break;
        }
        case BPKButtonStyleDestructive: {
            UIColor *backgroundColor =
                self.destructiveBackgroundColor ? self.destructiveBackgroundColor : BPKColor.white;
            UIColor *borderColor = self.destructiveBorderColor ? self.destructiveBorderColor : BPKColor.gray100;
            [self setBorderedStyleWithColor:borderColor withGradientColor:backgroundColor];
            if (self.isHighlighted) {
                self.gradientLayer.gradient = [self gradientWithSingleColor:[BPKColor blend:backgroundColor
                                                                                       with:BPKColor.gray900
                                                                                     weight:0.85f]];
                [self.gradientLayer setNeedsDisplay];
            }
            break;
        }
        case BPKButtonStyleOutline: {
            [self setBorderedStyleWithColor:BPKColor.white withGradientColor:BPKColor.clear];
            if (self.isHighlighted) {
                [self setBorderedStyleWithColor:[self class].highlightedOutline withGradientColor:BPKColor.clear];
                self.gradientLayer.gradient = [self gradientWithSingleColor:highlightedOutline];
                [self.gradientLayer setNeedsDisplay];
            }
            break;
        }
        case BPKButtonStyleFeatured: {
            UIColor *startColor = self.featuredGradientStartColor ? self.featuredGradientStartColor : BPKColor.pink500;
            UIColor *endColor = self.featuredGradientEndColor ? self.featuredGradientEndColor : BPKColor.pink600;

            [self setFilledStyleWithNormalBackgroundColorGradientOnTop:startColor gradientOnBottom:endColor];
            break;
        }
        case BPKButtonStyleLink: {
            UIColor *contentColor = self.linkContentColor ? self.linkContentColor : BPKColor.blue500;

            [self setLinkStyleWithColor:contentColor];
            break;
        }
        default: {
            NSAssert(NO, @"Invalid style value %d", (int)self.style);
            break;
        }
        }
    } else {
        [self setDisabledStyle];
    }

    [self setNeedsDisplay];
}

- (void)updateFont {
    if (self.isIconOnly) {
        self.titleLabel.font = [UIFont systemFontOfSize:0];
        [self setAttributedTitle:nil forState:UIControlStateNormal];
    }

    [self setNeedsDisplay];
}

- (void)updateContentColor {
    [self setTitleColor:self.currentContentColor forState:UIControlStateNormal];
    if (self.title) {
        NSAttributedString *attributedTitle = [BPKFont attributedStringWithFontStyle:self.currentFontStyle
                                                                             content:self.title
                                                                           textColor:self.currentContentColor
                                                                         fontMapping:nil];
        [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    } else {
        [self setAttributedTitle:nil forState:UIControlStateNormal];
    }

    self.imageView.tintColor = self.currentContentColor;
    UIColor *highlightedContentColor;

    switch (self.style) {
    case BPKButtonStylePrimary:
        if (self.primaryContentColor != nil) {
            highlightedContentColor = [BPKColor blend:self.primaryContentColor with:BPKColor.gray900 weight:0.85f];
        } else {
            highlightedContentColor = [self class].highlightedWhite;
        }
        break;
    case BPKButtonStyleFeatured:
        if (self.featuredContentColor != nil) {
            highlightedContentColor = [BPKColor blend:self.featuredContentColor with:BPKColor.gray900 weight:0.85f];
        } else {
            highlightedContentColor = [self class].highlightedWhite;
        }
        break;
    case BPKButtonStyleSecondary:
        if (self.secondaryContentColor != nil) {
            highlightedContentColor = [BPKColor blend:self.secondaryContentColor with:BPKColor.gray900 weight:0.85f];
        } else {
            highlightedContentColor = [self class].highlightedBlue;
        }
        break;
    case BPKButtonStyleDestructive:
        if (self.destructiveContentColor != nil) {
            highlightedContentColor = [BPKColor blend:self.destructiveContentColor with:BPKColor.gray900 weight:0.85f];
        } else {
            highlightedContentColor = [self class].highlightedRed;
        }
        break;
    case BPKButtonStyleOutline:
        highlightedContentColor = [self class].highlightedOutline;
        break;
    case BPKButtonStyleLink:
        highlightedContentColor = [self.currentContentColor colorWithAlphaComponent:0.2];
        break;
    default:
        highlightedContentColor = nil;
    }

    if (highlightedContentColor) {
        if (self.title) {
            NSAttributedString *attributedHighlightedTitle =
                [BPKFont attributedStringWithFontStyle:self.currentFontStyle
                                               content:self.title
                                             textColor:highlightedContentColor
                                           fontMapping:nil];

            [self setAttributedTitle:attributedHighlightedTitle forState:UIControlStateHighlighted];
            [self setAttributedTitle:attributedHighlightedTitle forState:UIControlStateSelected];
        }

        self.imageView.tintColor = self.isHighlighted ? highlightedContentColor : self.currentContentColor;
    }

    [self setNeedsDisplay];
}

- (void)updateEdgeInsets {
    if (self.isIconOnly) {
        self.imageEdgeInsets = UIEdgeInsetsZero;
        self.titleEdgeInsets = UIEdgeInsetsZero;
    }

    self.contentEdgeInsets = [self contentEdgeInsetsForStyle:self.style size:self.size];
    [self setNeedsLayout];
}

#pragma mark - Helpers

- (BPKFontStyle)currentFontStyle {
    switch (self.size) {
    case BPKButtonSizeDefault:
        return BPKFontStyleTextSmEmphasized;
    case BPKButtonSizeLarge:
        return BPKFontStyleTextLgEmphasized;
    default:
        NSAssert(NO, @"Unknown button size %ld", (unsigned long)self.size);
        return BPKFontStyleTextSmEmphasized;
    }
}

- (UIColor *)currentContentColor {
    if (!self.enabled) {
        return BPKColor.gray300;
    }
    switch (self.style) {
    case BPKButtonStylePrimary:
        if (self.primaryContentColor != nil) {
            return self.primaryContentColor;
        }
        return BPKColor.white;
    case BPKButtonStyleFeatured:
        if (self.featuredContentColor != nil) {
            return self.featuredContentColor;
        }
        return BPKColor.white;
    case BPKButtonStyleSecondary:
        if (self.secondaryContentColor != nil) {
            return self.secondaryContentColor;
        }
        return BPKColor.blue500;
    case BPKButtonStyleLink:
        if (self.linkContentColor != nil) {
            return self.linkContentColor;
        }
        return BPKColor.blue500;
    case BPKButtonStyleDestructive:
        if (self.destructiveContentColor != nil) {
            return self.destructiveContentColor;
        }
        return BPKColor.red500;
    case BPKButtonStyleOutline:
        return BPKColor.white;
    default:
        NSAssert(NO, @"Unknown BPKButtonStyle %d", (int)self.style);
        return BPKColor.white;
    }
}

- (BPKGradient *)gradientWithSingleColor:(UIColor *)color {
    NSParameterAssert(color);

    return [self gradientWithTopColor:color bottomColor:color];
}

- (BPKGradient *)gradientWithTopColor:(UIColor *)top bottomColor:(UIColor *)bottom {
    NSParameterAssert(top);
    NSParameterAssert(bottom);

    BPKGradientDirection direction = BPKGradientDirectionDown;
    return [[BPKGradient alloc] initWithColors:@[top, bottom]
                                    startPoint:[BPKGradient startPointForDirection:direction]
                                      endPoint:[BPKGradient endPointForDirection:direction]];
}

- (void)setFilledStyleWithNormalBackgroundColorGradientOnTop:(UIColor *)normalColorOnTop
                                            gradientOnBottom:(UIColor *)normalColorOnBottom {
    if (self.isHighlighted) {
        self.gradientLayer.gradient = [self gradientWithSingleColor:normalColorOnBottom];
    } else {
        self.gradientLayer.gradient = [self gradientWithTopColor:normalColorOnTop bottomColor:normalColorOnBottom];
    }
    [self.gradientLayer setNeedsDisplay];

    [self.layer setBorderColor:BPKColor.clear.CGColor];
    [self.layer setBorderWidth:0];
}

- (void)setBorderedStyleWithColor:(UIColor *)color withGradientColor:(UIColor *)gradientColor {
    self.gradientLayer.gradient = [self gradientWithSingleColor:gradientColor];

    UIColor *borderColor = color;
    [self.layer setBorderColor:borderColor.CGColor];
    self.layer.borderWidth = 2;
}

- (void)setLinkStyleWithColor:(UIColor *)color {
    self.gradientLayer.gradient = nil;

    [self.layer setBorderColor:BPKColor.clear.CGColor];
    [self.layer setBorderWidth:0];
}

- (void)setDisabledStyle {
    UIColor *backgroundColor = nil;
    switch (self.style) {
        // Explicit fall-through
    case BPKButtonStylePrimary:
    case BPKButtonStyleFeatured:
    case BPKButtonStyleSecondary:
    case BPKButtonStyleDestructive:
        backgroundColor = BPKColor.gray100;
        break;
    case BPKButtonStyleOutline:
        backgroundColor = BPKColor.white;
        break;
    case BPKButtonStyleLink:
        backgroundColor = UIColor.clearColor;
        break;
    default:
        backgroundColor = nil;
    }

    self.gradientLayer.gradient = [self gradientWithSingleColor:backgroundColor];
    [self setTintColor:BPKColor.gray300];
    [self setTitleColor:BPKColor.gray300 forState:UIControlStateDisabled];
    self.layer.borderColor = BPKColor.clear.CGColor;
    self.layer.opacity = self.style == BPKButtonStyleOutline ? 0.8 : 1;
    self.layer.borderWidth = 0;
}

- (void)setFeaturedContentColor:(UIColor *_Nullable)featuredContentColor {
    if (featuredContentColor != _featuredContentColor) {
        _featuredContentColor = featuredContentColor;
        [self updateContentColor];
    }
}

- (void)setFeaturedGradientStartColor:(UIColor *_Nullable)featuredGradientStartColor {
    if (featuredGradientStartColor != _featuredGradientStartColor) {
        _featuredGradientStartColor = featuredGradientStartColor;
        [self updateBackgroundAndStyle];
    }
}

- (void)setFeaturedGradientEndColor:(UIColor *_Nullable)featuredGradientEndColor {
    if (featuredGradientEndColor != _featuredGradientEndColor) {
        _featuredGradientEndColor = featuredGradientEndColor;
        [self updateBackgroundAndStyle];
    }
}

- (void)setPrimaryContentColor:(UIColor *_Nullable)primaryContentColor {
    if (primaryContentColor != _primaryContentColor) {
        _primaryContentColor = primaryContentColor;
        [self updateContentColor];
    }
}

- (void)setPrimaryGradientStartColor:(UIColor *_Nullable)primaryGradientStartColor {
    if (primaryGradientStartColor != _primaryGradientStartColor) {
        _primaryGradientStartColor = primaryGradientStartColor;
        [self updateBackgroundAndStyle];
    }
}

- (void)setPrimaryGradientEndColor:(UIColor *_Nullable)primaryGradientEndColor {
    if (primaryGradientEndColor != _primaryGradientEndColor) {
        _primaryGradientEndColor = primaryGradientEndColor;
        [self updateBackgroundAndStyle];
    }
}

- (void)setSecondaryContentColor:(UIColor *_Nullable)secondaryContentColor {
    if (secondaryContentColor != _secondaryContentColor) {
        _secondaryContentColor = secondaryContentColor;
        [self updateContentColor];
    }
}

- (void)setSecondaryBackgroundColor:(UIColor *_Nullable)secondaryBackgroundColor {
    if (secondaryBackgroundColor != _secondaryBackgroundColor) {
        _secondaryBackgroundColor = secondaryBackgroundColor;
        [self updateBackgroundAndStyle];
    }
}

- (void)setSecondaryBorderColor:(UIColor *_Nullable)secondaryBorderColor {
    if (secondaryBorderColor != _secondaryBorderColor) {
        _secondaryBorderColor = secondaryBorderColor;
        [self updateBackgroundAndStyle];
    }
}

- (void)setDestructiveContentColor:(UIColor *_Nullable)destructiveContentColor {
    if (destructiveContentColor != _destructiveContentColor) {
        _destructiveContentColor = destructiveContentColor;
        [self updateContentColor];
    }
}

- (void)setDestructiveBackgroundColor:(UIColor *_Nullable)destructiveBackgroundColor {
    if (destructiveBackgroundColor != _destructiveBackgroundColor) {
        _destructiveBackgroundColor = destructiveBackgroundColor;
        [self updateBackgroundAndStyle];
    }
}

- (void)setDestructiveBorderColor:(UIColor *_Nullable)destructiveBorderColor {
    if (destructiveBorderColor != _destructiveBorderColor) {
        _destructiveBorderColor = destructiveBorderColor;
        [self updateBackgroundAndStyle];
    }
}

- (void)setLinkContentColor:(UIColor *_Nullable)linkContentColor {
    if (linkContentColor != _linkContentColor) {
        _linkContentColor = linkContentColor;
        [self updateBackgroundAndStyle];
    }
}

+ (UIColor *)highlightedWhite {
    return [BPKColor blend:BPKColor.white with:BPKColor.gray900 weight:0.85f];
}

+ (UIColor *)highlightedOutline {
    return [BPKColor.white colorWithAlphaComponent:0.8];
}

+ (UIColor *)highlightedBlue {
    return [BPKColor blend:BPKColor.blue500 with:BPKColor.gray900 weight:0.85f];
}

+ (UIColor *)highlightedRed {
    return [BPKColor blend:BPKColor.red500 with:BPKColor.gray900 weight:0.85f];
}

+ (CGFloat)buttonTitleIconSpacing {
    return BPKSpacingSm;
}

@end

NS_ASSUME_NONNULL_END
