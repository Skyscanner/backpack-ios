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
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationSingle alloc] initWithSelectionHint:@""];

    XCTAssertFalse(c1.allowsMultipleSelection);
    XCTAssertFalse(c1.isRangeStyleSelection);
}

- (void)multipleConfigShouldHaveCorrectFeatures {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationMultiple alloc] initWithSelectionHint:@"" deselectionHint:@""];

    XCTAssertTrue(c1.allowsMultipleSelection);
    XCTAssertFalse(c1.isRangeStyleSelection);
}

- (void)rangeConfigShouldHaveCorrectFeatures {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@""
                                                                                                      endSelectionHint:@""
                                                                                                   startSelectionState:@""
                                                                                                     endSelectionState:@""
                                                                                                 betweenSelectionState:@""
                                                                                             startAndEndSelectionState:@""
                                                                                                      returnDatePrompt:@""];

    XCTAssertTrue(c1.allowsMultipleSelection);
    XCTAssertTrue(c1.isRangeStyleSelection);
}

- (void)singleConfigShouldNeverClearSelectedDates {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationSingle alloc] initWithSelectionHint:@""];

    XCTAssertFalse([c1 shouldClearSelectedDates:@[self.date1] whenSelectingDate:self.date2]);
    XCTAssertFalse([c1 shouldClearSelectedDates:@[self.date2] whenSelectingDate:self.date1]);
}

- (void)multipleConfigShouldNeverClearSelectedDates {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationMultiple alloc] initWithSelectionHint:@"" deselectionHint:@""];

    XCTAssertFalse([c1 shouldClearSelectedDates:@[self.date1] whenSelectingDate:self.date2]);
    XCTAssertFalse([c1 shouldClearSelectedDates:@[self.date2] whenSelectingDate:self.date1]);
    XCTAssertFalse([c1 shouldClearSelectedDates:(@[self.date1, self.date2]) whenSelectingDate:self.date3]);
    XCTAssertFalse([c1 shouldClearSelectedDates:(@[self.date1, self.date3]) whenSelectingDate:self.date2]);
}

- (void)rangeConfigShouldNotClearSelectedDatesWhenSelectingSecondDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@""
                                                                                                      endSelectionHint:@""
                                                                                                   startSelectionState:@""
                                                                                                     endSelectionState:@""
                                                                                                 betweenSelectionState:@""
                                                                                             startAndEndSelectionState:@""
                                                                                                      returnDatePrompt:@""];

    XCTAssertFalse([c1 shouldClearSelectedDates:@[self.date1] whenSelectingDate:self.date2]);
}

- (void)rangeConfigShouldClearSelectedDatesWhenSelectingDateBeforeFirst {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@""
                                                                                                      endSelectionHint:@""
                                                                                                   startSelectionState:@""
                                                                                                     endSelectionState:@""
                                                                                                 betweenSelectionState:@""
                                                                                             startAndEndSelectionState:@""
                                                                                                      returnDatePrompt:@""];

    XCTAssertTrue([c1 shouldClearSelectedDates:@[self.date2] whenSelectingDate:self.date1]);
    XCTAssertTrue([c1 shouldClearSelectedDates:(@[self.date2, self.date3]) whenSelectingDate:self.date1]);
}

- (void)rangeConfigShouldClearSelectedDatesWhenSelectingThirdDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@""
                                                                                                      endSelectionHint:@""
                                                                                                   startSelectionState:@""
                                                                                                     endSelectionState:@""
                                                                                                 betweenSelectionState:@""
                                                                                             startAndEndSelectionState:@""
                                                                                                      returnDatePrompt:@""];

    XCTAssertTrue([c1 shouldClearSelectedDates:(@[self.date1, self.date2]) whenSelectingDate:self.date3]);
    XCTAssertTrue([c1 shouldClearSelectedDates:(@[self.date1, self.date3]) whenSelectingDate:self.date2]);
}

- (void)testSingleAccessibilityHintSelectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationSingle alloc] initWithSelectionHint:@"SELECTION_HINT"];

    NSString *hint = [c1 accessibilityHintForDate:self.date1 selectedDates:@[self.date1]];

    XCTAssertNil(hint);
}

- (void)testSingleAccessibilityHintDeselectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationSingle alloc] initWithSelectionHint:@"SELECTION_HINT"];

    NSString *hint = [c1 accessibilityHintForDate:self.date1 selectedDates:@[self.date2]];

    XCTAssertEqual(hint, @"SELECTION_HINT");
}

- (void)testSingleAccessibilityLabelIsUnchanged {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationSingle alloc] initWithSelectionHint:@"SELECTION_HINT"];

    NSString *hint = [c1 accessibilityLabelForDate:self.date1 selectedDates:@[self.date2] baseLabel:@"BASE_LABEL"];

    XCTAssertEqual(hint, @"BASE_LABEL");
}

- (void)testSingleAccessibilityPromptIsNil {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationSingle alloc] initWithSelectionHint:@"SELECTION_HINT"];

    NSString *hint = [c1 accessibilityInstructionHavingSelectedDates:@[self.date1]];

    XCTAssertNil(hint);
}

- (void)testMultipleAccessibilityHintSelectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationMultiple alloc] initWithSelectionHint:@"SELECTION_HINT"
                                                                                                     deselectionHint:@"DESELECTION_HINT"];

    NSString *hint = [c1 accessibilityHintForDate:self.date1 selectedDates:@[self.date1]];

    XCTAssertEqual(hint, @"DESELECTION_HINT");
}

- (void)testMultipleAccessibilityHintDeselectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationMultiple alloc] initWithSelectionHint:@"SELECTION_HINT"
                                                                                                     deselectionHint:@"DESELECTION_HINT"];

    NSString *hint = [c1 accessibilityHintForDate:self.date1 selectedDates:@[self.date2]];

    XCTAssertEqual(hint, @"SELECTION_HINT");
}

- (void)testMultipleAccessibilityLabelIsUnchanged {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationMultiple alloc] initWithSelectionHint:@"SELECTION_HINT"
                                                                                                     deselectionHint:@"DESELECTION_HINT"];

    NSString *hint = [c1 accessibilityLabelForDate:self.date1 selectedDates:@[self.date2] baseLabel:@"BASE_LABEL"];

    XCTAssertEqual(hint, @"BASE_LABEL");
}

- (void)testMultipleAccessibilityPromptIsNil {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationMultiple alloc] initWithSelectionHint:@"SELECTION_HINT"
                                                                                                     deselectionHint:@"DESELECTION_HINT"];

    NSString *hint = [c1 accessibilityInstructionHavingSelectedDates:@[self.date1]];

    XCTAssertNil(hint);
}

- (void)testRangeAccessibilityHintNoSelectedDates {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityHintForDate:self.date1 selectedDates:@[]];

    XCTAssertEqual(hint, @"FIRST_HINT");
}

- (void)testRangeAccessibilityHintBeforeSelectedDates {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityHintForDate:self.date1 selectedDates:@[self.date2, self.date3]];

    XCTAssertEqual(hint, @"FIRST_HINT");
}

- (void)testRangeAccessibilityHintBetweenSelectedDates {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityHintForDate:self.date2 selectedDates:@[self.date1, self.date3]];

    XCTAssertEqual(hint, @"FIRST_HINT");
}

- (void)testRangeAccessibilityHintAfterSelectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityHintForDate:self.date2 selectedDates:@[self.date1]];

    XCTAssertEqual(hint, @"SECOND_HINT");
}

- (void)testRangeAccessibilityHintSelectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityHintForDate:self.date1 selectedDates:@[self.date1]];

    XCTAssertEqual(hint, @"SECOND_HINT");
}

- (void)testRangeAccessibilityHintAfterSelectedDates {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityHintForDate:self.date2 selectedDates:@[self.date1, self.date1]];

    XCTAssertEqual(hint, @"FIRST_HINT");
}

- (void)testRangeAccessibilityLabelUnselectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityLabelForDate:self.date1 selectedDates:@[self.date2, self.date3] baseLabel:@"BASE_LABEL"];

    XCTAssertEqual(hint, @"BASE_LABEL");
}

- (void)testRangeAccessibilityLabelFirstSelectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityLabelForDate:self.date1 selectedDates:@[self.date1, self.date2] baseLabel:@"BASE_LABEL"];

    XCTAssertTrue([hint isEqualToString:@"BASE_LABEL, FIRST_STATE"]);
}

- (void)testRangeAccessibilityLabelSecondSelectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityLabelForDate:self.date2 selectedDates:@[self.date1, self.date2] baseLabel:@"BASE_LABEL"];

    XCTAssertTrue([hint isEqualToString:@"BASE_LABEL, SECOND_STATE"]);
}

- (void)testRangeAccessibilityLabelBetweenSelectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityLabelForDate:self.date2 selectedDates:@[self.date1, self.date3] baseLabel:@"BASE_LABEL"];

    XCTAssertTrue([hint isEqualToString:@"BASE_LABEL, BETWEEN_STATE"]);
}

- (void)testRangeAccessibilityLabelBothSelectedDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityLabelForDate:self.date1 selectedDates:@[self.date1, self.date1] baseLabel:@"BASE_LABEL"];

    XCTAssertTrue([hint isEqualToString:@"BASE_LABEL, BOTH_STATE"]);
}

- (void)testRangeAccessibilityPromptNoDates {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityInstructionHavingSelectedDates:@[]];

    XCTAssertEqual(hint, nil);
}

- (void)testRangeAccessibilityPromptOneDate {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityInstructionHavingSelectedDates:@[self.date1]];

    XCTAssertEqual(hint, @"RETURN_PROMPT");
}

- (void)testRangeAccessibilityPromptTwoDates {
    BPKCalendarSelectionConfiguration *c1 = [[BPKCalendarSelectionConfigurationRange alloc] initWithStartSelectionHint:@"FIRST_HINT"
                                                                                                      endSelectionHint:@"SECOND_HINT"
                                                                                                   startSelectionState:@"FIRST_STATE"
                                                                                                     endSelectionState:@"SECOND_STATE"
                                                                                                 betweenSelectionState:@"BETWEEN_STATE"
                                                                                             startAndEndSelectionState:@"BOTH_STATE"
                                                                                                      returnDatePrompt:@"RETURN_PROMPT"];

    NSString *hint = [c1 accessibilityInstructionHavingSelectedDates:@[self.date1, self.date2]];

    XCTAssertEqual(hint, nil);
}

@end

NS_ASSUME_NONNULL_END
