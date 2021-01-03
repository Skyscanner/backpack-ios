/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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
 * `BPKCalendarTrafficLightCellData` contains the properties required to customise a calendar cell under a traffic-light
 * system to colour cells according to data.
 */
@interface BPKCalendarTrafficLightCellData : NSObject

/**
 * The cell-data representing a normal calendar cell under the traffic-light scheme.
 */
@property(class, readonly) BPKCalendarTrafficLightCellData *normal;

/**
 * The cell-data representing a positive calendar cell under the traffic-light scheme.
 */
@property(class, readonly) BPKCalendarTrafficLightCellData *positive;

/**
 * The cell-data representing a negative calendar cell under the traffic-light scheme.
 */
@property(class, readonly) BPKCalendarTrafficLightCellData *negative;

/**
 * The cell-data representing a calendar cell with no data under the traffic-light scheme.
 */
@property(class, readonly) BPKCalendarTrafficLightCellData *noData NS_SWIFT_NAME(noData);

/**
 * The cell-data representing a neutral calendar cell under the traffic-light scheme.
 */
@property(class, readonly) BPKCalendarTrafficLightCellData *neutral;

/**
 * The background colour to use on the cell.
 */
@property(readonly, nonatomic) UIColor *backgroundColor;

/**
 * The foreground colour to use on the cell.
 */
@property(readonly, nonatomic) UIColor *foregroundColor;

@end

NS_ASSUME_NONNULL_END
