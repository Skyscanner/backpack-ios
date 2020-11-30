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

#import "BPKCalendarTrafficLightCellData.h"

#import <Backpack/Common.h>
#import <Backpack/Color.h>

@implementation BPKCalendarTrafficLightCellData

+ (BPKCalendarTrafficLightCellData *)normal {
    static dispatch_once_t onceToken;
    static BPKCalendarTrafficLightCellData  *cellData;

    dispatch_once(&onceToken, ^{
        BPKAssertMainThread();
        cellData = [[BPKCalendarTrafficLightCellData alloc] initWithBackgroundColor:BPKColor.backgroundColor foregroundColor:BPKColor.textPrimaryColor];
    });

    return cellData;
}

+ (BPKCalendarTrafficLightCellData *)positive {
    static dispatch_once_t onceToken;
    static BPKCalendarTrafficLightCellData  *cellData;

    dispatch_once(&onceToken, ^{
        BPKAssertMainThread();
        cellData = [[BPKCalendarTrafficLightCellData alloc] initWithBackgroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.monteverde darkVariant:BPKColor.glencoe] foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black]];
    });

    return cellData;
}

+ (BPKCalendarTrafficLightCellData *)negative {
    static dispatch_once_t onceToken;
    static BPKCalendarTrafficLightCellData  *cellData;

    dispatch_once(&onceToken, ^{
        BPKAssertMainThread();
        cellData = [[BPKCalendarTrafficLightCellData alloc] initWithBackgroundColor:BPKColor.panjin foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black]];
    });

    return cellData;
}

+ (BPKCalendarTrafficLightCellData *)noData {
    static dispatch_once_t onceToken;
    static BPKCalendarTrafficLightCellData  *cellData;

    dispatch_once(&onceToken, ^{
        BPKAssertMainThread();
        cellData = [[BPKCalendarTrafficLightCellData alloc] initWithBackgroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint03 darkVariant:BPKColor.blackTint06] foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black]];
    });

    return cellData;
}

+ (BPKCalendarTrafficLightCellData *)neutral {
    static dispatch_once_t onceToken;
    static BPKCalendarTrafficLightCellData  *cellData;

    dispatch_once(&onceToken, ^{
        BPKAssertMainThread();
        cellData = [[BPKCalendarTrafficLightCellData alloc] initWithBackgroundColor:BPKColor.erfoud foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.skyGray darkVariant:BPKColor.black]];
    });

    return cellData;
}

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor foregroundColor:(UIColor *)foregroundColor
{
    self = [super init];
    if (self) {
        _backgroundColor = backgroundColor;
        _foregroundColor = foregroundColor;
    }
    return self;
}

@end
