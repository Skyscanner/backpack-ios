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

#import "BPKButton.h"

#import <Backpack/Font.h>
#import <Backpack/Color.h>
#import <Backpack/Gradient.h>
#import <Backpack/Spacing.h>
#import <Backpack/UIView+BPKRTL.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKButton()
@property(nonatomic, getter=isInitializing) BOOL initializing;

@property(nonatomic) BPKGradientLayer *gradientLayer;

@property(nonatomic, readonly, getter=isIconOnly) BOOL iconOnly;
@property(nonatomic, readonly, getter=isTextOnly) BOOL textOnly;
@property(nonatomic, readonly, getter=isTextAndIcon) BOOL textAndIcon;

@property(nonatomic, readonly) UIColor *currentContentColor;
@property(nonatomic, readonly) BPKFontStyle currentFontStyle;
@property(nonatomic, class, readonly) UIColor *highlightedWhite;
@property(nonatomic, class, readonly) UIColor *highlightedBlue;
@property(nonatomic, class, readonly) UIColor *highlightedRed;
@property(nonatomic, class, readonly) CGFloat buttonTitleIconSpacing;
@end

@implementation BPKButton

- (instancetype)initWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithSize:size
                      style:style];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithSize:BPKButtonSizeDefault
                      style:BPKButtonStylePrimary];
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
    return self.imageView && self.imageView.image && self.titleLabel.text.length == 0;
}

- (BOOL)isTextOnly {
    return (self.imageView == nil || self.imageView.image == nil) && self.titleLabel.text.length > 0;
}

- (BOOL)isTextAndIcon {
    return self.imageView && self.imageView.image && self.titleLabel.text.length > 0;
}

#pragma mark - Style setters

- (void)setSize:(BPKButtonSize)size {
    if (_size != size || self.isInitializing) {
        _size = size;

        [self updateFont];
        [self updateEdgeInsets];
    }
}

- (void)setStyle:(BPKButtonStyle)style {
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
    _title = [title copy];
//    [super setTitle:title forState:UIControlStateNormal];
    if (title) {
        NSAttributedString *attributedTitle = [BPKFont attributedStringWithFontStyle:self.currentFontStyle content:title textColor:self.currentContentColor];
        [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    } else {
        [self setAttributedTitle:nil forState:UIControlStateNormal];
    }

    [self updateFont];
    [self updateEdgeInsets];
}

- (void)setImage:(UIImage *_Nullable)image {
    [super setImage:image forState:UIControlStateNormal];

    [self updateContentColor];
    [self updateFont];
    [self updateEdgeInsets];
}

#pragma mark - State setters

- (void)setEnabled:(BOOL)enabled {
    BOOL changed = self.isEnabled != enabled;

    [super setEnabled:enabled];

    if (changed) {
        [self updateBackgroundAndStyle];
        [self updateFont];
        [self updateContentColor];
    }
}

- (void)setSelected:(BOOL)selected {
    NSAssert(NO, @"The Backpack button does not support selected");
    [super setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted {
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
        CGFloat radius = CGRectGetHeight(self.bounds) / 2.0f;
        [self.layer setCornerRadius:radius];
    } else {
        self.layer.cornerRadius = 0;
    }
    CGFloat buttonTitleIconSpacing = [[self class] buttonTitleIconSpacing];

    if (self.isTextAndIcon) {
        if (self.imagePosition == BPKButtonImagePositionTrailing) {
            UIEdgeInsets titleEdgeInsets = [self bpk_makeRTLAwareEdgeInsetsWithTop:0
                                                                           leading:-(self.imageView.bounds.size.width + buttonTitleIconSpacing / 2.0)
                                                                            bottom:0
                                                                          trailing:(self.imageView.bounds.size.width + buttonTitleIconSpacing / 2.0)];
            self.titleEdgeInsets = titleEdgeInsets;

            UIEdgeInsets imageEdgeInsets = [self bpk_makeRTLAwareEdgeInsetsWithTop:0
                                                                           leading:(self.titleLabel.bounds.size.width + buttonTitleIconSpacing / 2.0)
                                                                            bottom:0
                                                                          trailing:-(self.titleLabel.bounds.size.width + buttonTitleIconSpacing / 2.0)];
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
    UIColor *highlightedWhite = [UIColor colorWithRed:0.871 green:0.867 blue:0.878 alpha:1];

    if (self.isEnabled) {
        switch (self.style) {
            case BPKButtonStylePrimary: {
                [self setFilledStyleWithNormalBackgroundColorGradientOnTop:BPKColor.green500
                                                          gradientOnBottom:BPKColor.green600
                                                             selectedColor:BPKColor.green700];
                break;
            }
            case BPKButtonStyleSecondary: {
                [self setBorderedStyleWithColor:BPKColor.blue500];
                if (self.isHighlighted) {
                    self.gradientLayer.gradient = [self gradientWithSingleColor:highlightedWhite];
                    [self.gradientLayer setNeedsDisplay];
                }
                break;
            }
            case BPKButtonStyleDestructive: {
                [self setBorderedStyleWithColor:BPKColor.red500];
                if (self.isHighlighted) {
                    self.gradientLayer.gradient = [self gradientWithSingleColor:highlightedWhite];
                    [self.gradientLayer setNeedsDisplay];
                }
                break;
            }
            case BPKButtonStyleFeatured: {
                [self setFilledStyleWithNormalBackgroundColorGradientOnTop:BPKColor.pink500
                                                          gradientOnBottom:BPKColor.pink600
                                                             selectedColor:BPKColor.pink700];
                break;
            }
            case BPKButtonStyleLink: {
                [self setLinkStyleWithColor:BPKColor.blue500];
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
        NSAttributedString *attributedTitle = [BPKFont
                                               attributedStringWithFontStyle:self.currentFontStyle
                                                                     content:self.title
                                                                   textColor:self.currentContentColor];
        [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    } else {
        [self setAttributedTitle:nil forState:UIControlStateNormal];
    }


    self.imageView.tintColor = self.currentContentColor;
    UIColor *highlightedContentColor;

    switch (self.style) {
        // Explicit fall-through
        case BPKButtonStylePrimary:
        case BPKButtonStyleFeatured:
            highlightedContentColor = [self class].highlightedWhite;
            break;
        case BPKButtonStyleSecondary:
            highlightedContentColor = [self class].highlightedBlue;
            break;
        case BPKButtonStyleDestructive:
            highlightedContentColor = [self class].highlightedRed;
            break;
        case BPKButtonStyleLink:
            highlightedContentColor = [self.currentContentColor colorWithAlphaComponent:0.2];
            break;
        default:
            highlightedContentColor = nil;
    }

    if (highlightedContentColor) {
        if (self.title) {
            NSAttributedString *attributedHighlightedTitle = [BPKFont
                                                              attributedStringWithFontStyle:self.currentFontStyle
                                                                                    content:self.title
                                                                                  textColor:highlightedContentColor];

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
    switch(self.style) {
        // Here be dragons, explicit fall-through
        case BPKButtonStylePrimary:
        case BPKButtonStyleFeatured:
            return BPKColor.white;
        // Here be dragons, explicit fall-through
        case BPKButtonStyleSecondary:
        case BPKButtonStyleLink:
            return BPKColor.blue500;
        case BPKButtonStyleDestructive:
            return BPKColor.red500;
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
                                            gradientOnBottom:(UIColor *)normalColorOnBottom
                                               selectedColor:(UIColor *)selectedColor {
    if (self.isHighlighted) {
        self.gradientLayer.gradient = [self gradientWithSingleColor:normalColorOnBottom];
    } else if (self.isSelected) {
        self.gradientLayer.gradient = [self gradientWithSingleColor:selectedColor];
    } else {
        self.gradientLayer.gradient = [self gradientWithTopColor:normalColorOnTop bottomColor:normalColorOnBottom];
    }
    [self.gradientLayer setNeedsDisplay];

    [self.layer setBorderColor:BPKColor.clear.CGColor];
    [self.layer setBorderWidth:0];
}

- (void)setBorderedStyleWithColor:(UIColor *)color {
    self.gradientLayer.gradient = [self gradientWithSingleColor:BPKColor.white];

    UIColor *borderColor = BPKColor.gray100;
    [self.layer setBorderColor:borderColor.CGColor];
    self.layer.borderWidth = 2;
}

- (void)setLinkStyleWithColor:(UIColor *)color {
    self.gradientLayer.gradient = nil;
    
    [self.layer setBorderColor:BPKColor.clear.CGColor];
    [self.layer setBorderWidth:0];
}

- (void)setDisabledStyle {
    UIColor *backgroundColor = self.style == BPKButtonStyleLink ? BPKColor.white : BPKColor.gray100;
    self.gradientLayer.gradient = [self gradientWithSingleColor:backgroundColor];
    [self setTintColor:BPKColor.gray300];
    [self setTitleColor:BPKColor.gray300 forState:UIControlStateDisabled];
    self.layer.borderColor = BPKColor.clear.CGColor;
    self.layer.borderWidth = 0;
}

+ (UIColor *)highlightedWhite {
    // white overlayed with gray900 at 15%
    // TODO: Add a method to blend programatically via BPKColor
    return [UIColor colorWithRed:0.871 green:0.867 blue:0.878 alpha:1];
}

+ (UIColor *)highlightedBlue {
    // blue500 overlayed with gray900 at 15%
    // TODO: Add a method to blend programatically via BPKColor
    return [UIColor colorWithRed:0.0235 green:0.612 blue:0.745 alpha:1];
}

+ (UIColor *)highlightedRed {
    // red500 overlayed with gray900 at 15%
    // TODO: Add a method to blend programatically via BPKColor
    return [UIColor colorWithRed:0.875 green:0.298 blue:0.302 alpha:1];
}

+ (CGFloat)buttonTitleIconSpacing {
    return BPKSpacingSm;
}

@end

NS_ASSUME_NONNULL_END
