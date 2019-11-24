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

#import "BPKSnapshotTest.h"

@interface BPKCalendarYearPillSnapshotTest : FBSnapshotTestCase

@end

@implementation BPKCalendarYearPillSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)createYearPill {
    BPKCalendarYearPill *yearPill = [[BPKCalendarYearPill alloc] initWithFrame:CGRectZero];
    yearPill.year = @2019;
    return yearPill;
}

- (void)testYearPill {
    UIView *lightView = [self createYearPill];
    UIView *darkView = [self createYearPill];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end
