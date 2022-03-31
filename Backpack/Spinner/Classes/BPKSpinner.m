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

#import "BPKSpinner.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKSpinner ()
@end

@implementation BPKSpinner

- (instancetype)initWithStyle:(BPKSpinnerStyle)style size:(BPKSpinnerSize)size {
    BPKAssertMainThread();
    self = [super initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    if (self) {
        [self setupWithStyle:style size:size];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    BPKAssertMainThread();
    self = [super initWithCoder:coder];
    if (self) {
        [self setupWithDefaultValues];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithDefaultValues];
    }
    return self;
}

- (void)setupWithDefaultValues {
    [self setupWithStyle:BPKSpinnerStylePrimary size:BPKSpinnerSizeDefault];
}

- (void)setupWithStyle:(BPKSpinnerStyle)style size:(BPKSpinnerSize)size {
    _style = style;
    _size = size;
    [self didChangeProperty];
}

- (void)setSize:(BPKSpinnerSize)size {
    BPKAssertMainThread();
    _size = size;
    [self didChangeProperty];
    [self setNeedsLayout];
}

- (void)setStyle:(BPKSpinnerStyle)style {
    BPKAssertMainThread();
    _style = style;
    [self didChangeProperty];
}

- (void)didChangeProperty {
    self.activityIndicatorViewStyle = [self.class styleForSpinnerSize:self.size];
    self.color = [self themeableColorForSpinnerStyle:self.style];
    [self setNeedsDisplay];
}

- (void)setPrimaryColor:(UIColor *_Nullable)primaryColor {
    if (primaryColor != _primaryColor) {
        _primaryColor = primaryColor;
        self.color = [self themeableColorForSpinnerStyle:self.style];
    }
}

- (UIColor *)themeableColorForSpinnerStyle:(BPKSpinnerStyle)style {
    if (style == BPKSpinnerStylePrimary && self.primaryColor != nil) {
        return self.primaryColor;
    }

    return [self.class colorForSpinnerStyle:self.style];
}

+ (UIActivityIndicatorViewStyle)styleForSpinnerSize:(BPKSpinnerSize)size {
    switch (size) {
    case BPKSpinnerSizeDefault:
        return UIActivityIndicatorViewStyleLarge;
    case BPKSpinnerSizeSmall:
        return UIActivityIndicatorViewStyleMedium;
    default:
        NSAssert(NO, @"Undefined size: %d", (int)size);
        break;
    }
}

+ (UIColor *)colorForSpinnerStyle:(BPKSpinnerStyle)style {
    switch (style) {
    case BPKSpinnerStylePrimary:
        return [BPKColor dynamicColorWithLightVariant:BPKColor.skyBlue darkVariant:BPKColor.white];
    case BPKSpinnerStyleSecondary:
        return BPKColor.textPrimaryColor;
    case BPKSpinnerStyleDark:
        return BPKColor.skyGrayTint01;
    case BPKSpinnerStyleLight:
        return BPKColor.white;
    default:
        NSAssert(NO, @"Undefined style: %d", (int)style);
        break;
    }
}

@end

NS_ASSUME_NONNULL_END
