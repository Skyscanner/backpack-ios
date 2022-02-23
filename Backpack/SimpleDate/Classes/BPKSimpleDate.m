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

#import "BPKSimpleDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKSimpleDate ()
@property(nonatomic) NSUInteger day;
@property(nonatomic) NSUInteger month;
@property(nonatomic) NSUInteger year;
@property(nonatomic, strong) NSDate *fullDate;

@end

@implementation BPKSimpleDate

- (instancetype)initWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    self = [super init];

    if (self) {
        self.year = year;
        self.month = month;
        self.day = day;
    }

    return self;
}

- (instancetype)initWithDate:(NSDate *)date forCalendar:(NSCalendar *)calendar {
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];

    return [[BPKSimpleDate alloc] initWithYear:components.year month:components.month day:components.day];
}

- (BOOL)isEqualToSimpleDate:(BPKSimpleDate *)other {
    return other.year == self.year && other.month == self.month && other.day == self.day;
}

- (BOOL)isEqual:(id)object {
    if (object == self) {
        return true;
    }

    if (!object) {
        return false;
    }

    if (![object isKindOfClass:[BPKSimpleDate class]]) {
        return false;
    }

    return [self isEqualToSimpleDate:object];
}

- (NSUInteger)hash {
    return self.year ^ self.month ^ self.day;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<BPKSimpleDate %lu-%lu-%lu>", (unsigned long)self.year, (unsigned long)self.month, (unsigned long)self.day];
}

- (NSDate *)dateForCalendar:(NSCalendar *)calendar {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.timeZone = calendar.timeZone;
    [components setDay:self.day];
    [components setMonth:self.month];
    [components setYear:self.year];

    return [calendar dateFromComponents:components];
}

+ (NSArray<BPKSimpleDate *> *)simpleDatesFromDates:(NSArray<NSDate *> *)dates forCalendar:(nonnull NSCalendar *)calendar {
    NSMutableArray *simpleDates = [[NSMutableArray alloc] initWithCapacity:dates.count];

    for (NSDate *date in dates) {
        [simpleDates addObject:[[BPKSimpleDate alloc] initWithDate:date forCalendar:calendar]];
    }

    return [simpleDates copy];
}

@end

NS_ASSUME_NONNULL_END
