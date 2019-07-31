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

#import "BPKProgressBar.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKProgressBar

- (instancetype _Nullable)initWithCoder:(NSCoder *)aDecoder {
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

- (void)setFillColor:(UIColor *)fillColor {
    if (_fillColor != fillColor) {
        _fillColor = fillColor;

        self.progressTintColor = self.fillColor;
    }
}

- (void)setStyle:(BPKProgressBarStyle)style {
    if (_style != style) {
        _style = style;

        [self updateLayerStyles];
    }
}

#pragma mark - Overrides

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayerStyles];
}

- (void)setProgressTintColor:(UIColor *_Nullable)progressTintColor {
    [super setProgressTintColor:progressTintColor];

    // This gives a cleaner squared edge when the progress image would otherwise be stretched and deformed:
    self.subviews[1].backgroundColor = progressTintColor;
}

- (void)setTrackTintColor:(UIColor *_Nullable)trackTintColor {
    [super setTrackTintColor:trackTintColor];

    // This gives a cleaner squared edge when the track image would otherwise be stretched and deformed:
    self.backgroundColor = trackTintColor;
}

#pragma mark - Private

- (void)updateLayerStyles {
    if (self.style == BPKProgressBarStyleBar) {
        self.layer.cornerRadius = 0.0;
        self.subviews[1].layer.cornerRadius = 0.0;
    } else {
        self.layer.cornerRadius = self.bounds.size.height / 2;
        self.subviews[1].layer.cornerRadius = self.bounds.size.height / 2;
    }
}

- (void)setup {
    self.trackTintColor = BPKColor.gray100;
    self.progressTintColor = BPKColor.blue500;
    self.clipsToBounds = YES;
    self.subviews[1].clipsToBounds = YES;
    [self updateLayerStyles];
}

@end
NS_ASSUME_NONNULL_END
