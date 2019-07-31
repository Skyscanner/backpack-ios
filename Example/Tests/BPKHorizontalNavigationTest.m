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

#import <XCTest/XCTest.h>

#import <Backpack/HorizontalNavigation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKHorizontalNavigationTest : XCTestCase

@end

@implementation BPKHorizontalNavigationTest

- (void)testInitWithOptions {
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:@[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
    ]
                                                                                            selected:0];

    XCTAssertEqual(horizontalNavigation.selectedItemIndex, 0);
    XCTAssertEqual(horizontalNavigation.options[0].name, @"Flights");
    XCTAssertEqual(horizontalNavigation.options[1].name, @"Hotels");
    XCTAssertEqual(horizontalNavigation.options[2].name, @"Car hire");
    XCTAssertEqual(horizontalNavigation.options[0].tag, 0);
    XCTAssertEqual(horizontalNavigation.options[1].tag, 1);
    XCTAssertEqual(horizontalNavigation.options[2].tag, 2);
}

- (void)testInitWithSelectedIndex {
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:@[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
    ]
                                                                                            selected:2];

    XCTAssertEqual(horizontalNavigation.selectedItemIndex, 2);
    XCTAssertEqual(horizontalNavigation.options[0].name, @"Flights");
    XCTAssertEqual(horizontalNavigation.options[1].name, @"Hotels");
    XCTAssertEqual(horizontalNavigation.options[2].name, @"Car hire");
}

- (void)testSetSelectedIndex {
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:@[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
    ]
                                                                                            selected:0];

    horizontalNavigation.selectedItemIndex = 1;

    XCTAssertEqual(horizontalNavigation.selectedItemIndex, 1);
    XCTAssertEqual(horizontalNavigation.options[0].name, @"Flights");
    XCTAssertEqual(horizontalNavigation.options[1].name, @"Hotels");
    XCTAssertEqual(horizontalNavigation.options[2].name, @"Car hire");
}

- (void)testSetOptions {
    BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:@[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag : 1],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
    ]
                                                                                            selected:0];

    horizontalNavigation.selectedItemIndex = 1;
    horizontalNavigation.options = @[
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights 2" tag : 3],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels 2" tag : 4],
        [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire 2" tag:5]
    ];

    XCTAssertEqual(horizontalNavigation.selectedItemIndex, 0);
    XCTAssertEqual(horizontalNavigation.options[0].name, @"Flights 2");
    XCTAssertEqual(horizontalNavigation.options[1].name, @"Hotels 2");
    XCTAssertEqual(horizontalNavigation.options[2].name, @"Car hire 2");
    XCTAssertEqual(horizontalNavigation.options[0].tag, 3);
    XCTAssertEqual(horizontalNavigation.options[1].tag, 4);
    XCTAssertEqual(horizontalNavigation.options[2].tag, 5);
}

@end

NS_ASSUME_NONNULL_END
