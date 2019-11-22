/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(SimpleDate) @interface BPKSimpleDate : NSObject
@property(nonatomic, readonly) NSUInteger day;
@property(nonatomic, readonly) NSUInteger month;
@property(nonatomic, readonly) NSUInteger year;

- (instancetype)initWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day;

/**
 * Converts a Date to a SimpleDate based on a calendar configuration
 * @param date Date object in the device's local timezone
 * @param calendar The calendar object for the conversion
 * @return SimpleDate representing a timezone independent date
 */
- (instancetype)initWithDate:(NSDate *)date forCalendar:(NSCalendar *)calendar;

- (NSDate *)dateForCalendar:(NSCalendar *)calendar;

+ (NSArray<BPKSimpleDate *> *)simpleDatesFromDates:(NSArray<NSDate *> *)dates forCalendar:(NSCalendar *)calendar;

@end

NS_ASSUME_NONNULL_END
