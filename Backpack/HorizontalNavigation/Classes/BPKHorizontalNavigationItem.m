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
#import "BPKTextDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKHorizontalNavigationItem ()

@property(readonly) UIColor *contentColor;
@property(nonatomic, strong) UIImage *iconImage;
@property(nonatomic) double spacing;

@end

@implementation BPKHorizontalNavigationItem

- (instancetype)initWithDefinition:(BPKHorizontalNavigationOption *)definition {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        _definition = definition;
        [self setupWithDefinition:definition];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithDefinition:nil];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithDefinition:nil];
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
                                                                     content:self.definition.name
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
    if (self.iconImage != nil) {
        [self updateIconStyle];
    }
}

- (void)updateIconStyle {
    BPKIconSize size = self.size == BPKHorizontalNavigationSizeDefault ? BPKIconSizeLarge : BPKIconSizeSmall;

    if (self.definition.iconName == nil) {
        [self setImage:nil forState:UIControlStateNormal];
    } else {
        self.iconImage = [BPKIcon iconNamed:self.definition.iconName color:self.contentColor size:size];
        [self setImage:self.iconImage forState:UIControlStateNormal];
    }

    [self updateInsets];
}

- (void)updateInsets {
    if (self.iconImage == nil) {
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
    if (self.definition.iconName) {
        CGFloat iconWidth = self.iconImage.size.width;
        CGFloat width = textButtonIntrinsicContentSize.width + iconWidth + 2 * self.spacing;
        CGFloat height = textButtonIntrinsicContentSize.height;
        return CGSizeMake(width, height);
    } else {
        CGFloat width = textButtonIntrinsicContentSize.width + 2 * self.spacing;
        CGFloat height = textButtonIntrinsicContentSize.height;
        return CGSizeMake(width, height);
    }
}

- (void)setupWithDefinition:(BPKHorizontalNavigationOption *_Nullable)definition {
    [self updateStyle];
    [self updateIconStyle];
}

- (double)spacing {
    return self.size == BPKHorizontalNavigationSizeSmall ? BPKSpacingBase : BPKSpacingLg;
}

@end
NS_ASSUME_NONNULL_END
