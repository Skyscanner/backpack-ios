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

#import "BPKFlareView.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Spacing.h>

#import "BPKFlarePath.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKFlareView ()
@property(nonatomic, strong) NSLayoutConstraint *contentViewBottomConstraint;
@end

@implementation BPKFlareView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
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

- (void)layoutSubviews {
    [super layoutSubviews];

    [self createLayerMask];
}

#pragma mark - Private

- (void)createLayerMask {
    CAShapeLayer *flareView = [[CAShapeLayer alloc] init];
    flareView.fillRule = kCAFillRuleNonZero;

    CGSize currentSize = self.bounds.size;

    UIBezierPath *flarePath = [BPKFlarePath flareViewPathForSize:currentSize];

    flareView.path = flarePath.CGPath;

    self.layer.mask = flareView;
}

- (void)setup {
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.backgroundView];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;

    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.contentView];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

    self.contentViewBottomConstraint = [self.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor
                                                                         constant:BPKFlareHeight];

    [NSLayoutConstraint activateConstraints:@[
        [self.backgroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.trailingAnchor constraintEqualToAnchor:self.backgroundView.trailingAnchor],
        [self.bottomAnchor constraintEqualToAnchor:self.backgroundView.bottomAnchor],
    ]];

    [NSLayoutConstraint activateConstraints:@[
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor], self.contentViewBottomConstraint
    ]];

    [self createLayerMask];
}

@end
NS_ASSUME_NONNULL_END
