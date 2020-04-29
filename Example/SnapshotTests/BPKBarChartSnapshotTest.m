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
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

#import <Backpack/Backpack-Swift.h>
#import <Backpack/Color.h>

#import "BPKSnapshotTest.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKBarChartSnapshotTest : FBSnapshotTestCase<BPKBarChartCollectionViewDataSource>
@end

@implementation BPKBarChartSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)createBarChartDefault {
    BPKBarChart *view = [[BPKBarChart alloc] initWithTitle:@"Departure"];
    view.barChartDataSource = self;
    view.frame = CGRectMake(0, 0, 500, 300);
    view.backgroundColor = BPKColor.hillier;

    return view;
}

- (void)testBarChartDefault {
    UIView *lightView = [self createBarChartDefault];
    UIView *darkView = [self createBarChartDefault];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createBarChartDefaultSelected {
    BPKBarChart *view = [[BPKBarChart alloc] initWithTitle:@"Departure"];
    view.barChartDataSource = self;
    view.frame = CGRectMake(0, 0, 500, 300);
    view.barChartDataSource = self;
    view.backgroundColor = BPKColor.hillier;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    view.selectedIndexPath = indexPath;

    return view;
}

- (void)testBarChartDefaultSelected {
    UIView *lightView = [self createBarChartDefaultSelected];
    UIView *darkView = [self createBarChartDefaultSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

#pragma mark - <BPKBarChartCollectionViewDataSource>

- (NSString * _Nonnull)barChart:(BPKBarChart * _Nonnull)barChart valueDescriptionForBarAtIndex:(NSIndexPath * _Nonnull)atIndex {
    if (atIndex.item == 0) {
        return @"No price";
    }
    return [NSString stringWithFormat:@"£%ld", atIndex.item + 1];
}

- (NSNumber * _Nullable)barChart:(BPKBarChart * _Nonnull)barChart fillValueForBarAtIndex:(NSIndexPath * _Nonnull)atIndex {
    if (atIndex.item == 0) {
        return nil;
    }
    return [[NSNumber alloc] initWithFloat:atIndex.item * 0.1];
}

- (NSString * _Nonnull)barChart:(BPKBarChart * _Nonnull)barChart subtitleForBarAtIndex:(NSIndexPath * _Nonnull)atIndex {
    return [NSString stringWithFormat:@"%ld", atIndex.item + 1];
}

- (NSString * _Nonnull)barChart:(BPKBarChart * _Nonnull)barChart titleForBarAtIndex:(NSIndexPath * _Nonnull)atIndex {
    NSString *weekdays[14] = {@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun"};
    return weekdays[atIndex.item];
}

- (NSInteger)barChart:(BPKBarChart * _Nonnull)barChart numberOfBarsInSection:(NSInteger)section {
    return 10;
}


- (NSInteger)numberOfSectionsIn:(BPKBarChart * _Nonnull)barChart {
    return 2;
}

- (NSString * _Nonnull)barChart:(BPKBarChart * _Nonnull)barChart titleForSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"January";
        case 1:
            return @"February";
        default:
            return @"None";
            break;
    }
}

@end
NS_ASSUME_NONNULL_END
