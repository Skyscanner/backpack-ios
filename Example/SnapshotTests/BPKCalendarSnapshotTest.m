//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2018. Skyscanner Ltd. All rights reserved.
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


#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <Backpack/Color.h>
#import <Backpack/Calendar.h>

@interface BPKCalendarSnapshotTest : FBSnapshotTestCase

@property NSDate *date1;
@property NSDate *date2;

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKCalendarSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
    self.date1 = [NSDate dateWithTimeIntervalSince1970:2175785688];
    self.date2 = [NSDate dateWithTimeIntervalSince1970:2176044888];
}

- (void)configureParentView:(UIView *)parentView forCalendar:(BPKCalendar *)calendar {
    parentView.translatesAutoresizingMaskIntoConstraints = NO;
    parentView.backgroundColor = [BPKColor white];
    [parentView addSubview:calendar];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-16-[calendar]-16-|" options:0 metrics:nil views:@{@"calendar": calendar}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[calendar]-16-|" options:0 metrics:nil views:@{@"calendar": calendar}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[parentView(320)]" options:0 metrics:nil views:@{@"parentView": parentView}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[parentView(568)]" options:0 metrics:nil views:@{@"parentView": parentView}]];
    [parentView layoutIfNeeded];
}

- (void)testCalendarWithoutSelection {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];
    [self configureParentView:parentView forCalendar:bpkCalendar];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithSingleSelection {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];
    
    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionSingle;
    bpkCalendar.selectedDates = @[ self.date1 ];
    [bpkCalendar reloadData];
    
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithRangeSelection {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];
    
    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionRange;
    bpkCalendar.selectedDates = @[ self.date1, self.date2 ];
    [bpkCalendar reloadData];
    
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testCalendarWithMultipleSelection {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];
    
    [self configureParentView:parentView forCalendar:bpkCalendar];
    bpkCalendar.selectionType = BPKCalendarSelectionMultiple;
    bpkCalendar.selectedDates = @[ self.date1, self.date2 ];
    [bpkCalendar reloadData];
    
    FBSnapshotVerifyView(parentView, nil);
}

@end

NS_ASSUME_NONNULL_END
