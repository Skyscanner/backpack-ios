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

NS_ASSUME_NONNULL_BEGIN

@interface BPKButton()

@property(readonly, nonatomic) BPKGradientLayer *gradientLayer;

@end

@implementation BPKButton

- (instancetype)initWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithSize:size
                      style:style
              imagePosition:BPKButtonImagePositionTrailing];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithSize:BPKButtonSizeDefault
                      style:BPKButtonStylePrimary
              imagePosition:BPKButtonImagePositionTrailing];
    }

    return self;
}

- (void)setupWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style
        imagePosition:(BPKButtonImagePosition)imagePosition {
    [self setClipsToBounds:YES];
    [self setAdjustsImageWhenHighlighted:NO];
    [self setAdjustsImageWhenDisabled:NO];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.size = size;
    self.style = style;
    self.imagePosition = imagePosition;
}

- (UIButtonType)buttonType {
    return UIButtonTypeCustom;
}

#pragma mark - Gradient

+ (Class)layerClass {
    return [BPKGradientLayer class];
}

- (BPKGradientLayer *)gradientLayer {
    return (BPKGradientLayer *)self.layer;
}

#pragma mark - Style setters

- (void)setSize:(BPKButtonSize)size {
    _size = size;
    [self didChangeProperty];
}

- (void)setImagePosition:(BPKButtonImagePosition)imagePosition {
    _imagePosition = imagePosition;
    [self didChangeProperty];
}

- (void)setStyle:(BPKButtonStyle)style {
    _style = style;
    [self didChangeProperty];
}

#pragma mark - State setters

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    [self didChangeProperty];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    [self didChangeProperty];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [self didChangeProperty];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setCornerRadius];
    [self layoutLabelAndImage];
}

- (void)setCornerRadius {
    CGFloat radius = CGRectGetHeight(self.bounds) / 2.0f;
    [self.layer setCornerRadius:radius];
}

- (void)layoutLabelAndImage {
    switch (self.imagePosition) {
        case BPKButtonImagePositionLeading: {
            [self layoutViewsNextToEachOther:@[self.imageView, self.titleLabel]];
            break;
        }
        case BPKButtonImagePositionTrailing: {
            [self layoutViewsNextToEachOther:@[self.titleLabel, self.imageView]];
            break;
        }
        default: {
            NSAssert(NO, @"Invalid position %d", (int)self.imagePosition);
            break;
        }
    }
}

- (void)layoutViewsNextToEachOther:(NSArray *)views {
    CGFloat height = self.intrinsicContentSize.height;
    
    CGFloat x = self.horizontalPadding;
    for (UIView *view in views) {
        CGSize size = view.intrinsicContentSize;
        [view setFrame:CGRectMake(x, (height - size.height) / 2.0f, size.width, size.height)];
        x = CGRectGetMaxX(view.frame) + self.spacing;
    }
}

- (CGSize)intrinsicContentSize {
    CGSize titleSize = self.titleLabel.intrinsicContentSize;
    CGSize imageSize = self.imageView.intrinsicContentSize;
    CGFloat width = self.horizontalPadding + titleSize.width + self.spacing + imageSize.width + self.horizontalPadding;
    CGFloat height = self.verticalPadding + MAX(titleSize.height, imageSize.height) + self.verticalPadding;
    return CGSizeMake(width, height);
}

#pragma mark Spacing

- (CGFloat)spacing {
    BOOL hasImage = self.imageView.image != nil;
    BOOL hasText = self.titleLabel.text.length > 0;
    return hasImage && hasText ? 8.0f : 0.0f;
}

- (CGFloat)horizontalPadding {
    if (self.style == BPKButtonStyleLink) {
        return 0.0f;
    }
    
    BOOL hasText = self.titleLabel.text.length > 0;
    CGFloat multiplier = hasText ? 1.5f : 1.0f;
    switch (self.size) {
        case BPKButtonSizeDefault: return 8.0f * multiplier;
        case BPKButtonSizeLarge: return 14.0f * multiplier;
        default: {
            NSAssert(NO, @"Invalid size %d", (int)self.size);
            break;
        }
    }
}

- (CGFloat)verticalPadding {
    if (self.style == BPKButtonStyleLink) {
        return 0.0f;
    }
    
    switch (self.size) {
        case BPKButtonSizeDefault: return 8.0f;
        case BPKButtonSizeLarge: return 14.0f;
        default: {
            NSAssert(NO, @"Invalid size %d", (int)self.size);
            break;
        }
    }
}

#pragma mark - State change

- (void)didChangeProperty {
    [self setColors];
    [self setFont];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)setColors {
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
                break;
            }
            case BPKButtonStyleDestructive: {
                [self setBorderedStyleWithColor:BPKColor.red500];
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
}

- (void)setFont {
    switch (self.size) {
        case BPKButtonSizeDefault: {
            [self.titleLabel setFont:BPKFont.textBaseEmphasized];
            break;
        }
        case BPKButtonSizeLarge: {
            [self.titleLabel setFont:BPKFont.textLgEmphasized];
            break;
        }
        default: {
            NSAssert(NO, @"Invalid size %d", (int)self.size);
            break;
        }
    }
}

#pragma mark - Helpers

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
    [self setContentColor:BPKColor.white];
    
    [self.layer setBorderColor:BPKColor.clear.CGColor];
    [self.layer setBorderWidth:0];
}

- (void)setBorderedStyleWithColor:(UIColor *)color {
    self.gradientLayer.gradient = [self gradientWithSingleColor:BPKColor.white];
    [self setContentColor:color];
    
    UIColor *borderColor = self.isHighlighted || self.isSelected ? color : BPKColor.gray100;
    [self.layer setBorderColor:borderColor.CGColor];
    [self.layer setBorderWidth:self.isSelected ? 4 : 2];
}

- (void)setLinkStyleWithColor:(UIColor *)color {
    self.gradientLayer.gradient = [self gradientWithSingleColor:BPKColor.white];
    [self setContentColor:color];
    
    [self.layer setBorderColor:BPKColor.clear.CGColor];
    [self.layer setBorderWidth:0];
}

- (void)setContentColor:(UIColor *)color {
    [self setTintColor:color];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (void)setDisabledStyle {
    UIColor *backgroundColor = self.style == BPKButtonStyleLink ? BPKColor.white : BPKColor.gray100;
    self.gradientLayer.gradient = [self gradientWithSingleColor:backgroundColor];
    [self setTintColor:BPKColor.gray300];
    [self setTitleColor:BPKColor.gray300 forState:UIControlStateDisabled];
    self.layer.borderColor = BPKColor.clear.CGColor;
    self.layer.borderWidth = 0;
}

@end

NS_ASSUME_NONNULL_END
