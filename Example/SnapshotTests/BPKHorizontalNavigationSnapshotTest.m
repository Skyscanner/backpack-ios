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

#import <Backpack/Button.h>
#import <Backpack/Color.h>
#import <Backpack/HorizontalNavigation.h>
#import <Backpack/Icon.h>
#import <Backpack/Spacing.h>

#import "BPKSnapshotTest.h"
#import "BPKHorizontalNavigationOptionWithBackground.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKHorizontalNavigationSnapshotTest : FBSnapshotTestCase
@end

@implementation BPKHorizontalNavigationSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)displayHorizontalNavigation:(BPKHorizontalNavigation *)horizontalNavigation width:(CGFloat)width {
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
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    return view;
}

- (void)testDefault {
    UIView *lightView = [self createDefault];
    UIView *darkView = [self createDefault];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createSelectedIndex {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:2];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    return view;
}

- (void)testSelectedIndex {
    UIView *lightView = [self createSelectedIndex];
    UIView *darkView = [self createSelectedIndex];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createWithoutBar {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = NO;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    return view;
}

- (void)testWithoutBar {
    UIView *lightView = [self createWithoutBar];
    UIView *darkView = [self createWithoutBar];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createWithIcons {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" iconName:BPKIconNameFlight tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" iconName:BPKIconNameHotels tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" iconName:BPKIconNameCars tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    return view;
}

- (void)testWithIcons {
    UIView *lightView = [self createWithIcons];
    UIView *darkView = [self createWithIcons];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createWithTheming {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" iconName:BPKIconNameFlight tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" iconName:BPKIconNameHotels tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" iconName:BPKIconNameCars tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = YES;

    horizontalNavigation.selectedColor = UIColor.orangeColor;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    return view;
}

- (void)testWithTheming {
    UIView *lightView = [self createWithTheming];
    UIView *darkView = [self createWithTheming];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createWide {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" iconName:BPKIconNameFlight tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" iconName:BPKIconNameHotels tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" iconName:BPKIconNameCars tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:550];
    return view;
}

- (void)testWide {
    UIView *lightView = [self createWide];
    UIView *darkView = [self createWide];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createNarrow {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" iconName:BPKIconNameFlight tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" iconName:BPKIconNameHotels tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" iconName:BPKIconNameCars tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:200];
    return view;
}

- (void)testNarrow {
    UIView *lightView = [self createNarrow];
    UIView *darkView = [self createNarrow];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createCustomItems {
    NSArray<BPKHorizontalNavigationOptionWithBackground *> *options = @[
        [[BPKHorizontalNavigationOptionWithBackground alloc] initWithTitle:@"Flights" tag:0],
        [[BPKHorizontalNavigationOptionWithBackground alloc] initWithTitle:@"Hotels" tag:1],
        [[BPKHorizontalNavigationOptionWithBackground alloc] initWithTitle:@"Car hire" tag:2]
    ];

    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = NO;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    return view;
}

- (void)testCustomItems {
    UIView *lightView = [self createCustomItems];
    UIView *darkView = [self createCustomItems];
    darkView.backgroundColor = BPKColor.backgroundDarkColor;

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


@end
NS_ASSUME_NONNULL_END
