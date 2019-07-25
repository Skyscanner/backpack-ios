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
#import <Backpack/Spacing.h>

#import "BPKHorizontalNavigationOption.h"
#import "BPKTextDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKHorizontalNavigationItem ()

@property(readonly) UIColor *contentColor;
@property(nonatomic, strong) BPKIconView *iconView;

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
    if (self.iconView != nil) {
        self.iconView.tintColor = self.contentColor;
    }
}

- (void)updateIconStyle {
    if (self.iconView != nil) {
        [self.iconView removeFromSuperview];
    }

    if (self.definition.iconName == nil) {
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        return;
    }

    BPKIconSize size = self.size == BPKHorizontalNavigationSizeDefault ? BPKIconSizeLarge : BPKIconSizeSmall;
    self.iconView = [[BPKIconView alloc] initWithIconName:self.definition.iconName size:size];

    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:self.iconView];

    [NSLayoutConstraint activateConstraints:@[
        [self.iconView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.iconView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];

    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];

    [self setIconColor];
}

- (CGSize)intrinsicContentSize {
    CGSize textButtonIntrinsicContentSize = [super intrinsicContentSize];
    if (self.definition.iconName) {
        CGFloat iconWidth = [self.iconView intrinsicContentSize].width;
        CGFloat width = textButtonIntrinsicContentSize.width + iconWidth + BPKSpacingMd;
        CGFloat height = textButtonIntrinsicContentSize.height;
        return CGSizeMake(width, height);
    } else {
        return textButtonIntrinsicContentSize;
    }
}

- (void)setupWithDefinition:(BPKHorizontalNavigationOption *_Nullable)definition {
    [self updateStyle];
    [self updateIconStyle];
}

@end
NS_ASSUME_NONNULL_END
