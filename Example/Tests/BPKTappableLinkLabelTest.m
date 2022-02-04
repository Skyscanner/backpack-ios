/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

#import <Backpack/Color.h>
#import <Backpack/TappableLinkLabel.h>

#import <XCTest/XCTest.h>

@interface BPKTappableLinkLabelTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKTappableLinkLabelTest

- (void)testSettingText {
    BPKTappableLinkLabel *label = [[BPKTappableLinkLabel alloc] initWithFrame:CGRectZero];
    label.text = @"Hello world";
    [label addLinkToURL:[NSURL URLWithString:@"https"] withRange:NSMakeRange(0, 5)];

    XCTAssertEqualObjects(label.text, @"Hello world");
}

@end

NS_ASSUME_NONNULL_END
