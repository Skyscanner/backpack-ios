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

#import <XCTest/XCTest.h>

#import <Backpack/Font.h>

@interface BPKFontTest : XCTestCase
@property(nonatomic, copy) NSArray<NSString *> *expectedSelectors;
@end

@implementation BPKFontTest

- (void)setUp {
    self.expectedSelectors = @[
                               @"textXs", @"textXsEmphasized",
                               @"textSm", @"textSmEmphasized",
                               @"textBase", @"textBaseEmphasized",
                               @"textLg", @"textLgEmphasized",
                               @"textXl", @"textXlEmphasized"
                            ];
}

- (void)testHasExpectedTextStyles {
    for (NSString *selector in self.expectedSelectors) {
        XCTAssert([BPKFont respondsToSelector:NSSelectorFromString(selector)], @"Expected BPKFont to have a textStyle called `%@`", selector);
    }
}

- (void)testExpectedTextStylesAreDefined {
    for (NSString *selector in self.expectedSelectors) {
        XCTAssertNotNil([BPKFont performSelector:NSSelectorFromString(selector)], @"Expected BPKFont to have a textStyle called `%@` that returns a valid value", selector);
    }

}

@end
