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
@interface BPKBarChartCollectionViewSnapshotTest : FBSnapshotTestCase<BPKBarChartCollectionViewDataSource>
@end

@implementation BPKBarChartCollectionViewSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)createCollectionViewDefault {
    BPKBarChartCollectionView *view = [[BPKBarChartCollectionView alloc] initWithFrame:CGRectMake(0, 0, 500, 200) collectionViewLayout:[UICollectionViewFlowLayout new]];
    view.barChartDataSource = self;
    view.backgroundColor = BPKColor.hillier;

    return view;
}

- (void)testCollectionViewDefault {
    UIView *lightView = [self createCollectionViewDefault];
    UIView *darkView = [self createCollectionViewDefault];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createCollectionViewDefaultSelected {
    BPKBarChartCollectionView *view = [[BPKBarChartCollectionView alloc] initWithFrame:CGRectMake(0, 0, 500, 200) collectionViewLayout:[UICollectionViewFlowLayout new]];
    view.barChartDataSource = self;
    view.backgroundColor = BPKColor.hillier;

    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:3];
    [view selectItemAtIndexPath:indexPath animated:false scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];

    return view;
}

- (void)testCollectionViewDefaultSelected {
    UIView *lightView = [self createCollectionViewDefaultSelected];
    UIView *darkView = [self createCollectionViewDefaultSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

#pragma mark - <BPKBarChartCollectionViewDataSource>

- (NSString * _Nonnull)valueDescriptionForBarWithBarChartCollectionView:(BPKBarChartCollectionView * _Nonnull)barChartCollectionView atIndex:(NSIndexPath *)atIndex {
    if (atIndex.item == 0) {
        return @"No price";
    }
    return [NSString stringWithFormat:@"£%ld", atIndex.item + 1];
}

- (NSNumber *_Nullable)fillValueForBarWithBarChartCollectionView:(BPKBarChartCollectionView * _Nonnull)barChartCollectionView atIndex:(NSIndexPath *)atIndex {
    if (atIndex.item == 0) {
        return nil;
    }
    return [[NSNumber alloc] initWithFloat:atIndex.item * 0.1];
}

- (NSString * _Nonnull)subtitleForBarWithBarChartCollectionView:(BPKBarChartCollectionView * _Nonnull)barChartCollectionView atIndex:(NSIndexPath *)atIndex {
    return [NSString stringWithFormat:@"%ld", atIndex.item + 1];
}

- (NSString * _Nonnull)titleForBarWithBarChartCollectionView:(BPKBarChartCollectionView * _Nonnull)barChartCollectionView atIndex:(NSIndexPath *)atIndex {
    NSString *weekdays[14] = {@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun"};
    return weekdays[atIndex.item];
}

- (NSInteger)numberOfBarsInSectionWithBarChartCollectionView:(BPKBarChartCollectionView * _Nonnull)barChartCollectionView section:(NSInteger)section {
    return 10;
}


- (NSInteger)numberOfSectionsInChartWithBarChartCollectionView:(BPKBarChartCollectionView * _Nonnull)barChartCollectionView {
    return 2;
}


- (NSString * _Nonnull)titleForSectionWithBarChartCollectionView:(BPKBarChartCollectionView * _Nonnull)barChartCollectionView section:(NSInteger)section {
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
