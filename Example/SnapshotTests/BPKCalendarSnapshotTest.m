//
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

#import <Backpack/Calendar.h>
#import <Backpack/Color.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface BPKCalendarSnapshotTest : FBSnapshotTestCase

@property NSDate *date1;
@property NSDate *date2;

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

// TODO uncomment this
// it's commented out because currently the calendar always highlights today's date,
// meaning this test fails every time it runs on different days.
//
// We should fix this by exposing FSCalendar's 'calendar.today' property and setting it to
// a constant date here.
//
//- (void)testCalendarWithoutSelection {
//    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
//    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];
//    [self configureParentView:parentView forCalendar:bpkCalendar];
//    FBSnapshotVerifyView(parentView, nil);
//}

- (void)testCalendarWithSingleSelection {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionSingle;
    bpkCalendar.selectedDates = @[[bpkCalendar simpleDateFromDate:self.date1]];
    [bpkCalendar reloadData];

    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithRangeSelection {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionRange;
    bpkCalendar.selectedDates =
        @[[bpkCalendar simpleDateFromDate:self.date1], [bpkCalendar simpleDateFromDate:self.date2]];
    [bpkCalendar reloadData];

    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithRangeSelectionWithTheme {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionRange;
    bpkCalendar.selectedDates =
        @[[bpkCalendar simpleDateFromDate:self.date1], [bpkCalendar simpleDateFromDate:self.date2]];
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
    bpkCalendar.selectedDates =
        @[[bpkCalendar simpleDateFromDate:self.date1], [bpkCalendar simpleDateFromDate:self.date2]];
    [bpkCalendar reloadData];

    FBSnapshotVerifyView(parentView, nil);
}

@end

NS_ASSUME_NONNULL_END
