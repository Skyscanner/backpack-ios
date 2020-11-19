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

#import <XCTest/XCTest.h>

#import <Backpack/Color.h>
#import <Backpack/Icon.h>

@interface BPKIconTest : XCTestCase

@end

@implementation BPKIconTest

- (void)testCreateWithEnum {
    UIImage *rendered = [BPKIcon iconNamed:BPKIconNameFlag color:BPKColor.systemRed size:BPKIconSizeLarge];

    XCTAssertNotNil(rendered);
}

- (void)testCreateSmallWithEnum {
    UIImage *rendered = [BPKIcon smallIconNamed:BPKSmallIconNameFlag color:BPKColor.systemRed];

    XCTAssertNotNil(rendered);
}

- (void)testCreateLargeWithEnum {
    UIImage *rendered = [BPKIcon largeIconNamed:BPKLargeIconNameFlag color:BPKColor.systemRed];

    XCTAssertNotNil(rendered);
}

- (void)testCreateXlWithEnum {
    UIImage *rendered = [BPKIcon xlIconNamed:BPKXlIconNameStarHalf color:BPKColor.systemRed];

    XCTAssertNotNil(rendered);
}

@end
