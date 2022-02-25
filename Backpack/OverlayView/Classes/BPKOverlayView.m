/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

#import "BPKOverlayView.h"

#import <Backpack/Common.h>
#import <Backpack/Radii.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKOverlayView ()

@property(nonatomic, strong, nullable) CALayer *tintLayer;

@end

@implementation BPKOverlayView

@synthesize foregroundView = _foregroundView;
@synthesize backgroundView = _backgroundView;

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithOverlayType:BPKOverlayViewOverlayTypeTint cornerStyle:BPKOverlayViewCornerStyleNone];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithOverlayType:BPKOverlayViewOverlayTypeTint cornerStyle:BPKOverlayViewCornerStyleNone];
    }

    return self;
}

- (nullable instancetype)initWithOverlayType:(BPKOverlayViewOverlayType)overlayType cornerStyle:(BPKOverlayViewCornerStyle)cornerStyle {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithOverlayType:overlayType cornerStyle:cornerStyle];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.tintLayer == nil) {
        return;
    }

    self.tintLayer.frame = self.bounds;
}

#pragma mark - Private

- (void)setupWithOverlayType:(BPKOverlayViewOverlayType)overlayType cornerStyle:(BPKOverlayViewCornerStyle)cornerStyle {
    self.overlayType = overlayType;
    self.cornerStyle = cornerStyle;
    self.layer.masksToBounds = YES;
}

#pragma mark - getters

- (UIView *)foregroundView {
    if (_foregroundView != nil) {
        return _foregroundView;
    }

    _foregroundView = [[UIView alloc] initWithFrame:CGRectZero];
    _foregroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_foregroundView];

    [NSLayoutConstraint activateConstraints:@[
        [_foregroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [_foregroundView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.trailingAnchor constraintEqualToAnchor:_foregroundView.trailingAnchor],
        [self.bottomAnchor constraintEqualToAnchor:_foregroundView.bottomAnchor]
    ]];

    return _foregroundView;
}

- (UIView *)backgroundView {
    if (_backgroundView != nil) {
        return _backgroundView;
    }

    _backgroundView = [[BPKOverlayBackgroundView alloc] initWithOverlayType:self.overlayType];
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self insertSubview:_backgroundView atIndex:0];

    [NSLayoutConstraint activateConstraints:@[
        [_backgroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [_backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.trailingAnchor constraintEqualToAnchor:_backgroundView.trailingAnchor],
        [self.bottomAnchor constraintEqualToAnchor:_backgroundView.bottomAnchor]
    ]];

    return _backgroundView;
}

#pragma mark - setters

- (void)setCornerStyle:(BPKOverlayViewCornerStyle)cornerStyle {
    BPKAssertMainThread();
    if (_cornerStyle != cornerStyle) {
        _cornerStyle = cornerStyle;
        [self updateCorners];
    }
}

- (void)setOverlayType:(BPKOverlayViewOverlayType)overlayType {
    BPKAssertMainThread();
    if (_overlayType == overlayType) {
        return;
    }

    _overlayType = overlayType;

    // We don't use the getter here as we don't want to create the background view
    if (_backgroundView != nil) {
        _backgroundView.overlayType = overlayType;
    }
}

#pragma mark - helpers

- (void)updateCorners {
    CGFloat cornerRadius = 0;

    switch (self.cornerStyle) {
    case BPKOverlayViewCornerStyleSmall:
        cornerRadius = BPKCornerRadiusMd;
        break;
    case BPKOverlayViewCornerStyleLarge:
        cornerRadius = BPKCornerRadiusLg;
        break;
    default:
        NSAssert(NO, @"Unknown BPKOverlayViewCornerStyle %d", (int)self.cornerStyle);
        break;
    }

    self.layer.cornerRadius = cornerRadius;
}

@end
NS_ASSUME_NONNULL_END
