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

- (void)testSizeWithThemeApplied {
    BPKFontMapping *fontMapping = [[BPKFontMapping alloc] initWithFamily:@"SnellRoundhand"
                                                         regularFontFace:@"SnellRoundhand"
                                                        semiboldFontFace:@"SnellRoundhand-Bold"
                                                           heavyFontFace:@"SnellRoundhand-Black"];

    [self testLabelSizeWithStyle:BPKFontStyleTextXs fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextXsEmphasized fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextCaps fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextCapsEmphasized fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextSm fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextSmEmphasized fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextBase fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextBaseEmphasized fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextLg fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextLgEmphasized fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextXl fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextXlEmphasized fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextXlHeavy fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextXxl fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextXxlEmphasized fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextXxlHeavy fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextXxxl fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextXxxlEmphasized fontMapping:fontMapping];
    [self testLabelSizeWithStyle:BPKFontStyleTextXxxlHeavy fontMapping:fontMapping];
}

- (void)testSizeWithAlternateStyle {
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextXs];
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextCaps];
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextSm];
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextBase];
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextLg];
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextXl];
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextXlEmphasized];
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextXxl];
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextXxlEmphasized];
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextXxxl];
    [self testAlternateLabelSizeWithStyle:BPKFontStyleTextXxxlEmphasized];
}

- (void)testLabelSizeWithStyle:(BPKFontStyle)fontStyle fontMapping:(BPKFontMapping *_Nullable)fontMapping {
    BPKTappableLinkLabel *label = [[BPKTappableLinkLabel alloc] initWithFontStyle:fontStyle];
    label.text = @"Hello world";
    [label addLinkToURL:[NSURL URLWithString:@"https"] withRange:NSMakeRange(0, 5)];
    CGSize sizeWithoutFontMapping = label.size;

    label.fontMapping = fontMapping;
    CGSize sizeWithFontMapping = label.size;

    XCTAssert(fabs(sizeWithoutFontMapping.width - sizeWithFontMapping.width) > 0.01);
    XCTAssert(fabs(sizeWithoutFontMapping.height - sizeWithFontMapping.height) > 0.01);
}

- (void)testAlternateLabelSizeWithStyle:(BPKFontStyle)fontStyle {
    BPKTappableLinkLabel *label = [[BPKTappableLinkLabel alloc] initWithFontStyle:fontStyle];
    label.text = @"Hello world";
    [label addLinkToURL:[NSURL URLWithString:@"https"] withRange:NSMakeRange(0, 5)];
    CGSize sizeWithDefaultStyle = label.size;

    label.style = BPKTappableLinkLabelStyleAlternate;
    CGSize sizeWithAlternateStyle = label.size;

    XCTAssert(sizeWithDefaultStyle.width < sizeWithAlternateStyle.width);
}

@end

NS_ASSUME_NONNULL_END
