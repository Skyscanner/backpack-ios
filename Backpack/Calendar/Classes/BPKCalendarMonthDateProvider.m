/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

#import "BPKCalendarMonthDateProvider.h"

#import <Backpack/SimpleDate.h>
#import <Foundation/Foundation.h>

@interface BPKCalendarMonthDateProvider ()

@property(nonatomic, strong, readonly) NSCalendar *calendar;

@end

@implementation BPKCalendarMonthDateProvider

- initWithCalendar:(NSCalendar *)calendar {
    self = [super init];

    if (self) {
        _calendar = calendar;
    }

    return self;
}

- (NSDate *)day:(NSInteger)day fromMonth:(NSDate *)month {
    NSDateComponents *comp = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:month];

    [comp setDay:day];

    return [self.calendar dateFromComponents:comp];
}

- (NSDate *)firstValidDayOfMonth:(NSDate *)month fromMinDate:(NSDate *)minDate {
    NSDate *firstDay = [self day:1 fromMonth:month];

    return [firstDay compare:minDate] == NSOrderedDescending ? firstDay : minDate;
}

- (NSDate *)lastDayOfMonth:(NSDate *)month {
    NSInteger lastDay = [self numberOfDaysInMonth:month];

    return [self day:lastDay fromMonth:month];
}

- (NSInteger)numberOfDaysInMonth:(NSDate *)month {
    NSRange daysOfMonth = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:month];
    return daysOfMonth.length;
}

- (NSArray<BPKSimpleDate *> *)dateListForMonth:(NSDate *)month fromMinDate:(NSDate *)minDate {
    NSDate *firstDay = [self firstValidDayOfMonth:month fromMinDate:minDate];
    NSDate *lastDay = [self lastDayOfMonth:month];

    NSArray<NSDate *> *dateList = @[firstDay, lastDay];
    return [BPKSimpleDate simpleDatesFromDates:dateList forCalendar:self.calendar];
}

@end
