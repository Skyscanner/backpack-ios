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

NS_ASSUME_NONNULL_BEGIN

@interface BPKSpinner()

@end

@implementation BPKSpinner

- (instancetype)initWithStyle:(BPKSpinnerStyle)style size:(BPKSpinnerSize)size {
    self = [super initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    if (self) {
        [self setupWithStyle:style size:size];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupWithDefaultValues];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
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
    _size = size;
    [self didChangeProperty];
    [self setNeedsLayout];
}

- (void)setStyle:(BPKSpinnerStyle)style {
    _style = style;
    [self didChangeProperty];
}

- (void)didChangeProperty {
    self.activityIndicatorViewStyle = [self.class styleForSpinnerSize:self.size];
    self.color = [self.class colorForSpinnerStyle:self.style instance:self];
    [self setNeedsDisplay];
}

- (void) setPrimaryColor500:(UIColor *)color {
    _primaryColor500 = color;
    [self didChangeProperty];
}

- (void) setDarkColor700:(UIColor *)color {
    _darkColor700 = color;
    [self didChangeProperty];
}

+ (UIActivityIndicatorViewStyle)styleForSpinnerSize:(BPKSpinnerSize)size {
    switch (size) {
        case BPKSpinnerSizeDefault:
            return UIActivityIndicatorViewStyleWhiteLarge;
        case BPKSpinnerSizeSmall:
            return UIActivityIndicatorViewStyleWhite;
        default:
            NSAssert(NO, @"Undefined size: %d", (int) size);
            break;
    }
}

+ (UIColor *)colorForSpinnerStyle:(BPKSpinnerStyle)style instance:(BPKSpinner* _Nullable)instance {
    switch (style) {
        case BPKSpinnerStylePrimary:
            return instance && instance.primaryColor500 ? instance.primaryColor500 : BPKColor.blue500;
        case BPKSpinnerStyleDark:
            return instance && instance.darkColor700 ? instance.darkColor700 : BPKColor.gray700;
        case BPKSpinnerStyleLight:
            return BPKColor.white;
        default:
            NSAssert(NO, @"Undefined style: %d", (int) style);
            break;
    }
}

+ (UIColor *)colorForSpinnerStyle:(BPKSpinnerStyle)style {
    return [self colorForSpinnerStyle:style instance:nil];
}

@end

NS_ASSUME_NONNULL_END
