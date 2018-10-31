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
#import <Backpack/Label.h>
#import <Backpack/Color.h>

@interface BPKLabelTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKLabelTest

- (void)testInitWithFontStyleWithTracking {
    BPKFontStyle styles[] = {
        BPKFontStyleTextXs, BPKFontStyleTextXsEmphasized,
        BPKFontStyleTextCaps, BPKFontStyleTextCapsEmphasized,
        BPKFontStyleTextSm, BPKFontStyleTextSmEmphasized,
        BPKFontStyleTextBase, BPKFontStyleTextBaseEmphasized,
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);
    UIColor *expectedColor = [BPKColor gray700];

    for (NSUInteger i = 0; i < length; i++) {
        BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:styles[i]];
        label.text = @"Hello world";

        NSAttributedString *attributedString = label.attributedText;
        NSRange range = NSMakeRange(0, label.text.length);
        NSDictionary *attributes = [attributedString attributesAtIndex:0 effectiveRange:&range];

        XCTAssertNotNil(attributes[NSKernAttributeName]);
        XCTAssertNotNil(attributes[NSFontAttributeName]);
        XCTAssertEqualObjects(attributes[NSForegroundColorAttributeName], expectedColor);
        XCTAssertNil(attributes[NSParagraphStyleAttributeName], @"BPKFont's attributedString should not have a paragraph style. Adding one is a breaking chagne.");
    }
}

- (void)testInitWithFontStyleWithoutTracking {
    BPKFontStyle styles[] = {
        BPKFontStyleTextLg, BPKFontStyleTextLgEmphasized,
        BPKFontStyleTextXl, BPKFontStyleTextXlEmphasized, BPKFontStyleTextXlHeavy,
        BPKFontStyleTextXxl, BPKFontStyleTextXxlEmphasized, BPKFontStyleTextXxlHeavy,
        BPKFontStyleTextXxxl, BPKFontStyleTextXxxlEmphasized, BPKFontStyleTextXxxlHeavy,
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);
    UIColor *expectedColor = [BPKColor gray700];

    for (NSUInteger i = 0; i < length; i++) {
        BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:styles[i]];
        label.text = @"Hello world";

        NSAttributedString *attributedString = label.attributedText;
        NSRange range = NSMakeRange(0, label.text.length);
        NSDictionary *attributes = [attributedString attributesAtIndex:0 effectiveRange:&range];

        XCTAssertNil(attributes[NSKernAttributeName]);
        XCTAssertNotNil(attributes[NSFontAttributeName]);
        XCTAssertEqualObjects(attributes[NSForegroundColorAttributeName], expectedColor);
        XCTAssertNil(attributes[NSParagraphStyleAttributeName], @"BPKFont's attributedString should not have a paragraph style. Adding one is a breaking chagne.");
    }
}


@end

NS_ASSUME_NONNULL_END
