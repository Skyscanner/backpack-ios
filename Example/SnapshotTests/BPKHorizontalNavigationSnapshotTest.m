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
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

#import <Backpack/Button.h>
#import <Backpack/HorizontalNavigation.h>
#import <Backpack/Icon.h>
#import <Backpack/Spacing.h>

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
    view.backgroundColor = UIColor.whiteColor;

    CGSize fittingSize = [horizontalNavigation systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    if (width > -1) {
        fittingSize.width = width;
    }
    horizontalNavigation.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);

    [view addSubview:horizontalNavigation];
    view.frame = horizontalNavigation.frame;

    return view;
}

- (void)testDefault {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    FBSnapshotVerifyView(view, nil);
}

- (void)testSelectedIndex {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:2];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    FBSnapshotVerifyView(view, nil);
}

- (void)testWithoutBar {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = NO;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    FBSnapshotVerifyView(view, nil);
}

- (void)testWithIcons {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" iconName:BPKIconNameFlight tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" iconName:BPKIconNameHotels tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" iconName:BPKIconNameCars tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    FBSnapshotVerifyView(view, nil);
}

- (void)testWithTheming {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" iconName:BPKIconNameFlight tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" iconName:BPKIconNameHotels tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" iconName:BPKIconNameCars tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = YES;

    horizontalNavigation.selectedColor = UIColor.orangeColor;
    horizontalNavigation.fontMapping = [[BPKFontMapping alloc] initWithFamily:@"SnellRoundhand"
                                                              regularFontFace:@"SnellRoundhand"
                                                             semiboldFontFace:@"SnellRoundhand-Bold"
                                                                heavyFontFace:@"SnellRoundhand-Black"];

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:-1.0];
    FBSnapshotVerifyView(view, nil);
}

- (void)testWide {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" iconName:BPKIconNameFlight tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" iconName:BPKIconNameHotels tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" iconName:BPKIconNameCars tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:550];
    FBSnapshotVerifyView(view, nil);
}

- (void)testNarrow {
    NSArray<BPKHorizontalNavigationOption *> *options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" iconName:BPKIconNameFlight tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" iconName:BPKIconNameHotels tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" iconName:BPKIconNameCars tag:2]
    ];
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options
                                                                                            selected:0];
    horizontalNavigation.showsSelectedBar = YES;

    UIView *view = [self displayHorizontalNavigation:horizontalNavigation width:200];
    FBSnapshotVerifyView(view, nil);
}

@end
NS_ASSUME_NONNULL_END
