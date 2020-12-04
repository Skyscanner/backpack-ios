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

#import "BPKCalendarColor.h"

@implementation BPKCalendarTrafficLightCellData

+ (BPKCalendarTrafficLightCellData *)normal {
    static dispatch_once_t onceToken;
    static BPKCalendarTrafficLightCellData  *cellData;

    dispatch_once(&onceToken, ^{
        cellData = [[BPKCalendarTrafficLightCellData alloc]
                    initWithBackgroundColor:BPKCalendarColor.normalColor
                    foregroundColor:BPKCalendarColor.normalTitleColor];
    });

    return cellData;
}

+ (BPKCalendarTrafficLightCellData *)positive {
    static dispatch_once_t onceToken;
    static BPKCalendarTrafficLightCellData  *cellData;

    dispatch_once(&onceToken, ^{
        cellData = [[BPKCalendarTrafficLightCellData alloc]
                    initWithBackgroundColor:BPKCalendarColor.positiveColor
                    foregroundColor:BPKCalendarColor.positiveTitleColor];
    });

    return cellData;
}

+ (BPKCalendarTrafficLightCellData *)negative {
    static dispatch_once_t onceToken;
    static BPKCalendarTrafficLightCellData  *cellData;

    dispatch_once(&onceToken, ^{
        cellData = [[BPKCalendarTrafficLightCellData alloc]
                    initWithBackgroundColor:BPKCalendarColor.negativeColor
                    foregroundColor:BPKCalendarColor.negativeTitleColor];
    });

    return cellData;
}

+ (BPKCalendarTrafficLightCellData *)noData {
    static dispatch_once_t onceToken;
    static BPKCalendarTrafficLightCellData  *cellData;

    dispatch_once(&onceToken, ^{
        cellData = [[BPKCalendarTrafficLightCellData alloc]
                    initWithBackgroundColor:BPKCalendarColor.noDataColor
                    foregroundColor:BPKCalendarColor.noDataTitleColor];
    });

    return cellData;
}

+ (BPKCalendarTrafficLightCellData *)neutral {
    static dispatch_once_t onceToken;
    static BPKCalendarTrafficLightCellData  *cellData;

    dispatch_once(&onceToken, ^{
        cellData = [[BPKCalendarTrafficLightCellData alloc]
                    initWithBackgroundColor:BPKCalendarColor.neutralColor
                    foregroundColor:BPKCalendarColor.neutralTitleColor];
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
