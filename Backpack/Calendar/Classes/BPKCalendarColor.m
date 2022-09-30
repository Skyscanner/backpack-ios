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

#import "BPKCalendarColor.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>

@implementation BPKCalendarColor

+ (UIColor *)normalColor {
    return BPKColor.canvasColor;
}

+ (UIColor *)normalTitleColor {
    return BPKColor.textPrimaryColor;
}

+ (UIColor *)positiveColor {
    return BPKColor.statusSuccessSpotColor;
}

+ (UIColor *)positiveTitleColor {
    return BPKColor.textPrimaryInverseColor;
}

+ (UIColor *)negativeColor {
    return BPKColor.statusDangerSpotColor;
}

+ (UIColor *)negativeTitleColor {
    return BPKColor.textPrimaryInverseColor;
}

+ (UIColor *)noDataColor {
    return BPKColor.textDisabledColor;
}

+ (UIColor *)noDataTitleColor {
    return BPKColor.textPrimaryInverseColor;
}

+ (UIColor *)neutralColor {
    return BPKColor.statusWarningSpotColor;
}

+ (UIColor *)neutralTitleColor {
    return BPKColor.textOnLightColor;
}

@end
