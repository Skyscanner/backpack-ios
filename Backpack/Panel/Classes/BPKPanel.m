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
#import "BPKPanel.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Radii.h>
#import <Backpack/Shadow.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
const BOOL BPKPanelDefaultPaddedValue = YES;

@interface BPKPanel ()
@property(assign) UIEdgeInsets originalLayoutMargins;

- (void)setupWithPadded:(BOOL)padded;
@end

@implementation BPKPanel

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithPadded:BPKPanelDefaultPaddedValue];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithPadded:BPKPanelDefaultPaddedValue];
    }

    return self;
}

- (instancetype)initWithPadded:(BOOL)padded {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithPadded:padded];
    }

    return self;
}

- (void)setStyle:(BPKPanelStyle)style {
    if (_style != style) {
        _style = style;

        [self updatePanelAppearance];
    }
}

- (void)updatePanelAppearance {
    switch (self.style) {
    case BPKPanelStyleDefault:
        self.layer.borderColor = [BPKColor skyGrayTint06].CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.masksToBounds = YES;
        break;
    case BPKPanelStyleElevated:
        self.layer.borderWidth = 0.0;
        [BPKShadow.shadowSm applyToLayer:self.layer];
        self.layer.masksToBounds = NO;
        break;
    }
}

- (void)setPadded:(BOOL)padded {
    BPKAssertMainThread();
    if (padded) {
        self.layoutMargins = self.originalLayoutMargins;
    } else {
        self.layoutMargins = UIEdgeInsetsZero;
    }

    _padded = padded;
}

- (void)addSubview:(UIView *)view {
    BPKAssertMainThread();
    NSAssert(self.subviews.count == 0, @"BPKPanel can only have a single subview");
    if (self.subviews.count > 0) {
        return;
    }
    [super addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;

    [view.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor].active = YES;
    [view.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor].active = YES;
    [self.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.layoutMarginsGuide.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
}

#pragma mark - Private

- (void)setupWithPadded:(BOOL)padded {
    self.originalLayoutMargins = self.layoutMargins;
    self.padded = padded;
    self.style = BPKPanelStyleDefault;
    self.backgroundColor = BPKColor.backgroundTertiaryColor;
    self.layer.cornerRadius = BPKCornerRadiusMd;
    [self updatePanelAppearance];
}

@end
NS_ASSUME_NONNULL_END
