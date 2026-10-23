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

#import "BPKObjcUIKitSwitch.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKObjcUIKitSwitch ()

@property(nonatomic, assign) BPKSwitchStyle switchStyle;

@end

@implementation BPKObjcUIKitSwitch

- (instancetype)initWithCoder:(NSCoder *)coder {
    BPKAssertMainThread();
    self = [super initWithCoder:coder];
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

- (void)setPrimaryColor:(UIColor *_Nullable)primaryColor {
    if (_primaryColor != primaryColor) {
        _primaryColor = primaryColor;

        [self updateSwitchOnColor];
    }
}

- (void)updateSwitchOnColor {
    self.onTintColor = _primaryColor != nil ? _primaryColor : BPKColor.coreAccentColor;
}

- (instancetype)initWithStyle:(BPKSwitchStyle)style {
    BPKAssertMainThread();
    self = [self initWithFrame:CGRectZero];
    if (self) {
        _switchStyle = style;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.tintColor = BPKColor.surfaceHighlightColor;
    self.thumbTintColor = BPKColor.textOnDarkColor;

    [self updateSwitchOnColor];
    [self updateOffTintColor];
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateOffTintColor];
}

- (void)updateOffTintColor {
    if (self.switchStyle == BPKSwitchStyleOnContrast) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        self.layer.cornerRadius = self.bounds.size.height / 2.0;
        self.clipsToBounds = YES;
    } else {
        self.backgroundColor = nil;
        self.tintColor = BPKColor.surfaceHighlightColor;
    }
}

@end

NS_ASSUME_NONNULL_END
