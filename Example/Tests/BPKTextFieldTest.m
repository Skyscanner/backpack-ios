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
#import <Backpack/TextField.h>

#import <XCTest/XCTest.h>

@interface BPKTextFieldTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKTextFieldTest

- (void)testInitWithFontStyle {
    BPKFontStyle styles[] = {
        BPKFontStyleTextLg,
        BPKFontStyleTextLgEmphasized,
        BPKFontStyleTextXl,
        BPKFontStyleTextXlEmphasized,
        BPKFontStyleTextXlHeavy,
        BPKFontStyleTextXxl,
        BPKFontStyleTextXxlEmphasized,
        BPKFontStyleTextXxlHeavy,
        BPKFontStyleTextXxxl,
        BPKFontStyleTextXxxlEmphasized,
        BPKFontStyleTextXxxlHeavy,
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);
    UIColor *expectedColor = BPKColor.textPrimaryColor;

    for (NSUInteger i = 0; i < length; i++) {
        BPKTextField *textField = [[BPKTextField alloc] initWithFontStyle:styles[i]];
        textField.text = @"Hello world";

        NSAttributedString *attributedString = textField.attributedText;
        NSRange range = NSMakeRange(0, textField.text.length);
        NSDictionary *attributes = [attributedString attributesAtIndex:0 effectiveRange:&range];

        XCTAssertNotNil(attributes[NSFontAttributeName]);
        XCTAssertEqualObjects(attributes[NSForegroundColorAttributeName], expectedColor);
    }
}

@end

NS_ASSUME_NONNULL_END
