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

#import <XCTest/XCTest.h>

#import <Backpack/SimpleDate.h>

@interface BPKSimpleDateTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKSimpleDateTest

- (void)testInitWithDMY {
    int day = 29;
    int month = 4;
    int year = 2014;

    BPKSimpleDate *sd = [[BPKSimpleDate alloc] initWithYear:year month:month day:day];

    XCTAssertEqual(sd.year, year);
    XCTAssertEqual(sd.month, month);
    XCTAssertEqual(sd.day, day);
}

- (void)testInitWithDate {
    int day = 3;
    int month = 5;
    int year = 2018;

    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:    year];
    NSDate *date = [calendar dateFromComponents:components];

    BPKSimpleDate *sd = [[BPKSimpleDate alloc] initWithDate:date forCalendar:calendar];

    XCTAssertEqual(sd.year, year);
    XCTAssertEqual(sd.month, month);
    XCTAssertEqual(sd.day, day);
}

- (void)testSimpleDateToDate {
    int day = 29;
    int month = 4;
    int year = 2014;

    NSCalendar *calendar = [NSCalendar currentCalendar];

    BPKSimpleDate *sd = [[BPKSimpleDate alloc] initWithYear:year month:month day:day];

    NSDate *date = [sd dateForCalendar: calendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];

    XCTAssertEqual(dateComponents.year, year);
    XCTAssertEqual(dateComponents.month, month);
    XCTAssertEqual(dateComponents.day, day);
}

- (void)testInitWithDateTimezonePlus11Calendar {
    int day = 3;
    int month = 5;
    int year = 2018;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [[NSTimeZone alloc] initWithName:@"UTC+11:00"];

    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:    year];
    NSDate *date = [calendar dateFromComponents:components];

    BPKSimpleDate *sd = [[BPKSimpleDate alloc] initWithDate:date forCalendar:calendar];

    XCTAssertEqual(sd.year, year);
    XCTAssertEqual(sd.month, month);
    XCTAssertEqual(sd.day, day);
}

- (void)testSimpleDateToDateTimezonePlus11Calendar {
    int day = 29;
    int month = 4;
    int year = 2014;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [[NSTimeZone alloc] initWithName:@"UTC+11:00"];

    BPKSimpleDate *sd = [[BPKSimpleDate alloc] initWithYear:year month:month day:day];

    NSDate *date = [sd dateForCalendar: calendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];

    XCTAssertEqual(dateComponents.year, year);
    XCTAssertEqual(dateComponents.month, month);
    XCTAssertEqual(dateComponents.day, day);
}

- (void)testInitWithDateTimezoneMinus11Calendar {
    int day = 3;
    int month = 5;
    int year = 2018;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [[NSTimeZone alloc] initWithName:@"UTC-11:00"];

    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:    year];
    NSDate *date = [calendar dateFromComponents:components];

    BPKSimpleDate *sd = [[BPKSimpleDate alloc] initWithDate:date forCalendar:calendar];

    XCTAssertEqual(sd.year, year);
    XCTAssertEqual(sd.month, month);
    XCTAssertEqual(sd.day, day);
}

- (void)testSimpleDateToDateTimezoneMinus11Calendar {
    int day = 29;
    int month = 4;
    int year = 2014;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [[NSTimeZone alloc] initWithName:@"UTC-11:00"];

    BPKSimpleDate *sd = [[BPKSimpleDate alloc] initWithYear:year month:month day:day];

    NSDate *date = [sd dateForCalendar: calendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];

    XCTAssertEqual(dateComponents.year, year);
    XCTAssertEqual(dateComponents.month, month);
    XCTAssertEqual(dateComponents.day, day);
}

- (void)testInitWithDateJapanLocaleCalendar {
    int day = 3;
    int month = 5;
    int year = 2018;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"ja-JP"];

    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:    year];
    NSDate *date = [calendar dateFromComponents:components];

    BPKSimpleDate *sd = [[BPKSimpleDate alloc] initWithDate:date forCalendar:calendar];

    XCTAssertEqual(sd.year, year);
    XCTAssertEqual(sd.month, month);
    XCTAssertEqual(sd.day, day);
}

- (void)testSimpleDateToDateJapanLocaleCalendar {
    int day = 29;
    int month = 4;
    int year = 2014;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"ja-JP"];

    BPKSimpleDate *sd = [[BPKSimpleDate alloc] initWithYear:year month:month day:day];

    NSDate *date = [sd dateForCalendar: calendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];

    XCTAssertEqual(dateComponents.year, year);
    XCTAssertEqual(dateComponents.month, month);
    XCTAssertEqual(dateComponents.day, day);
}

@end

NS_ASSUME_NONNULL_END
