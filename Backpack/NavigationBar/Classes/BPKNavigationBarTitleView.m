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
#import "BPKNavigationBarTitleView.h"

#import <Backpack/Common.h>
#import <Backpack/Label.h>

const CGFloat BPKNavigationBarTitleHeight = 44;

NS_ASSUME_NONNULL_BEGIN

@implementation BPKNavigationBarTitleView
@synthesize titleLabel = _titleLabel;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        _showsContent = NO;
        [self setUp];
    }

    return self;
}

- (void)setShowsContent:(BOOL)showsContent {
    BPKAssertMainThread();

    if (_showsContent != showsContent) {
        _showsContent = showsContent;

        [UIView animateWithDuration:.15
                         animations:^{
                           self.titleLabel.alpha = self.showsContent ? 1.0 : 0.0;
                         }];
    }
}

#pragma mark - Private

- (BPKLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextHeading5];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.accessibilityTraits = UIAccessibilityTraitHeader;
    }

    return _titleLabel;
}

- (void)setUp {
    _showsContent = NO;
    [self addSubview:self.titleLabel];

    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.titleLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.4],
    ]];
    _titleLabel.alpha = 0.0;
}

@end

NS_ASSUME_NONNULL_END
