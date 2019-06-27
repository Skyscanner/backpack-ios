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

- (void)testSize {
    [self testStyle:BPKFontStyleTextXs fontMapping:nil hasApproximateSize:CGSizeMake(63.6, 14.3)];
    [self testStyle:BPKFontStyleTextXsEmphasized fontMapping:nil hasApproximateSize:CGSizeMake(66.6, 14.3)];
    [self testStyle:BPKFontStyleTextCaps fontMapping:nil hasApproximateSize:CGSizeMake(57.2, 11.9)];
    [self testStyle:BPKFontStyleTextCapsEmphasized fontMapping:nil hasApproximateSize:CGSizeMake(59.7, 11.9)];
    [self testStyle:BPKFontStyleTextSm fontMapping:nil hasApproximateSize:CGSizeMake(74.0, 16.7)];
    [self testStyle:BPKFontStyleTextSmEmphasized fontMapping:nil hasApproximateSize:CGSizeMake(77.6, 16.7)];
    [self testStyle:BPKFontStyleTextBase fontMapping:nil hasApproximateSize:CGSizeMake(82.4, 19.0)];
    [self testStyle:BPKFontStyleTextBaseEmphasized fontMapping:nil hasApproximateSize:CGSizeMake(86.4, 19.1)];
    [self testStyle:BPKFontStyleTextLg fontMapping:nil hasApproximateSize:CGSizeMake(97.3, 23.9)];
    [self testStyle:BPKFontStyleTextLgEmphasized fontMapping:nil hasApproximateSize:CGSizeMake(102.7, 23.9)];
    [self testStyle:BPKFontStyleTextXl fontMapping:nil hasApproximateSize:CGSizeMake(115.9, 28.6)];
    [self testStyle:BPKFontStyleTextXlEmphasized fontMapping:nil hasApproximateSize:CGSizeMake(122.4, 28.6)];
    [self testStyle:BPKFontStyleTextXlHeavy fontMapping:nil hasApproximateSize:CGSizeMake(131.6, 28.6)];
    [self testStyle:BPKFontStyleTextXxl fontMapping:nil hasApproximateSize:CGSizeMake(144.1, 35.8)];
    [self testStyle:BPKFontStyleTextXxlEmphasized fontMapping:nil hasApproximateSize:CGSizeMake(152.2, 35.8)];
    [self testStyle:BPKFontStyleTextXxlHeavy fontMapping:nil hasApproximateSize:CGSizeMake(163.7, 35.8)];
    [self testStyle:BPKFontStyleTextXxxl fontMapping:nil hasApproximateSize:CGSizeMake(172.3, 42.9)];
    [self testStyle:BPKFontStyleTextXxxlEmphasized fontMapping:nil hasApproximateSize:CGSizeMake(182.1, 42.9)];
    [self testStyle:BPKFontStyleTextXxxlHeavy fontMapping:nil hasApproximateSize:CGSizeMake(195.9, 42.9)];
}

- (void)testSizeWithThemeApplied {
    BPKFontMapping *fontMapping = [[BPKFontMapping alloc] initWithFamily:@"SnellRoundhand"
                                                         regularFontFace:@"SnellRoundhand"
                                                        semiboldFontFace:@"SnellRoundhand-Bold"
                                                           heavyFontFace:@"SnellRoundhand-Black"];

    [self testStyle:BPKFontStyleTextXs fontMapping:fontMapping hasApproximateSize:CGSizeMake(52.9, 15.1)];
    [self testStyle:BPKFontStyleTextXsEmphasized fontMapping:fontMapping hasApproximateSize:CGSizeMake(59.6, 15.1)];
    [self testStyle:BPKFontStyleTextCaps fontMapping:fontMapping hasApproximateSize:CGSizeMake(44.1, 12.6)];
    [self testStyle:BPKFontStyleTextCapsEmphasized fontMapping:fontMapping hasApproximateSize:CGSizeMake(49.7, 12.6)];
    [self testStyle:BPKFontStyleTextSm fontMapping:fontMapping hasApproximateSize:CGSizeMake(61.8, 17.6)];
    [self testStyle:BPKFontStyleTextSmEmphasized fontMapping:fontMapping hasApproximateSize:CGSizeMake(69.5, 17.6)];
    [self testStyle:BPKFontStyleTextBase fontMapping:fontMapping hasApproximateSize:CGSizeMake(70.6, 20.2)];
    [self testStyle:BPKFontStyleTextBaseEmphasized fontMapping:fontMapping hasApproximateSize:CGSizeMake(79.5, 20.1)];
    [self testStyle:BPKFontStyleTextLg fontMapping:fontMapping hasApproximateSize:CGSizeMake(88.2, 25.2)];
    [self testStyle:BPKFontStyleTextLgEmphasized fontMapping:fontMapping hasApproximateSize:CGSizeMake(99.4, 25.2)];
    [self testStyle:BPKFontStyleTextXl fontMapping:fontMapping hasApproximateSize:CGSizeMake(105.9, 30.3)];
    [self testStyle:BPKFontStyleTextXlEmphasized fontMapping:fontMapping hasApproximateSize:CGSizeMake(119.28, 30.3)];
    [self testStyle:BPKFontStyleTextXlHeavy fontMapping:fontMapping hasApproximateSize:CGSizeMake(130.0, 30.3)];
    [self testStyle:BPKFontStyleTextXxl fontMapping:fontMapping hasApproximateSize:CGSizeMake(132.4, 37.8)];
    [self testStyle:BPKFontStyleTextXxlEmphasized fontMapping:fontMapping hasApproximateSize:CGSizeMake(149.1, 37.8)];
    [self testStyle:BPKFontStyleTextXxlHeavy fontMapping:fontMapping hasApproximateSize:CGSizeMake(162.5, 37.8)];
    [self testStyle:BPKFontStyleTextXxxl fontMapping:fontMapping hasApproximateSize:CGSizeMake(158.9, 45.4)];
    [self testStyle:BPKFontStyleTextXxxlEmphasized fontMapping:fontMapping hasApproximateSize:CGSizeMake(178.9, 45.4)];
    [self testStyle:BPKFontStyleTextXxxlHeavy fontMapping:fontMapping hasApproximateSize:CGSizeMake(195.0, 45.4)];
}

- (void)testStyle:(BPKFontStyle)fontStyle
           fontMapping:(BPKFontMapping *_Nullable)fontMapping
    hasApproximateSize:(CGSize)size {
    BPKTappableLinkLabel *label = [[BPKTappableLinkLabel alloc] initWithFontStyle:fontStyle];
    label.fontMapping = fontMapping;
    label.text = @"Hello world";
    [label addLinkToURL:[NSURL URLWithString:@"https"] withRange:NSMakeRange(0, 5)];

    XCTAssert(fabs(label.size.width - size.width) < 1.0);
    XCTAssert(fabs(label.size.height - size.height) < 1.0);
}

@end

NS_ASSUME_NONNULL_END
