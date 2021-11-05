/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import "BPKBadge.h"

#import <Backpack/BorderWidth.h>
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Radii.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKBadge ()
@property(nonatomic, strong) BPKLabel *label;

- (void)setup;
@end

@implementation BPKBadge

- (instancetype)initWithMessage:(NSString *)message {
    BPKAssertMainThread();
    self = [self initWithType:BPKBadgeTypeSuccess message:message];

    return self;
}

- (instancetype)initWithType:(BPKBadgeType)type message:(NSString *)message {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setup];
        self.type = type;
        self.message = message;
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

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setup];
    }

    return self;
}

- (void)setType:(BPKBadgeType)type {
    BPKAssertMainThread();
    _type = type;

    self.layer.borderWidth = 0.0;
    switch (type) {
    case BPKBadgeTypeSuccess:
        self.backgroundColor = BPKColor.glencoe;
        break;
    case BPKBadgeTypeWarning:
        self.backgroundColor = BPKColor.erfoud;
        break;
    case BPKBadgeTypeDestructive:
        self.backgroundColor = BPKColor.panjin;
        break;
    case BPKBadgeTypeLight:
        self.backgroundColor = BPKColor.skyGrayTint07;
        break;
    case BPKBadgeTypeInverse:
        self.backgroundColor = BPKColor.white;
        break;
    case BPKBadgeTypeOutline:
        self.backgroundColor = [BPKColor.white colorWithAlphaComponent:0.2];
        self.layer.borderColor = BPKColor.white.CGColor;
        self.layer.borderWidth = BPKBorderWidthSm;
        break;
    default:
        break;
    }

    if (type == BPKBadgeTypeOutline || type == BPKBadgeTypeDestructive) {
        self.label.textColor = BPKColor.white;
    } else {
        self.label.textColor = BPKColor.skyGray;
    }
}

- (void)setMessage:(NSString *)message {
    BPKAssertMainThread();
    self.label.text = message;
}

- (NSString *)message {
    return self.label.text;
}

#pragma mark - Private

- (void)setup {
    BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextXsEmphasized];
    [self addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;

    [label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:BPKSpacingMd].active = YES;
    [self.trailingAnchor constraintEqualToAnchor:label.trailingAnchor constant:BPKSpacingMd].active = YES;
    [label.topAnchor constraintEqualToAnchor:self.topAnchor constant:BPKSpacingSm].active = YES;
    [self.bottomAnchor constraintEqualToAnchor:label.bottomAnchor constant:BPKSpacingSm].active = YES;
    self.label = label;

    self.type = BPKBadgeTypeSuccess;
    self.layer.cornerRadius = BPKCornerRadiusXs;
    self.layer.masksToBounds = YES;
}

- (void)changeContentColor:(UIColor *)color {
    if (self.type == BPKBadgeTypeOutline) {
        self.backgroundColor = BPKColor.clear;
        self.layer.borderColor = color.CGColor;
        self.label.textColor = color;
    }
}

@end
NS_ASSUME_NONNULL_END
