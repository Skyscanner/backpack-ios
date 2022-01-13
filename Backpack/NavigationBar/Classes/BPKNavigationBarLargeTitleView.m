/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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
#import "BPKNavigationBarLargeTitleView.h"

#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

const CGFloat BPKNavigationBarLargeTitleViewHeight = 52;

NS_ASSUME_NONNULL_BEGIN
@implementation BPKNavigationBarLargeTitleView
@synthesize titleLabel = _titleLabel;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setUp];
    }

    return self;
}

#pragma mark - Private

- (BPKLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextXxlEmphasized];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.titleLabel.accessibilityTraits = UIAccessibilityTraitHeader;
    }

    return _titleLabel;
}

- (void)setUp {
    [self addSubview:self.titleLabel];

    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintLessThanOrEqualToAnchor:self.topAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor],
        [self.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor],
        [self.bottomAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:BPKSpacingMd],
    ]];
}

@end
NS_ASSUME_NONNULL_END
