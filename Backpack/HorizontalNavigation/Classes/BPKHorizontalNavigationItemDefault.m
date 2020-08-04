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

#import "BPKHorizontalNavigationItemDefault.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/DarkMode.h>
#import <Backpack/RTLSupport.h>
#import <Backpack/Spacing.h>

#import "BPKHorizontalNavigationOption.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKHorizontalNavigationItemDefault ()

@property(readonly) UIColor *contentColor;
@property(nonatomic) CGFloat horizontalSpacing;
@property(nonatomic) CGFloat verticalSpacing;
@property(nonatomic, readonly) UIView *notificationDot;

@end

@implementation BPKHorizontalNavigationItemDefault

- (instancetype)initWithName:(NSString *)name iconName:(BPKIconName)iconName {
    self = [self initWithName:name iconName:iconName showNotificationDot:NO];

    return self;
}

- (instancetype)initWithName:(NSString *)name iconName:(BPKIconName)iconName showNotificationDot:(BOOL)showDot {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.name = name;
        self.iconName = iconName;
        [self setup];

        if (showDot) {
            [self setupNotificationDot];
        }
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

- (void)setAppearance:(BPKHorizontalNavigationAppearance)appearance {
    if (_appearance != appearance) {
        _appearance = appearance;

        [self updateStyle];
    }
}

#pragma mark - Private

- (void)updateStyle {
    BPKFontStyle fontStyle = BPKFontStyleTextBaseEmphasized;
    if (self.size == BPKHorizontalNavigationSizeSmall) {
        fontStyle = BPKFontStyleTextSmEmphasized;
    }

    NSAttributedString *titleString = [BPKFont attributedStringWithFontStyle:fontStyle
                                                                     content:self.name
                                                                   textColor:self.contentColor];
    [self setAttributedTitle:titleString forState:UIControlStateNormal];

    [self updateInsets];
    [self setIconColor];
}

- (UIColor *)contentColor {
    if (self.selected) {
        if (self.selectedColor != nil) {
            return self.selectedColor;
        }
        return BPKColor.primaryColor;
    } else {
        switch (self.appearance) {
            case BPKHorizontalNavigationAppearanceNormal:
                return BPKColor.textPrimaryColor;
                break;
            case BPKHorizontalNavigationAppearanceAlternate:
                return BPKColor.skyGrayTint07;
        }
    }
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
        self.titleEdgeInsets = UIEdgeInsetsMake(self.verticalSpacing, self.horizontalSpacing, self.verticalSpacing,
                                                self.horizontalSpacing);
        return;
    }

    CGFloat horizontalInset = self.horizontalSpacing / 2.0;

    if ([BPKRTLSupport viewIsRTL:self]) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, horizontalInset, 0, 0);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, horizontalInset);
    } else {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, horizontalInset);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, horizontalInset, 0, 0);
    }
}

- (CGSize)intrinsicContentSize {
    CGSize buttonIntrinsicContentSize = [super intrinsicContentSize];
    if (self.iconName) {
        CGFloat iconHeight = self.currentImage.size.height;
        CGFloat width = buttonIntrinsicContentSize.width + 3 * self.horizontalSpacing;
        CGFloat height = iconHeight + self.verticalSpacing / 2;
        return CGSizeMake(width, height);
    } else {
        CGFloat width = buttonIntrinsicContentSize.width + 2 * self.horizontalSpacing;
        CGFloat height = buttonIntrinsicContentSize.height;
        return CGSizeMake(width, height);
    }
}

- (void)setup {
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self updateStyle];
    [self updateIconStyle];
}

- (CGFloat)verticalSpacing {
    return self.size == BPKHorizontalNavigationSizeSmall ? BPKSpacingBase : BPKSpacingLg;
}

- (CGFloat)horizontalSpacing {
    return BPKSpacingBase;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGPoint cordinates;
    if ([BPKRTLSupport viewIsRTL:self]) {
        cordinates = CGPointMake(CGRectGetMinX(self.titleLabel.frame) - BPKSpacingMd, CGRectGetMinY(self.titleLabel.frame) - BPKSpacingSm);
    } else {
        cordinates = CGPointMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame) - BPKSpacingSm);
    }

    self.notificationDot.frame = CGRectMake(cordinates.x, cordinates.y, BPKSpacingMd, BPKSpacingMd);
}

- (void)setupNotificationDot {
    if (_notificationDot == nil) {
        _notificationDot = [UIView new];
        _notificationDot.translatesAutoresizingMaskIntoConstraints = NO;
        _notificationDot.backgroundColor = BPKColor.systemRed;
        _notificationDot.layer.cornerRadius = BPKSpacingMd / 2;

        [self addSubview:_notificationDot];
    }
}

- (void)traitCollectionDidChange:(nullable UITraitCollection*)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle) {
            [self updateIconStyle];
        }
    }
#endif
}

@end
NS_ASSUME_NONNULL_END
