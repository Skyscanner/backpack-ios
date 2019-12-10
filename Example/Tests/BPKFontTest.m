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

#import <Backpack/BPKFontManager.h>
#import <Backpack/Font.h>
#import <OCMock/OCMock.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKFontTest : XCTestCase
@property(nonatomic, copy) NSArray<NSString *> *expectedSelectors;
@end

@implementation BPKFontTest

- (void)testAttributesForFontStyleWithCustomAttributes {
    UIFont *font = [UIFont systemFontOfSize:120.0];

    NSDictionary *attributes = [BPKFont attributesForFontStyle:BPKFontStyleTextLg
                                          withCustomAttributes:@{
                                              NSKernAttributeName: @1.5,
                                              NSFontAttributeName: font,
                                              NSForegroundColorAttributeName: UIColor.redColor,
                                          }];

    XCTAssertNotEqualObjects(attributes[NSKernAttributeName], @1.5,
                             @"`attributesForFontStyle:withCustomAttributes:` should ignore `NSKernAttributeName`");
    XCTAssertNotEqualObjects(attributes[NSFontAttributeName], font,
                             @"`attributesForFontStyle:withCustomAttributes:` should ignore `NSFontAttributeName`");
    XCTAssertEqualObjects(attributes[NSForegroundColorAttributeName], UIColor.redColor);
}

- (void)testAttributesForFontStyleWithCustomFontFacesAndCustomAttributes {
    UIFont *font = [UIFont systemFontOfSize:120.0];

    NSDictionary *attributes = [BPKFont attributesForFontStyle:BPKFontStyleTextLg
                                          withCustomAttributes:@{
                                              NSKernAttributeName: @1.5,
                                              NSFontAttributeName: font,
                                              NSForegroundColorAttributeName: UIColor.redColor,
                                          }];

    XCTAssertNotEqualObjects(attributes[NSKernAttributeName], @1.5,
                             @"`attributesForFontStyle:withCustomAttributes:` should ignore `NSKernAttributeName`");
    XCTAssertNotEqualObjects(attributes[NSFontAttributeName], font,
                             @"`attributesForFontStyle:withCustomAttributes:` should ignore `NSFontAttributeName`");
    XCTAssertEqualObjects(attributes[NSForegroundColorAttributeName], UIColor.redColor);
}

- (void)testAttributesForFontStyleWithCustomFontDefinitionInjected {
    BPKFontManager *mockFontManager = OCMClassMock(BPKFontManager.class);
    OCMStub([mockFontManager regularFontWithSize:20.0]).andReturn([UIFont fontWithName:@"SnellRoundhand" size:16.0]);
    OCMStub([mockFontManager semiboldFontWithSize:20.0])
        .andReturn([UIFont fontWithName:@"SnellRoundhand-Bold" size:20.0]);
    OCMStub([mockFontManager heavyFontWithSize:24.0])
        .andReturn([UIFont fontWithName:@"SnellRoundhand-Black" size:24.0]);
    OCMStub([mockFontManager cacheKey]).andReturn(@"42CY87T");

    NSDictionary *regularAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextLg fontManager:mockFontManager];
    NSDictionary *semiboldAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextLgEmphasized
                                                           fontManager:mockFontManager];
    NSDictionary *heavyAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextXlHeavy
                                                        fontManager:mockFontManager];

    UIFont *resultingRegularFont = regularAttributes[NSFontAttributeName];
    UIFont *resultingSemiboldFont = semiboldAttributes[NSFontAttributeName];
    UIFont *resulingHeavyFont = heavyAttributes[NSFontAttributeName];

    XCTAssertEqualObjects(resultingRegularFont.fontName, @"SnellRoundhand");
    XCTAssertEqualObjects(resultingSemiboldFont.fontName, @"SnellRoundhand-Bold");
    XCTAssertEqualObjects(resulingHeavyFont.fontName, @"SnellRoundhand-Black");
}

- (void)testAttributedStringWithCustomFontFaces {
    NSAttributedString *attributedString = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextLg
                                                                          content:@"Test"
                                                                        textColor:UIColor.purpleColor];

    NSDictionary<NSAttributedStringKey, id> *attributes =
        [attributedString attributesAtIndex:0
                      longestEffectiveRange:nil
                                    inRange:NSMakeRange(0, attributedString.length)];
    XCTAssertNotEqualObjects(attributes[NSKernAttributeName], @1.5,
                             @"`attributedStringWithFontStyle:content:textColor:` should ignore `NSKernAttributeName`");
    XCTAssertEqualObjects(attributes[NSForegroundColorAttributeName], UIColor.purpleColor,
                          @"`attributedStringWithFontStyle:content:textColor:` should use provided `textColor`");
}

- (void)testFontWithStyle {
    /*
    XCTAssertEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextXs], [BPKFont textXs]);
    XCTAssertEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextXsEmphasized], [BPKFont textXsEmphasized]);

    XCTAssertEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextSm], [BPKFont textSm]);
    XCTAssertEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextSmEmphasized], [BPKFont textSmEmphasized]);

    XCTAssertEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextBase], [BPKFont textBase]);
    XCTAssertEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextBaseEmphasized], [BPKFont textBaseEmphasized]);

    XCTAssertEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextLg], [BPKFont textLg]);
    XCTAssertEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextLgEmphasized], [BPKFont textLgEmphasized]);

    XCTAssertEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextXl], [BPKFont textXl]);
    XCTAssertEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextXlEmphasized], [BPKFont textXlEmphasized]);

    // Small sanity checks
    XCTAssertNotEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextXl], [BPKFont fontWithStyle:BPKFontStyleTextLg]);
    XCTAssertNotEqualObjects([BPKFont fontWithStyle:BPKFontStyleTextSm], [BPKFont fontWithStyle:BPKFontStyleTextBase]);
     */
}

- (void)testStableFontStyles {
    XCTAssertEqual(BPKFontStyleTextBase, 0);
    XCTAssertEqual(BPKFontStyleTextBaseEmphasized, 1);
    XCTAssertEqual(BPKFontStyleTextLg, 2);
    XCTAssertEqual(BPKFontStyleTextLgEmphasized, 3);
    XCTAssertEqual(BPKFontStyleTextSm, 4);
    XCTAssertEqual(BPKFontStyleTextSmEmphasized, 5);
    XCTAssertEqual(BPKFontStyleTextXl, 6);
    XCTAssertEqual(BPKFontStyleTextXlEmphasized, 7);
    XCTAssertEqual(BPKFontStyleTextXs, 8);
    XCTAssertEqual(BPKFontStyleTextXsEmphasized, 9);
}

@end

NS_ASSUME_NONNULL_END
