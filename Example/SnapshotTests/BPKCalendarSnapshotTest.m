//
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

#import <Backpack/Calendar.h>
#import <Backpack/Color.h>
#import <Backpack/SimpleDate.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface BPKCalendarSnapshotTest : FBSnapshotTestCase<BPKCalendarDelegate>

@property NSDate *date1;
@property NSDate *date2;
@property BOOL isColoringDates;

@end

NS_ASSUME_NONNULL_BEGIN

/**
 * There seems to be a bug in FBSnapshotTestCase regarding intristict content size handling.
 * We exposed the year pill to be able to snapshot test it separately as a workaround.
 */
@implementation BPKCalendarSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
    self.date1 = [NSDate dateWithTimeIntervalSince1970:2175785688];
    self.date2 = [NSDate dateWithTimeIntervalSince1970:2176044888];
    self.isColoringDates = NO;
}

- (void)configureParentView:(UIView *)parentView forCalendar:(BPKCalendar *)calendar {
    parentView.translatesAutoresizingMaskIntoConstraints = NO;
    calendar.translatesAutoresizingMaskIntoConstraints = NO;
    parentView.backgroundColor = [BPKColor white];
    [parentView addSubview:calendar];

    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-16-[calendar]-16-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"calendar": calendar}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[calendar]-16-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"calendar": calendar}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[parentView(320)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"parentView": parentView}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[parentView(568)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"parentView": parentView}]];
    [parentView layoutIfNeeded];
}

- (void)testCalendarWithoutSelection {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];
    [self configureParentView:parentView forCalendar:bpkCalendar];
    
    bpkCalendar.selectionType = BPKCalendarSelectionSingle;
    
    bpkCalendar.selectedDates = @[[[BPKSimpleDate alloc] initWithDate:self.date1 forCalendar:bpkCalendar.gregorian]];
    [bpkCalendar reloadData];
    
    bpkCalendar.selectedDates = @[];
    [bpkCalendar reloadData];
    
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithSingleSelection {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionSingle;
    bpkCalendar.selectedDates = @[[[BPKSimpleDate alloc] initWithDate:self.date1 forCalendar:bpkCalendar.gregorian]];
    [bpkCalendar reloadData];

    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithSingleSelectionAndCustomDisabledDates {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionSingle;
    bpkCalendar.selectedDates = @[[[BPKSimpleDate alloc] initWithDate:self.date1 forCalendar:bpkCalendar.gregorian]];
    bpkCalendar.delegate = self;
    [bpkCalendar reloadData];

    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithRangeSelection {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionRange;
    bpkCalendar.selectedDates = @[
        [[BPKSimpleDate alloc] initWithDate:self.date1 forCalendar:bpkCalendar.gregorian],
        [[BPKSimpleDate alloc] initWithDate:self.date2 forCalendar:bpkCalendar.gregorian]
    ];
    [bpkCalendar reloadData];

    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithRangeSelectionWithTheme {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionRange;
    bpkCalendar.selectedDates = @[
        [[BPKSimpleDate alloc] initWithDate:self.date1 forCalendar:bpkCalendar.gregorian],
        [[BPKSimpleDate alloc] initWithDate:self.date2 forCalendar:bpkCalendar.gregorian]
    ];
    [bpkCalendar reloadData];
    bpkCalendar.dateSelectedContentColor = UIColor.orangeColor;
    bpkCalendar.dateSelectedBackgroundColor = UIColor.greenColor;

    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithMultipleSelection {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionMultiple;
    bpkCalendar.selectedDates = @[
        [[BPKSimpleDate alloc] initWithDate:self.date1 forCalendar:bpkCalendar.gregorian],
        [[BPKSimpleDate alloc] initWithDate:self.date2 forCalendar:bpkCalendar.gregorian]
    ];
    [bpkCalendar reloadData];

    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithCustomColorDates {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionSingle;

    bpkCalendar.selectedDates = @[[[BPKSimpleDate alloc] initWithDate:self.date1 forCalendar:bpkCalendar.gregorian]];
    self.isColoringDates = YES;
    bpkCalendar.delegate = self;
    [bpkCalendar reloadData];

    FBSnapshotVerifyView(parentView, nil);
}

#pragma mark - <BPKCalendarDelegate>

- (BOOL)calendar:(BPKCalendar *)calendar isDateEnabled:(BPKSimpleDate *)date {

    if (self.isColoringDates) {
        return YES;
    }

    NSDate *nativeDate = [date dateForCalendar:calendar.gregorian];
    if ([nativeDate compare:self.date2] == NSOrderedDescending) {
        return NO;
    }

    return YES;
}

- (void)calendar:(nonnull BPKCalendar *)calendar didChangeDateSelection:(nonnull NSArray<BPKSimpleDate *> *)dateList {
    return;
}

- (BPKCalendarDateCellStyle)calendar:(BPKCalendar *)calendar cellStyleForDate:(BPKSimpleDate *)date {
    if (!self.isColoringDates) {
        return BPKCalendarDateCellStyleNormal;
    }
    NSCalendar *cal = calendar.gregorian;
    NSDate *convertedDate = [date dateForCalendar:calendar.gregorian];
    NSDate *date1 = [cal startOfDayForDate: self.date1];
    NSDate *date2 = [cal startOfDayForDate:convertedDate];
    NSDateComponents *components = [cal components:NSCalendarUnitDay
                                               fromDate:date1
                                                 toDate:date2
                                                options:0];

    if (components.day == 2 || components.day == 8 || components.day == 12 || components.day == 20) {
        return BPKCalendarDateCellStylePositive;
    }

    if (components.day == 4 || components.day == 10 || components.day == 24) {
        return BPKCalendarDateCellStyleNegative;
    }

    if (components.day == 1 || components.day == 3 || components.day == 11 || components.day == 22) {
        return BPKCalendarDateCellStyleNeutral;
    }

    if (components.day == 13) {
        return BPKCalendarDateCellStyleCustom;
    }
    
    if (components.day == 15) {
        return BPKCalendarDateCellStyleNormal;
    }

    return BPKCalendarDateCellStyleNoData;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (UIColor *)DONT_USE_calendar:(nonnull BPKCalendar *)calendar fillColorForDate:(NSDate *)date {
    if (!self.isColoringDates) {
        return BPKColor.clear;
    }

    return BPKColor.abisko;
}
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END
