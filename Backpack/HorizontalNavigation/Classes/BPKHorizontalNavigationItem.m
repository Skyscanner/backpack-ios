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

#import "BPKHorizontalNavigationItem.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/RTLSupport.h>
#import <Backpack/Spacing.h>

#import "BPKHorizontalNavigationOption.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKHorizontalNavigationItem ()

@property(readonly) UIColor *contentColor;
@property(nonatomic) double spacing;

@end

@implementation BPKHorizontalNavigationItem

- (instancetype)initWithName:(NSString *)name iconName:(BPKIconName)iconName {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.name = name;
        self.iconName = iconName;
        [self setup];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setup];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setup];
    }

    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    [self updateStyle];
}

- (void)setFontMapping:(BPKFontMapping *)fontMapping {
    if (_fontMapping != fontMapping) {
        _fontMapping = fontMapping;

        [self updateStyle];
    }
}

- (void)setSelectedColor:(UIColor *_Nullable)selectedColor {
    if (_selectedColor != selectedColor) {
        _selectedColor = selectedColor;

        [self updateStyle];
    }
}

- (void)setSize:(BPKHorizontalNavigationSize)size {
    if (_size != size) {
        _size = size;

        [self updateStyle];
        [self updateIconStyle];
    }
}

#pragma mark - Private

- (void)updateStyle {
    BPKFontStyle fontStyle = BPKFontStyleTextBase;
    if (self.size == BPKHorizontalNavigationSizeSmall) {
        fontStyle = BPKFontStyleTextSm;
    }

    NSAttributedString *titleString = [BPKFont attributedStringWithFontStyle:fontStyle
                                                                     content:self.name
                                                                   textColor:self.contentColor
                                                                 fontMapping:self.fontMapping];
    [self setAttributedTitle:titleString forState:UIControlStateNormal];

    [self updateInsets];
    [self setIconColor];
}

- (UIColor *)contentColor {
    if (self.selected) {
        if (self.selectedColor != nil) {
            return self.selectedColor;
        }
        return BPKColor.blue500;
    }
    return BPKColor.gray300;
}

- (void)setIconColor {
    [self updateIconStyle];
}

- (void)updateIconStyle {
    BPKIconSize size = self.size == BPKHorizontalNavigationSizeDefault ? BPKIconSizeLarge : BPKIconSizeSmall;

    if (self.iconName == nil) {
        [self setImage:nil forState:UIControlStateNormal];
    } else {
        UIImage *iconImage = [BPKIcon iconNamed:self.iconName color:self.contentColor size:size];
        [self setImage:iconImage forState:UIControlStateNormal];
        self.adjustsImageWhenHighlighted = NO;
    }

    [self updateInsets];
}

- (void)updateInsets {
    if (self.iconName == nil) {
        self.titleEdgeInsets = UIEdgeInsetsMake(self.spacing, self.spacing, self.spacing, self.spacing);
        return;
    }

    CGFloat insetAmount = self.spacing / 2.0;

    if ([BPKRTLSupport viewIsRTL:self]) {
        self.imageEdgeInsets = UIEdgeInsetsMake(self.spacing, insetAmount, self.spacing, 0);
        self.titleEdgeInsets = UIEdgeInsetsMake(self.spacing, 0, self.spacing, insetAmount);
        self.contentEdgeInsets = UIEdgeInsetsMake(insetAmount, insetAmount, insetAmount, insetAmount);
    } else {
        self.imageEdgeInsets = UIEdgeInsetsMake(self.spacing, 0, self.spacing, insetAmount);
        self.titleEdgeInsets = UIEdgeInsetsMake(self.spacing, insetAmount, self.spacing, 0);
        self.contentEdgeInsets = UIEdgeInsetsMake(insetAmount, insetAmount, insetAmount, insetAmount);
    }
}

- (CGSize)intrinsicContentSize {
    CGSize textButtonIntrinsicContentSize = [super intrinsicContentSize];
    if (self.iconName) {
        CGFloat iconWidth = self.currentImage.size.width;
        CGFloat width = textButtonIntrinsicContentSize.width + iconWidth + 2 * self.spacing;
        CGFloat height = textButtonIntrinsicContentSize.height;
        return CGSizeMake(width, height);
    } else {
        CGFloat width = textButtonIntrinsicContentSize.width + 2 * self.spacing;
        CGFloat height = textButtonIntrinsicContentSize.height;
        return CGSizeMake(width, height);
    }
}

- (void)setup {
    [self updateStyle];
    [self updateIconStyle];
}

- (double)spacing {
    return self.size == BPKHorizontalNavigationSizeSmall ? BPKSpacingBase : BPKSpacingLg;
}

@end
NS_ASSUME_NONNULL_END
