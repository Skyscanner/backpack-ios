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

#import "BPKCalendarPriceLabelStyle.h"

#import <Backpack/Color.h>

#import "BPKCalendarColor.h"

@implementation BPKCalendarPriceLabelStyle

+ (BPKCalendarPriceLabelStyle *)noData {
    static dispatch_once_t onceToken;
    static BPKCalendarPriceLabelStyle *style;

    dispatch_once(&onceToken, ^{
      style = [[BPKCalendarPriceLabelStyle alloc] initWithColor:BPKColor.textSecondaryColor bold:NO];
    });

    return style;
}

+ (BPKCalendarPriceLabelStyle *)negative {
    static dispatch_once_t onceToken;
    static BPKCalendarPriceLabelStyle *style;

    dispatch_once(&onceToken, ^{
      style = [[BPKCalendarPriceLabelStyle alloc] initWithColor:BPKColor.textSecondaryColor bold:NO];
    });

    return style;
}

+ (BPKCalendarPriceLabelStyle *)positive {
    static dispatch_once_t onceToken;
    static BPKCalendarPriceLabelStyle *style;

    dispatch_once(&onceToken, ^{
      style = [[BPKCalendarPriceLabelStyle alloc] initWithColor:BPKCalendarColor.positiveColor bold:YES];
    });

    return style;
}

- (instancetype)initWithColor:(UIColor *)color bold:(BOOL)bold {
    self = [super init];
    if (self) {
        _color = color;
        _bold = bold;
    }
    return self;
}

@end
