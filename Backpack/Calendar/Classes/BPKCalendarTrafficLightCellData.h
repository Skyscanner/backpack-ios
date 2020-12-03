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

@interface BPKCalendarTrafficLightCellData : NSObject

@property(class, readonly) BPKCalendarTrafficLightCellData *normal;
@property(class, readonly) BPKCalendarTrafficLightCellData *positive;
@property(class, readonly) BPKCalendarTrafficLightCellData *negative;
@property(class, readonly) BPKCalendarTrafficLightCellData *noData NS_SWIFT_NAME(noData);
@property(class, readonly) BPKCalendarTrafficLightCellData *neutral;

@property(strong) UIColor *backgroundColor;
@property(strong) UIColor *foregroundColor;

@end

NS_ASSUME_NONNULL_END
