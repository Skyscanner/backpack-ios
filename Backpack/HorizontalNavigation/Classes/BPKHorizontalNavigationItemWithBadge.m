/*
* Backpack - Skyscanner's Design System
*
* Copyright © 2020 Skyscanner Ltd. All rights reserved.
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

#import "BPKHorizontalNavigationItemWithBadge.h"
#import "BPKHorizontalNavigationBadge.h"

#import <Backpack/BPKColor.h>
#import <Backpack/BPKLabel.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKHorizontalNavigationItemWithBadge ()
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) BPKHorizontalNavigationBadge *badge;
@property(nonatomic, strong) BPKLabel *titleLabel;
@property(nonatomic, strong, readonly) UIColor *contentColor;
@end

@implementation BPKHorizontalNavigationItemWithBadge

- (instancetype)initWithTitle:(NSString *)title badgeMessage:(NSString *)badgeMessage {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.badge.message = badgeMessage;
        self.titleLabel.text = title;
        [self setupSubViews];
    }

    return self;
}

- (void)setupSubViews {
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.badge];
    [self.containerView addSubview:self.titleLabel];
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:0],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.containerView.topAnchor],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor],
        [self.badge.leadingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:BPKSpacingMd],
        [self.badge.topAnchor constraintEqualToAnchor:self.containerView.topAnchor],
        [self.badge.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor],
        [self.containerView.trailingAnchor constraintEqualToAnchor:self.badge.trailingAnchor constant:0],
        [self.containerView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.containerView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.containerView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.leadingAnchor constant:BPKSpacingBase],
        [self.trailingAnchor constraintGreaterThanOrEqualToAnchor:self.containerView.trailingAnchor constant:BPKSpacingBase]
    ]];
}

- (void)updateStyle {
    BPKFontStyle fontStyle = BPKFontStyleTextBaseEmphasized;
    if (self.size == BPKHorizontalNavigationSizeSmall) {
        fontStyle = BPKFontStyleTextSmEmphasized;
    }

    self.titleLabel.fontStyle = fontStyle;
    self.titleLabel.textColor = self.contentColor;
    self.badge.color = self.contentColor;
}

#pragma mark - property getters/setters

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    [self updateStyle];
}

- (void)setSize:(BPKHorizontalNavigationSize)size {
    if (_size != size) {
        _size = size;

        [self updateStyle];
    }
}

- (void)setAppearance:(BPKHorizontalNavigationAppearance)appearance {
    if (_appearance != appearance) {
        _appearance = appearance;
        
        [self updateStyle];
    }
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

- (BPKLabel *)titleLabel {
    if (_titleLabel == nil) {
        BPKFontStyle fontStyle = BPKFontStyleTextBaseEmphasized;
        if (self.size == BPKHorizontalNavigationSizeSmall) {
            fontStyle = BPKFontStyleTextSmEmphasized;
        }

        _titleLabel = [[BPKLabel alloc] initWithFontStyle:fontStyle];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _titleLabel;
}

- (BPKHorizontalNavigationBadge *)badge {
    if (_badge == nil) {
        _badge = [[BPKHorizontalNavigationBadge alloc] initWithFrame:CGRectZero];
        _badge.userInteractionEnabled = NO;
        _badge.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _badge;
}

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [UIView new];
        _containerView.userInteractionEnabled = NO;
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _containerView;
}

@end
NS_ASSUME_NONNULL_END
