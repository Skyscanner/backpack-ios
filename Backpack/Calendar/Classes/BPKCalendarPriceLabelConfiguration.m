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

#import "BPKCalendarPriceLabelConfiguration.h"

#import "BPKCalendarPriceLabelCell.h"
#import "BPKCalendarPriceLabelCellData.h"

@implementation BPKCalendarPriceLabelConfiguration

- (instancetype)init {
    // 70 is calculated as the sum of the following:
    // 31 is the height of the date title
    // 2 is the spacing between the title and the price label
    // 17 is the height of the price label
    // 20 is the space reserved in case the price label needs to wrap onto 2 lines
    return [super initWithCellClass:BPKCalendarPriceLabelCell.class cellDataClass:BPKCalendarPriceLabelCellData.class rowHeight:70];
}

@end
