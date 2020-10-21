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

#import "BPKBackgroundView.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Duration.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKBackgroundView ()

@property(nonatomic, strong) CALayer *tintLayer;

@end

@implementation BPKBackgroundView

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithOverlayType:BPKOverlayViewOverlayTypeTint];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithOverlayType:BPKOverlayViewOverlayTypeTint];
    }

    return self;
}

- (nullable instancetype)initWithOverlayType:(BPKOverlayViewOverlayType)overlayType {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithOverlayType:overlayType];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.tintLayer.frame = self.bounds;
}

#pragma mark - Private

- (void)setupWithOverlayType:(BPKOverlayViewOverlayType)overlayType {
    self.tintLayer = [CALayer layer];
    self.tintLayer.backgroundColor = BPKColor.skyBlueShade03.CGColor;
    self.tintLayer.zPosition = 1;
    [self.layer addSublayer:self.tintLayer];

    self.overlayType = overlayType;
    [self updateTintAppearance];
}

#pragma mark - setters

- (void)setOverlayType:(BPKOverlayViewOverlayType)overlayType {
    BPKAssertMainThread();
    if (_overlayType == overlayType) {
        return;
    }

    _overlayType = overlayType;

    [self updateTintAppearance];
}

#pragma mark - helpers

- (void)updateTintAppearance {
    CGFloat newOpacity = 0;
    if (self.overlayType == BPKOverlayViewOverlayTypeTint) {
        newOpacity = 0.56;
    }

    [CATransaction begin];
    [CATransaction setAnimationDuration:BPKDuration.animationDurationSm];
    self.tintLayer.opacity = newOpacity;
    [CATransaction commit];
}

@end
NS_ASSUME_NONNULL_END
