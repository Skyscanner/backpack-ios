/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import <Backpack/Color.h>
#import <Backpack/Icon.h>

@interface BPKIconViewTest : XCTestCase

@end

@implementation BPKIconViewTest

- (void)testSmallIconViewInitWithFrame {
    BPKSmallIconView *iconView = [[BPKSmallIconView alloc] initWithFrame:CGRectZero];

    XCTAssertEqual(iconView.size, BPKIconSizeSmall);
}

- (void)testLargeIconViewInitWithFrame {
    BPKLargeIconView *iconView = [[BPKLargeIconView alloc] initWithFrame:CGRectZero];

    XCTAssertEqual(iconView.size, BPKIconSizeLarge);
}

- (void)testExtraLargeIconViewInitWithFrame {
    BPKXlIconView *iconView = [[BPKXlIconView alloc] initWithFrame:CGRectZero];

    XCTAssertEqual(iconView.size, BPKIconSizeXLarge);
}

- (void)testSmallIconViewInitWithIconName {
    BPKSmallIconView *iconView = [[BPKSmallIconView alloc] initWithIconName:BPKSmallIconNameStar];

    XCTAssertEqual(iconView.size, BPKIconSizeSmall);
}

- (void)testLargeIconViewInitWithIconName {
    BPKLargeIconView *iconView = [[BPKLargeIconView alloc] initWithIconName:BPKLargeIconNameStar];

    XCTAssertEqual(iconView.size, BPKIconSizeLarge);
}

- (void)testExtraLargeIconViewInitWithIconName {
    BPKXlIconView *iconView = [[BPKXlIconView alloc] initWithIconName:BPKXlIconNameStar];

    XCTAssertEqual(iconView.size, BPKIconSizeXLarge);
}

@end
