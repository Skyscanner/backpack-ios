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

    NSDictionary *attributes = [BPKFont attributesForFontStyle:BPKFontStyleTextBodyLongform
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

    NSDictionary *attributes = [BPKFont attributesForFontStyle:BPKFontStyleTextBodyLongform
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
    OCMStub([mockFontManager semiboldFontWithSize:20.0]).andReturn([UIFont fontWithName:@"SnellRoundhand-Bold" size:20.0]);
    OCMStub([mockFontManager semiboldFontWithSize:24.0]).andReturn([UIFont fontWithName:@"SnellRoundhand-Black" size:24.0]);

    NSDictionary *regularAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextBodyLongform fontManager:mockFontManager];
    NSDictionary *semiboldAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextHeading4 fontManager:mockFontManager];
    NSDictionary *heavyAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextHeading3 fontManager:mockFontManager];

    UIFont *resultingRegularFont = regularAttributes[NSFontAttributeName];
    UIFont *resultingSemiboldFont = semiboldAttributes[NSFontAttributeName];
    UIFont *resulingHeavyFont = heavyAttributes[NSFontAttributeName];

    XCTAssertEqualObjects(resultingRegularFont.fontName, @"SnellRoundhand");
    XCTAssertEqualObjects(resultingSemiboldFont.fontName, @"SnellRoundhand-Bold");
    XCTAssertEqualObjects(resulingHeavyFont.fontName, @"SnellRoundhand-Black");
}

- (void)testAttributedStringWithCustomFontFaces {
    NSAttributedString *attributedString = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextBodyLongform
                                                                          content:@"Test"
                                                                        textColor:UIColor.purpleColor];

    NSDictionary<NSAttributedStringKey, id> *attributes = [attributedString attributesAtIndex:0
                                                                        longestEffectiveRange:nil
                                                                                      inRange:NSMakeRange(0, attributedString.length)];
    XCTAssertNotEqualObjects(attributes[NSKernAttributeName], @1.5,
                             @"`attributedStringWithFontStyle:content:textColor:` should ignore `NSKernAttributeName`");
    XCTAssertEqualObjects(attributes[NSForegroundColorAttributeName], UIColor.purpleColor,
                          @"`attributedStringWithFontStyle:content:textColor:` should use provided `textColor`");
}

- (void)testFontWithStyle {
    BPKFontStyle styles[] = {BPKFontStyleTextBodyDefault, BPKFontStyleTextCaption,    BPKFontStyleTextBodyLongform, BPKFontStyleTextFootnote,
                             BPKFontStyleTextLabel2,      BPKFontStyleTextSubheading, BPKFontStyleTextHeading5,     BPKFontStyleTextHeading4,
                             BPKFontStyleTextHeading3,    BPKFontStyleTextHeading2,   BPKFontStyleTextHeading1};

    for (NSUInteger i = 0; i < sizeof(styles) / sizeof(styles[0]); i++) {
        BPKFontStyle style = styles[i];
        UIFont *font = [BPKFont fontForFontStyle:style];
        NSDictionary<NSAttributedStringKey, id> *attributes = [BPKFont attributesForFontStyle:style];

        XCTAssertNotNil([BPKFont fontForFontStyle:style]);
        XCTAssertEqualObjects(font, attributes[NSFontAttributeName]);
    }
}

@end

NS_ASSUME_NONNULL_END
