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

/**
 * `BPKCalendarPriceLabelCellData` contains the properties required to customise a calendar cell under a traffic-light
 * system to colour cells according to data.
 */
@interface BPKCalendarPriceLabelStyle : NSObject

/**
 * Creates a `BPKCalendarPriceLabelStyle` with the specific values.
 *
 * @param textColor The text color to apply.
 * @param bold Whether the font should be bold or not.
 * @return `BPKCalendarPriceLabelStyle` instance.
 */
- (instancetype)initWithTextColor:(UIColor *)textColor bold:(BOOL)bold;

/**
 * The foreground colour to use on the cell's price label.
 */
@property(nonatomic, readonly) UIColor *textColor;

/**
 * Whether the price should be emphasized or not.
 */
@property(nonatomic, readonly, getter=isBold) BOOL bold;

/**
 * The label style for negative calendar cell price labels.
 */
@property(class, readonly) BPKCalendarPriceLabelStyle *negative;

/**
 * The label style for calendar cells with no data.
 */
@property(class, readonly) BPKCalendarPriceLabelStyle *noData;

/**
 * The label style for positive calendar cell price labels.
 */
@property(class, readonly) BPKCalendarPriceLabelStyle *positive;

@end

NS_ASSUME_NONNULL_END
