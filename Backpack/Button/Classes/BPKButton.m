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
#import <Backpack/BPKGradientView.h>
#import <Backpack/BPKGradient.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKButton()

@end

@implementation BPKButton {
    BPKGradientView *_backgroundView;
}

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
    
    _backgroundView = [[BPKGradientView alloc] initWithGradient:[self gradientWithTopColor:BPKColor.clear bottomColor:BPKColor.clear]];
    [_backgroundView setUserInteractionEnabled:NO];
    [self insertSubview:_backgroundView atIndex:0];
    
    self.size = size;
    self.stlye = style;
    self.imagePosition = imagePosition;
}

- (UIButtonType)buttonType {
    return UIButtonTypeCustom;
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
    [self layoutGradientBackground];
    [self layoutLabelAndImage];
}

- (void)setCornerRadius {
    CGFloat radius = CGRectGetHeight(self.bounds) / 2.0;
    [self.layer setCornerRadius:radius];
}

- (void)layoutGradientBackground {
    [_backgroundView setFrame:self.bounds];
    [self sendSubviewToBack:_backgroundView];
}

- (void)layoutLabelAndImage {
    CGFloat height = self.intrinsicContentSize.height;
    CGSize titleSize = self.titleLabel.intrinsicContentSize;
    CGSize imageSize = self.imageView.intrinsicContentSize;
    
    switch (self.imagePosition) {
        case BPKButtonImagePositionLeft: {
            [self.imageView setFrame:CGRectMake(self.horizontalPadding,
                                                (height - imageSize.height) / 2.0,
                                                imageSize.width,
                                                imageSize.height)];
            [self.titleLabel setFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame) + self.spacing,
                                                 (height - titleSize.height) / 2.0,
                                                 titleSize.width,
                                                 titleSize.height)];
            break;
        }
        case BPKButtonImagePositionRight: {
            [self.titleLabel setFrame:CGRectMake(self.horizontalPadding,
                                                 (height - titleSize.height) / 2.0,
                                                 titleSize.width,
                                                 titleSize.height)];
            [self.imageView setFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + self.spacing,
                                                (height - imageSize.height) / 2.0,
                                                imageSize.width,
                                                imageSize.height)];
            break;
        }
        default: {
            NSAssert(NO, @"Invalid position %d", (int)self.imagePosition);
            break;
        }
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
    switch (self.stlye) {
        case BPKButtonStylePrimary: {
            if (self.isHighlighted) {
                _backgroundView.gradient = [self gradientWithTopColor:BPKColor.green600 bottomColor:BPKColor.green600];
            } else if (self.isSelected) {
                _backgroundView.gradient = [self gradientWithTopColor:BPKColor.green700 bottomColor:BPKColor.green700];
            } else {
                _backgroundView.gradient = [self gradientWithTopColor:BPKColor.green500 bottomColor:BPKColor.green600];
            }
            [self setTintColor:BPKColor.white];
            [self setTitleColor:BPKColor.white forState:UIControlStateNormal];
            [self setTitleColor:BPKColor.white forState:UIControlStateHighlighted];
            [self setTitleColor:BPKColor.white forState:UIControlStateSelected];
            [self.layer setBorderColor:BPKColor.clear.CGColor];
            [self.layer setBorderWidth:0];
            break;
        }
        case BPKButtonStyleSecondary: {
            _backgroundView.gradient = [self gradientWithTopColor:BPKColor.white bottomColor:BPKColor.white];
            [self setTintColor:BPKColor.blue500];
            [self setTitleColor:BPKColor.blue500 forState:UIControlStateNormal];
            [self setTitleColor:BPKColor.blue500 forState:UIControlStateHighlighted];
            [self setTitleColor:BPKColor.blue500 forState:UIControlStateSelected];
            if (self.isSelected || self.isHighlighted) {
                [self.layer setBorderColor:BPKColor.blue500.CGColor];
            } else {
                [self.layer setBorderColor:BPKColor.gray50.CGColor];
            }
            [self.layer setBorderWidth:2];
            break;
        }
        case BPKButtonStyleDestructive: {
            _backgroundView.gradient = [self gradientWithTopColor:BPKColor.white bottomColor:BPKColor.white];
            [self setTintColor:BPKColor.red500];
            [self setTitleColor:BPKColor.red500 forState:UIControlStateNormal];
            [self setTitleColor:BPKColor.red500 forState:UIControlStateHighlighted];
            [self setTitleColor:BPKColor.red500 forState:UIControlStateSelected];
            if (self.isSelected || self.isHighlighted) {
                [self.layer setBorderColor:BPKColor.red500.CGColor];
            } else {
                [self.layer setBorderColor:BPKColor.gray50.CGColor];
            }
            [self.layer setBorderWidth:2];
            break;
        }
        case BPKButtonStyleFeatured: {
            if (self.isHighlighted) {
                _backgroundView.gradient = [self gradientWithTopColor:BPKColor.pink600 bottomColor:BPKColor.pink600];
            } else if (self.isSelected) {
                _backgroundView.gradient = [self gradientWithTopColor:BPKColor.pink700 bottomColor:BPKColor.pink700];
            } else {
                _backgroundView.gradient = [self gradientWithTopColor:BPKColor.pink500 bottomColor:BPKColor.pink600];
            }
            [self setTintColor:BPKColor.white];
            [self setTitleColor:BPKColor.white forState:UIControlStateNormal];
            [self setTitleColor:BPKColor.white forState:UIControlStateHighlighted];
            [self setTitleColor:BPKColor.white forState:UIControlStateSelected];
            [self.layer setBorderColor:BPKColor.clear.CGColor];
            [self.layer setBorderWidth:0];
            break;
        }
        default: {
            NSAssert(NO, @"Invalid style value %d", (int)self.stlye);
            break;
        }
    }
    
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
    
    if (!self.isEnabled) {
        _backgroundView.gradient = [self gradientWithTopColor:BPKColor.gray100 bottomColor:BPKColor.gray100];
        [self setTintColor:BPKColor.gray300];
        [self setTitleColor:BPKColor.gray300 forState:UIControlStateDisabled];
        self.layer.borderColor = BPKColor.clear.CGColor;
        self.layer.borderWidth = 0;
    }
    
    [self setNeedsLayout];
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

@end

NS_ASSUME_NONNULL_END
