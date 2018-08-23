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

- (void)testFontWithStyle {
    // These tests rely on internal pointer caching by UIFont which is why pointer
    // equality can be used to compare the results. If this starts to break
    XCTAssertEqual([BPKFont fontWithStyle:BPKFontStyleTextXs], [BPKFont textXs]);
    XCTAssertEqual([BPKFont fontWithStyle:BPKFontStyleTextXsEmphasized], [BPKFont textXsEmphasized]);

    XCTAssertEqual([BPKFont fontWithStyle:BPKFontStyleTextSm], [BPKFont textSm]);
    XCTAssertEqual([BPKFont fontWithStyle:BPKFontStyleTextSmEmphasized], [BPKFont textSmEmphasized]);

    XCTAssertEqual([BPKFont fontWithStyle:BPKFontStyleTextBase], [BPKFont textBase]);
    XCTAssertEqual([BPKFont fontWithStyle:BPKFontStyleTextBaseEmphasized], [BPKFont textBaseEmphasized]);

    XCTAssertEqual([BPKFont fontWithStyle:BPKFontStyleTextLg], [BPKFont textLg]);
    XCTAssertEqual([BPKFont fontWithStyle:BPKFontStyleTextLgEmphasized], [BPKFont textLgEmphasized]);

    XCTAssertEqual([BPKFont fontWithStyle:BPKFontStyleTextXl], [BPKFont textXl]);
    XCTAssertEqual([BPKFont fontWithStyle:BPKFontStyleTextXlEmphasized], [BPKFont textXlEmphasized]);

    // Small sanity checks
    XCTAssertNotEqual([BPKFont fontWithStyle:BPKFontStyleTextXl], [BPKFont fontWithStyle:BPKFontStyleTextLg]);
    XCTAssertNotEqual([BPKFont fontWithStyle:BPKFontStyleTextSm], [BPKFont fontWithStyle:BPKFontStyleTextBase]);
}

@end
