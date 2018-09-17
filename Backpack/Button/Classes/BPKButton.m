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
#import <Backpack/Color.h>
#import <Backpack/BPKGradientLayer.h>
#import <Backpack/BPKGradient.h>

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
              imagePosition:BPKButtonImagePositionRight];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithSize:BPKButtonSizeDefault
                      style:BPKButtonStylePrimary
              imagePosition:BPKButtonImagePositionRight];
    }

    return self;
}

- (void)setupWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style imagePosition:(BPKButtonImagePosition)imagePosition {
    [self setClipsToBounds:YES];
    [self setAdjustsImageWhenHighlighted:NO];
    [self setAdjustsImageWhenDisabled:NO];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.size = size;
    self.stlye = style;
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

- (void)setGradient:(BPKGradient *)gradient {
    self.gradientLayer.gradient = gradient;
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

- (void)setStlye:(BPKButtonStyle)stlye {
    _stlye = stlye;
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
    CGFloat radius = CGRectGetHeight(self.bounds) / 2.0;
    [self.layer setCornerRadius:radius];
}

- (void)layoutLabelAndImage {
    
    switch (self.imagePosition) {
        case BPKButtonImagePositionLeft: {
            [self layoutViewsNextToEachOther:@[self.imageView, self.titleLabel]];
            break;
        }
        case BPKButtonImagePositionRight: {
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
        [view setFrame:CGRectMake(x, (height - size.height) / 2.0, size.width, size.height)];
        x = CGRectGetMaxX(view.frame) + self.spacing;
    }
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(self.titleLabel.intrinsicContentSize.width + self.spacing + self.imageView.intrinsicContentSize.width + 2 * self.horizontalPadding,
                      MAX(self.titleLabel.intrinsicContentSize.height, self.imageView.intrinsicContentSize.height) + 2 * self.verticalPadding);
}

#pragma mark Spacing

- (CGFloat)spacing {
    BOOL hasImage = self.imageView.image != nil;
    BOOL hasText = self.titleLabel.text.length > 0;
    return hasImage && hasText ? 8 : 0;
}

- (CGFloat)horizontalPadding {
    BOOL hasText = self.titleLabel.text.length > 0;
    CGFloat multiplier = hasText ? 1.5 : 1;
    switch (self.size) {
        case BPKButtonSizeDefault: return 8 * multiplier;
        case BPKButtonSizeLarge: return 14 * multiplier;
        default: {
            NSAssert(NO, @"Invalid size %d", (int)self.size);
            break;
        }
    }
}

- (CGFloat)verticalPadding {
    switch (self.size) {
        case BPKButtonSizeDefault: return 8;
        case BPKButtonSizeLarge: return 14;
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
    [self setNeedsLayout];
}

- (void)setColors {
    if (self.isEnabled) {
        switch (self.stlye) {
            case BPKButtonStylePrimary: {
                [self setFilledStyleWithNormalBackgroundColorGradientTop:BPKColor.green500 gradientBottom:BPKColor.green600 selectedColor:BPKColor.green700];
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
                [self setFilledStyleWithNormalBackgroundColorGradientTop:BPKColor.pink500 gradientBottom:BPKColor.pink600 selectedColor:BPKColor.pink700];
                break;
            }
            default: {
                NSAssert(NO, @"Invalid style value %d", (int)self.stlye);
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

- (BPKGradient *)gradientWithTopColor:(UIColor *)top bottomColor:(UIColor *)bottom {
    NSParameterAssert(top);
    NSParameterAssert(bottom);
    
    BPKGradientDirection direction = BPKGradientDirectionDown;
    return [[BPKGradient alloc] initWithColors:@[top, bottom]
                                    startPoint:[BPKGradient startPointForDirection:direction]
                                      endPoint:[BPKGradient endPointForDirection:direction]];
}

- (void)setFilledStyleWithNormalBackgroundColorGradientTop:(UIColor *)normalColorTop gradientBottom:(UIColor *)normalColorBottom selectedColor:(UIColor *)selectedColor {
    if (self.isHighlighted) {
        self.gradient = [self gradientWithTopColor:normalColorBottom bottomColor:normalColorBottom];
    } else if (self.isSelected) {
        self.gradient = [self gradientWithTopColor:selectedColor bottomColor:selectedColor];
    } else {
        self.gradient = [self gradientWithTopColor:normalColorTop bottomColor:normalColorBottom];
    }
    [self setTintColor:BPKColor.white];
    [self setTitleColor:BPKColor.white forState:UIControlStateNormal];
    [self setTitleColor:BPKColor.white forState:UIControlStateHighlighted];
    [self setTitleColor:BPKColor.white forState:UIControlStateSelected];
    [self.layer setBorderColor:BPKColor.clear.CGColor];
    [self.layer setBorderWidth:0];
}

- (void)setBorderedStyleWithColor:(UIColor *)color {
    self.gradient = [self gradientWithTopColor:BPKColor.white bottomColor:BPKColor.white];
    [self setTintColor:color];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateSelected];
    if (self.isHighlighted) {
        [self.layer setBorderColor:color.CGColor];
        [self.layer setBorderWidth:2];
    } else if (self.isSelected) {
        [self.layer setBorderColor:color.CGColor];
        [self.layer setBorderWidth:4];
    } else {
        [self.layer setBorderColor:BPKColor.gray100.CGColor];
        [self.layer setBorderWidth:2];
    }
}

- (void)setDisabledStyle {
    self.gradient = [self gradientWithTopColor:BPKColor.gray100 bottomColor:BPKColor.gray100];
    [self setTintColor:BPKColor.gray300];
    [self setTitleColor:BPKColor.gray300 forState:UIControlStateDisabled];
    self.layer.borderColor = BPKColor.clear.CGColor;
    self.layer.borderWidth = 0;
}

@end

NS_ASSUME_NONNULL_END
