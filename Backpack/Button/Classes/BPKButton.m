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

/*
 * Note that in some places we are having to resolve the correct UIColors from dynamic values ourselves to ensure
 * that we support overriding UIViewController interface styles. if we allow UIKit to resolve them for us,
 * it may do so wrongly.
 * This is because UIKit only sets the UIView's trait collection on a handful of lifecycle methods, and we
 * are using dynamic colours outside of these. If we do not manually resolve colours using self.traitCollection,
 * then UIKit will fall back to using [UITraitCollection currentTraitCollection] which does not reflect the override.
 */

#import "BPKButton.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/DarkMode.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Radii.h>
#import <Backpack/Spacing.h>
#import <Backpack/UIView+BPKRTL.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKButton ()
@property(nonatomic, getter=isInitializing) BOOL initializing;

@property(nonatomic) BPKGradientLayer *gradientLayer;

@property(nonatomic, readonly) BOOL hasTitle;
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
@property(nonatomic, readonly) UIColor *disabledLinkColor;
@property(nonatomic, readonly) UIColor *disabledBackgroundColor;
@property(nonatomic, readonly) UIColor *disabledContentColor;
@property(nonatomic, readonly) UIColor *boxyBackgroundColor;
@property(nonatomic, readonly) UIColor *boxyContentColor;
@property(nonatomic, strong) UIActivityIndicatorView *spinner;
@property(nonatomic, strong) NSNumber *cornerRadius;
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

    _cornerRadius = @(BPKBorderRadiusSm);

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

- (BOOL)hasTitle {
    return self.titleLabel.text.length > 0 && self.currentAttributedTitle != nil;
}

- (BOOL)isIconOnly {
    return self.currentImage && !self.hasTitle;
}

- (BOOL)isTextOnly {
    return (self.currentImage == nil) && self.hasTitle;
}

- (BOOL)isTextAndIcon {
    return self.currentImage && self.hasTitle;
}

#pragma mark - Style setters

- (void)setSize:(BPKButtonSize)size {
    BPKAssertMainThread();
    if (_size != size || self.isInitializing) {
        _size = size;

        [self updateTitle];
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
    [self updateTitle];
}

- (void)updateTitle {
    if (self.title) {
        NSAttributedString *attributedTitle = [BPKFont attributedStringWithFontStyle:self.currentFontStyle
                                                                             content:self.title
                                                                           textColor:self.currentContentColor
                                                                         fontMapping:_fontMapping];
        [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    } else {
        [self setAttributedTitle:nil forState:UIControlStateNormal];
        [self setAttributedTitle:nil forState:UIControlStateHighlighted];
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

- (void)setFontMapping:(BPKFontMapping *_Nullable)fontMapping {
    if (_fontMapping != fontMapping) {
        _fontMapping = fontMapping;

        [self updateTitle];
    }
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

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];

    self.gradientLayer.frame = self.layer.bounds;

    if (self.style != BPKButtonStyleLink) {
        if (self.cornerRadius != nil && !self.iconOnly) {
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
        self.contentEdgeInsets = [self contentEdgeInsetsForStyle:self.style size:self.size];
    }

    if (self.isIconOnly || self.isTextAndIcon) {
        self.spinner.center = self.imageView.center;
    } else {
        self.spinner.center = self.center;
    }
    self.imageView.alpha = self.isLoading ? .0f : 1.f;
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
    UIColor *highlightedOutline = [BPKColor.skyGray colorWithAlphaComponent:0.2];

    if (self.isEnabled) {

        // We need this here so that if the button was disabled, and is now enabled, opacity is reset.
        self.layer.opacity = 1;
        self.gradientLayer.gradient = nil;

        switch (self.style) {
        case BPKButtonStylePrimary: {
            UIColor *startColor = self.primaryGradientStartColor ? self.primaryGradientStartColor : BPKColor.monteverde;
            UIColor *endColor = self.primaryGradientEndColor ? self.primaryGradientEndColor : BPKColor.monteverde;

            [self setFilledStyleWithNormalBackgroundColorGradientOnTop:startColor gradientOnBottom:endColor];
            break;
        }
        case BPKButtonStyleSecondary: {
            UIColor *backgroundColor =
                self.secondaryBackgroundColor ? self.secondaryBackgroundColor : [self class].boxyBackgroundColor;
            UIColor *borderColor = self.secondaryBorderColor ? self.secondaryBorderColor : [self class].boxyBorderColor;
            [self setBorderedStyleWithColor:borderColor withGradientColor:backgroundColor];
            if (self.isHighlighted) {
                self.gradientLayer.gradient = [self gradientWithSingleColor:[self highlightedColor:backgroundColor]];
                [self.gradientLayer setNeedsDisplay];
            }
            break;
        }
        case BPKButtonStyleDestructive: {
            UIColor *backgroundColor =
                self.destructiveBackgroundColor ? self.destructiveBackgroundColor : [self class].boxyBackgroundColor;
            UIColor *borderColor =
                self.destructiveBorderColor ? self.destructiveBorderColor : [self class].boxyBorderColor;
            [self setBorderedStyleWithColor:borderColor withGradientColor:backgroundColor];
            if (self.isHighlighted) {
                self.gradientLayer.gradient = [self gradientWithSingleColor:[self highlightedColor:backgroundColor]];
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
            UIColor *startColor = self.featuredGradientStartColor ? self.featuredGradientStartColor : BPKColor.skyBlue;
            UIColor *endColor = self.featuredGradientEndColor ? self.featuredGradientEndColor : BPKColor.skyBlue;

            [self setFilledStyleWithNormalBackgroundColorGradientOnTop:startColor gradientOnBottom:endColor];
            break;
        }
        case BPKButtonStyleLink: {
            UIColor *contentColor = self.linkContentColor ? self.linkContentColor : BPKColor.primaryColor;

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

- (UIColor *)highlightedColor:(UIColor *)originalColor {
    UIColor *resolvedColor = originalColor;
#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 13.0, *)) {
        resolvedColor = [originalColor resolvedColorWithTraitCollection:self.traitCollection];
    }
#endif
    return [BPKColor blend:resolvedColor with:BPKColor.skyGray weight:0.85f];
}

- (void)updateContentColor {
    [self setTitleColor:self.currentContentColor forState:UIControlStateNormal];
    if (self.title) {
        NSAttributedString *attributedTitle = [BPKFont attributedStringWithFontStyle:self.currentFontStyle
                                                                             content:self.title
                                                                           textColor:self.currentContentColor
                                                                         fontMapping:_fontMapping];
        [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    } else {
        [self setAttributedTitle:nil forState:UIControlStateNormal];
        [self setAttributedTitle:nil forState:UIControlStateHighlighted];
    }

    self.imageView.tintColor = self.currentContentColor;
    self.spinner.color = self.currentContentColor;
    UIColor *highlightedContentColor;

    switch (self.style) {
    case BPKButtonStylePrimary:
        if (self.primaryContentColor != nil) {
            highlightedContentColor = [self highlightedColor:self.primaryContentColor];
        } else {
            highlightedContentColor = [self class].highlightedWhite;
        }
        break;
    case BPKButtonStyleFeatured:
        if (self.featuredContentColor != nil) {
            highlightedContentColor = [self highlightedColor:self.featuredContentColor];
        } else {
            highlightedContentColor = [self class].highlightedWhite;
        }
        break;
    case BPKButtonStyleSecondary:
        if (self.secondaryContentColor != nil) {
            highlightedContentColor = [self highlightedColor:self.secondaryContentColor];
        } else {
            highlightedContentColor = [self class].highlightedBlue;
        }
        break;
    case BPKButtonStyleDestructive:
        if (self.destructiveContentColor != nil) {
            highlightedContentColor = [self highlightedColor:self.destructiveContentColor];
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
                                           fontMapping:_fontMapping];

            [self setAttributedTitle:attributedHighlightedTitle forState:UIControlStateHighlighted];
            [self setAttributedTitle:attributedHighlightedTitle forState:UIControlStateSelected];
        }

        self.imageView.tintColor = self.isHighlighted ? highlightedContentColor : self.currentContentColor;
        self.spinner.color = self.isHighlighted ? highlightedContentColor : self.currentContentColor;
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
        switch (self.style) {
        // NOTE: Explicit fall-through
        case BPKButtonStylePrimary:
        case BPKButtonStyleFeatured:
        case BPKButtonStyleSecondary:
        case BPKButtonStyleDestructive:
            return [self class].disabledContentColor;
        case BPKButtonStyleLink:
            return [self class].disabledLinkColor;
        case BPKButtonStyleOutline:
            return BPKColor.skyGrayTint04;
        default:
            NSAssert(NO, @"Unknown BPKButtonStyle %d", (int)self.style);
            return BPKColor.white;
        }
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
        return BPKColor.primaryColor;
    case BPKButtonStyleLink:
        if (self.linkContentColor != nil) {
            return self.linkContentColor;
        }
        return BPKColor.primaryColor;
    case BPKButtonStyleDestructive:
        if (self.destructiveContentColor != nil) {
            return self.destructiveContentColor;
        }
        return BPKColor.systemRed;
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

    UIColor *resolvedTopColor = top;
    UIColor *resolvedBottomColor = bottom;

#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 13.0, *)) {
        resolvedTopColor = [top resolvedColorWithTraitCollection:self.traitCollection];
        resolvedBottomColor = [bottom resolvedColorWithTraitCollection:self.traitCollection];
    }
#endif

    BPKGradientDirection direction = BPKGradientDirectionDown;
    return [[BPKGradient alloc] initWithColors:@[resolvedTopColor, resolvedBottomColor]
                                    startPoint:[BPKGradient startPointForDirection:direction]
                                      endPoint:[BPKGradient endPointForDirection:direction]];
}

- (void)setFilledStyleWithNormalBackgroundColorGradientOnTop:(UIColor *)normalColorOnTop
                                            gradientOnBottom:(UIColor *)normalColorOnBottom {
    if (self.isHighlighted) {
        self.gradientLayer.gradient = [self gradientWithSingleColor:[BPKColor blend:normalColorOnTop
                                                                               with:BPKColor.skyGray
                                                                             weight:0.85f]];
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
#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 13.0, *)) {
        borderColor = [color resolvedColorWithTraitCollection:self.traitCollection];
    }
#endif
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
    // NOTE: Explicit fall-through
    case BPKButtonStylePrimary:
    case BPKButtonStyleFeatured:
    case BPKButtonStyleSecondary:
    case BPKButtonStyleDestructive:
        backgroundColor = [self class].disabledBackgroundColor;
        break;
    case BPKButtonStyleOutline:
        backgroundColor = BPKColor.white;
        break;
    case BPKButtonStyleLink:
        backgroundColor = BPKColor.clear;
        break;
    default:
        backgroundColor = nil;
    }

    self.gradientLayer.gradient = [self gradientWithSingleColor:backgroundColor];
    [self setTintColor:BPKColor.skyGrayTint04];
    [self setTitleColor:BPKColor.skyGrayTint04 forState:UIControlStateDisabled];
    self.layer.borderColor = BPKColor.clear.CGColor;
    self.layer.opacity = self.style == BPKButtonStyleOutline ? 0.8 : 1;
    self.layer.borderWidth = 0;
}

- (void)setupSpinner {
    self.spinner = [[UIActivityIndicatorView alloc] init];
    switch (self.size) {
    case BPKButtonSizeDefault:
        self.spinner.transform = CGAffineTransformMakeScale(.75f, .75f);
        break;

    case BPKButtonSizeLarge:
        self.spinner.transform = CGAffineTransformMakeScale(1.f, 1.f);
        break;
    }

    [self addSubview:self.spinner];
}

- (void)updateLoadingState:(BOOL)loading {
    self.enabled = !loading;
    self.spinner.hidden = !self.isLoading;

    if (!self.spinner && self.isLoading) {
        [self setupSpinner];
    }

    if (loading) {
        [self.spinner startAnimating];
    } else {
        [self.spinner stopAnimating];
    }

    if (!self.isTextAndIcon) {
        self.titleLabel.layer.opacity = loading ? 0 : 1;
    }

    [self updateContentColor];
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
        [self updateContentColor];
    }
}

- (void)setIsLoading:(BOOL)isLoading {
    if (_isLoading != isLoading) {
        _isLoading = isLoading;
        [self updateLoadingState:isLoading];
    }
}

+ (UIColor *)highlightedWhite {
    return [BPKColor blend:BPKColor.white with:BPKColor.skyGray weight:0.85f];
}

+ (UIColor *)highlightedOutline {
    return [BPKColor.white colorWithAlphaComponent:0.8];
}

+ (UIColor *)highlightedBlue {
    return [BPKColor blend:BPKColor.primaryColor with:BPKColor.skyGray weight:0.85f];
}

+ (UIColor *)highlightedRed {
    return [BPKColor blend:BPKColor.systemRed with:BPKColor.skyGray weight:0.85f];
}

// Note this is needed as the system does not correctly respond to the trait collection change to update the background
// color.
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle) {
            [self updateBackgroundAndStyle];
            [self updateContentColor];
        }
    }
#endif
}

+ (UIColor *)disabledBackgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint06 darkVariant:BPKColor.blackTint02];
}

+ (UIColor *)disabledContentColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint04 darkVariant:BPKColor.blackTint03];
}

+ (UIColor *)disabledLinkColor {
    return BPKColor.skyGrayTint04;
}

+ (UIColor *)disabledBorderColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint03 darkVariant:BPKColor.blackTint03];
}

+ (UIColor *)boxyBackgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.blackTint02];
}

+ (UIColor *)boxyBorderColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint06 darkVariant:BPKColor.skyGrayTint02];
}

+ (CGFloat)buttonTitleIconSpacing {
    return BPKSpacingSm;
}

@end

NS_ASSUME_NONNULL_END
