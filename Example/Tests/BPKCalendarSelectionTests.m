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

#import <XCTest/XCTest.h>

#import <Backpack/Calendar.h>

@interface BPKCalendarSelectionTests : XCTestCase

@property NSDate *date1;
@property NSDate *date2;
@property NSDate *date3;

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKCalendarSelectionTests

- (void)setUp {
    self.date1 = [NSDate dateWithTimeIntervalSince1970:2175785688];
    self.date2 = [NSDate dateWithTimeIntervalSince1970:2176044888];
    self.date3 = [NSDate dateWithTimeIntervalSince1970:2177772888];
}

- (void)singleConfigShouldHaveCorrectFeatures {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationSingle alloc] init];

    XCTAssertFalse(c1.allowsMultipleSelection);
    XCTAssertFalse(c1.isRangeStyleSelection);
}

- (void)multipleConfigShouldHaveCorrectFeatures {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationMultiple alloc] init];

    XCTAssertTrue(c1.allowsMultipleSelection);
    XCTAssertFalse(c1.isRangeStyleSelection);
}

- (void)rangeConfigShouldHaveCorrectFeatures {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] init];

    XCTAssertTrue(c1.allowsMultipleSelection);
    XCTAssertTrue(c1.isRangeStyleSelection);
}

- (void)singleConfigShouldNeverClearSelectedDates {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationSingle alloc] init];

    XCTAssertFalse([c1 shouldClearSelectedDates:@[self.date1] whenSelectingDate:self.date2]);
    XCTAssertFalse([c1 shouldClearSelectedDates:@[self.date2] whenSelectingDate:self.date1]);
}

- (void)multipleConfigShouldNeverClearSelectedDates {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationMultiple alloc] init];

    XCTAssertFalse([c1 shouldClearSelectedDates:@[self.date1] whenSelectingDate:self.date2]);
    XCTAssertFalse([c1 shouldClearSelectedDates:@[self.date2] whenSelectingDate:self.date1]);
    XCTAssertFalse([c1 shouldClearSelectedDates:(@[self.date1, self.date2]) whenSelectingDate:self.date3]);
    XCTAssertFalse([c1 shouldClearSelectedDates:(@[self.date1, self.date3]) whenSelectingDate:self.date2]);
}

- (void)rangeConfigShouldNotClearSelectedDatesWhenSelectingSecondDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] init];

    XCTAssertFalse([c1 shouldClearSelectedDates:@[self.date1] whenSelectingDate:self.date2]);
}

- (void)rangeConfigShouldClearSelectedDatesWhenSelectingDateBeforeFirst {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] init];

    XCTAssertTrue([c1 shouldClearSelectedDates:@[self.date2] whenSelectingDate:self.date1]);
    XCTAssertTrue([c1 shouldClearSelectedDates:(@[self.date2, self.date3]) whenSelectingDate:self.date1]);
}


- (void)rangeConfigShouldClearSelectedDatesWhenSelectingThirdDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] init];

    XCTAssertTrue([c1 shouldClearSelectedDates:(@[self.date1, self.date2]) whenSelectingDate:self.date3]);
    XCTAssertTrue([c1 shouldClearSelectedDates:(@[self.date1, self.date3]) whenSelectingDate:self.date2]);
}

@end

NS_ASSUME_NONNULL_END
