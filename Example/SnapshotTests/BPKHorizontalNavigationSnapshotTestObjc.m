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
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@import Backpack;

#import "BPKSnapshotTest.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKHorizontalNavigationSnapshotTestObjc : FBSnapshotTestCase
@end

@implementation BPKHorizontalNavigationSnapshotTestObjc

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)displayHorizontalNavigation:(BPKHorizontalNavigationObjc *)horizontalNavigation width:(CGFloat)width {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = BPKColor.white;

    CGSize fittingSize = [horizontalNavigation systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    if (width > -1) {
        fittingSize.width = width;
    }
    horizontalNavigation.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);

    [view addSubview:horizontalNavigation];
    view.frame = horizontalNavigation.frame;

    return view;
}

- (UIView *)createDefault {
    NSArray<id<BPKHorizontalNavigationOptionTypeObjc>> *options = @[
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Flights" tag:0 iconName:nil],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Hotels" tag:1 iconName:nil],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Car hire" tag:2 iconName:nil]
    ];
    BPKHorizontalNavigationObjc *horizontalNavigation = [[BPKHorizontalNavigationObjc alloc] initWithOptions:options selectedItemIndex:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    return view;
}

- (void)testDefault {
    UIView *lightView = [self createDefault];
    UIView *darkView = [self createDefault];
    darkView.backgroundColor = BPKColor.backgroundDarkColor;

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createSelectedIndex {
    NSArray<id<BPKHorizontalNavigationOptionTypeObjc>> *options = @[
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Flights" tag:0 iconName:nil],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Hotels" tag:1 iconName:nil],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Car hire" tag:2 iconName:nil]
    ];
    BPKHorizontalNavigationObjc *horizontalNavigation = [[BPKHorizontalNavigationObjc alloc] initWithOptions:options selectedItemIndex:2];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    return view;
}

- (void)testSelectedIndex {
    UIView *lightView = [self createSelectedIndex];
    UIView *darkView = [self createSelectedIndex];
    darkView.backgroundColor = BPKColor.backgroundDarkColor;

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createWithoutBar {
    NSArray<id<BPKHorizontalNavigationOptionTypeObjc>> *options = @[
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Flights" tag:0 iconName:nil],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Hotels" tag:1 iconName:nil],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Car hire" tag:2 iconName:nil]
    ];
    BPKHorizontalNavigationObjc *horizontalNavigation = [[BPKHorizontalNavigationObjc alloc] initWithOptions:options selectedItemIndex:0];
    horizontalNavigation.showsSelectedBar = NO;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    return view;
}

- (void)testWithoutBar {
    UIView *lightView = [self createWithoutBar];
    UIView *darkView = [self createWithoutBar];
    darkView.backgroundColor = BPKColor.backgroundDarkColor;

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createWithIcons {
    NSArray<id<BPKHorizontalNavigationOptionTypeObjc>> *options = @[
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Flights" tag:0 iconName:BPKLargeIconNameFlight],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Hotels" tag:1 iconName:BPKLargeIconNameHotels],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Car hire" tag:2 iconName:BPKLargeIconNameCars]
    ];
    BPKHorizontalNavigationObjc *horizontalNavigation = [[BPKHorizontalNavigationObjc alloc] initWithOptions:options selectedItemIndex:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    return view;
}

- (void)testWithIcons {
    UIView *lightView = [self createWithIcons];
    UIView *darkView = [self createWithIcons];
    darkView.backgroundColor = BPKColor.backgroundDarkColor;

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createWide {
    NSArray<BPKHorizontalNavigationOptionObjc *> *options = @[
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Flights" tag:0 iconName:BPKLargeIconNameFlight],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Hotels" tag:1 iconName:BPKLargeIconNameHotels],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Car hire" tag:2 iconName:BPKLargeIconNameCars]
    ];
    BPKHorizontalNavigationObjc *horizontalNavigation = [[BPKHorizontalNavigationObjc alloc] initWithOptions:options selectedItemIndex:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:550];
    return view;
}

- (void)testWide {
    UIView *lightView = [self createWide];
    UIView *darkView = [self createWide];
    darkView.backgroundColor = BPKColor.backgroundDarkColor;

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createNarrow {
    NSArray<BPKHorizontalNavigationOptionObjc *> *options = @[
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Flights" tag:0 iconName:BPKLargeIconNameFlight],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Hotels" tag:1 iconName:BPKLargeIconNameHotels],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Car hire" tag:2 iconName:BPKLargeIconNameCars]
    ];
    BPKHorizontalNavigationObjc *horizontalNavigation = [[BPKHorizontalNavigationObjc alloc] initWithOptions:options selectedItemIndex:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:200];
    return view;
}

- (void)testNarrow {
    UIView *lightView = [self createNarrow];
    UIView *darkView = [self createNarrow];
    darkView.backgroundColor = BPKColor.backgroundDarkColor;

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createWithAlternateAppearance {
    NSArray<BPKHorizontalNavigationOptionObjc *> *options = @[
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Flights" tag:0 iconName:BPKLargeIconNameFlight],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Hotels" tag:1 iconName:BPKLargeIconNameHotels],
        [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Car hire" tag:2 iconName:nil]
    ];
    BPKHorizontalNavigationObjc *horizontalNavigation = [[BPKHorizontalNavigationObjc alloc] initWithOptions:options selectedItemIndex:0];
    horizontalNavigation.showsSelectedBar = YES;
    horizontalNavigation.appearance = BPKHorizontalNavigationAppearanceAlternate;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    view.backgroundColor = BPKColor.skyGray;

    return view;
}

- (void)testWithAlternateAppearance {
    UIView *lightView = [self createWithAlternateAppearance];
    UIView *darkView = [self createWithAlternateAppearance];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end
NS_ASSUME_NONNULL_END
