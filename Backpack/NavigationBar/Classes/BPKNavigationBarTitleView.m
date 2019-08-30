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

        if (_showsContent) {
            self.titleLabel.alpha = 1.0;
            self.backgroundColor = UIColor.clearColor;
        } else {
            self.titleLabel.alpha = 0.0;
            self.backgroundColor = UIColor.whiteColor;
        }
    }
}

#pragma mark - Private

- (BPKLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBaseEmphasized];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _titleLabel;
}

- (void)setUp {
    _showsContent = NO;
    [self addSubview:self.titleLabel];

    self.backgroundColor = UIColor.whiteColor;

    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.titleLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.4],
    ]];
    _titleLabel.alpha = 0.0;
}

@end

NS_ASSUME_NONNULL_END
