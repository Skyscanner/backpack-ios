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
    [self createLayerMask];
}

- (void)setIsFlareVisible:(BOOL)isFlareVisible {
    if (_isFlareVisible != isFlareVisible) {
        _isFlareVisible = isFlareVisible;

        [self createLayerMask];
        [self updateBottomConstraint];
    }
}

#pragma mark - Private

- (void)createLayerMask {
    if (!self.isFlareVisible) {
        self.layer.mask = nil;
        return;
    }

    CAShapeLayer *flareView = [[CAShapeLayer alloc] init];
    flareView.fillRule = kCAFillRuleNonZero;

    CGSize currentSize = self.bounds.size;

    UIBezierPath *flarePath = [BPKFlarePath flarePathForSize:currentSize];

    flareView.path = flarePath.CGPath;

    self.layer.mask = flareView;
}

- (void)updateBottomConstraint {
    [self.contentViewBottomConstraint setActive:NO];

    if (self.isFlareVisible) {
        self.contentViewBottomConstraint = [self.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor
                                                                             constant:BPKFlareHeight];
    } else {
        self.contentViewBottomConstraint = [self.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor];
    }

    [self.contentViewBottomConstraint setActive:YES];
}

- (void)setup {
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.contentView];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

    // ensure that the content view is shown above anything added to the main view:
    self.contentView.layer.zPosition = 1.0;

    self.contentViewBottomConstraint = [self.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor];

    [NSLayoutConstraint activateConstraints:@[
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor], self.contentViewBottomConstraint
    ]];

    [self createLayerMask];
}

@end
NS_ASSUME_NONNULL_END
