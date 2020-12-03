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

@interface BPKCalendarColor : NSObject

@property(class, readonly) UIColor *normalColor;
@property(class, readonly) UIColor *normalTitleColor;
@property(class, readonly) UIColor *positiveColor;
@property(class, readonly) UIColor *positiveTitleColor;
@property(class, readonly) UIColor *negativeColor;
@property(class, readonly) UIColor *negativeTitleColor;
@property(class, readonly) UIColor *noDataColor;
@property(class, readonly) UIColor *noDataTitleColor;
@property(class, readonly) UIColor *neutralColor;
@property(class, readonly) UIColor *neutralTitleColor;

@end

NS_ASSUME_NONNULL_END
