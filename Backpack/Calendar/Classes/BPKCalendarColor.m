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

#import "BPKCalendarColor.h"

#import <Backpack/Common.h>
#import <Backpack/Color.h>

@implementation BPKCalendarColor

+ (UIColor *)normalColor {
    static dispatch_once_t onceToken;
    static UIColor  *color;

    dispatch_once(&onceToken, ^{
        color = BPKColor.backgroundColor;
    });

    return color;
}

+ (UIColor *)normalTitleColor {
    static dispatch_once_t onceToken;
    static UIColor  *color;

    dispatch_once(&onceToken, ^{
        color = BPKColor.textPrimaryColor;
    });

    return color;
}

+ (UIColor *)positiveColor {
    static dispatch_once_t onceToken;
    static UIColor  *color;

    dispatch_once(&onceToken, ^{
        color = [BPKColor dynamicColorWithLightVariant:BPKColor.monteverde darkVariant:BPKColor.glencoe];
    });

    return color;
}

+ (UIColor *)positiveTitleColor {
    static dispatch_once_t onceToken;
    static UIColor  *color;

    dispatch_once(&onceToken, ^{
        color = [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black];
    });

    return color;
}

+ (UIColor *)negativeColor {
    static dispatch_once_t onceToken;
    static UIColor  *color;

    dispatch_once(&onceToken, ^{
        color = BPKColor.panjin;
    });

    return color;
}

+ (UIColor *)negativeTitleColor {
    static dispatch_once_t onceToken;
    static UIColor  *color;

    dispatch_once(&onceToken, ^{
        color = [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black];
    });

    return color;
}

+ (UIColor *)noDataColor {
    static dispatch_once_t onceToken;
    static UIColor  *color;

    dispatch_once(&onceToken, ^{
        color = [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint03 darkVariant:BPKColor.blackTint06];
    });

    return color;
}

+ (UIColor *)noDataTitleColor {
    static dispatch_once_t onceToken;
    static UIColor  *color;

    dispatch_once(&onceToken, ^{
        color = [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black];
    });

    return color;
}

+ (UIColor *)neutralColor {
    static dispatch_once_t onceToken;
    static UIColor  *color;

    dispatch_once(&onceToken, ^{
        color = BPKColor.erfoud;
    });

    return color;
}

+ (UIColor *)neutralTitleColor {
    static dispatch_once_t onceToken;
    static UIColor  *color;

    dispatch_once(&onceToken, ^{
        color = [BPKColor dynamicColorWithLightVariant:BPKColor.skyGray darkVariant:BPKColor.black];
    });

    return color;
}

@end
