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

NS_ASSUME_NONNULL_BEGIN

@class BPKCalendarPriceLabelStyle;

/**
 * `BPKCalendarPriceLabelCellData` contains the properties required to show a price label under a calendar cell.
 */
@interface BPKCalendarPriceLabelCellData : NSObject

/**
 * Create an instance of `BPKCalendarPriceLabelCellData`.
 *
 * @param price the price to show at the bottom of the cell.
 * @param labelStyle The style to be applied to the text at the bottom of the cell.
 */
- (instancetype)initWithPrice:(NSString *)price labelStyle:(BPKCalendarPriceLabelStyle *)labelStyle;

/**
 * The price value to be shown below the cell.
 */
@property(nonatomic, readonly) NSString *price;

/**
 * The style to apply to the price label.
 */
@property(nonatomic, readonly) BPKCalendarPriceLabelStyle *labelStyle;

@end

NS_ASSUME_NONNULL_END
