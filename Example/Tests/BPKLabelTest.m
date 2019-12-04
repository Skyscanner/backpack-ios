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
#import <Backpack/Label.h>
#import <Backpack/Theme.h>
#import <XCTest/XCTest.h>

@interface BPKLabelTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKLabelTest

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
        BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:styles[i]];
        label.text = @"Hello world";

        NSAttributedString *attributedString = label.attributedText;
        NSRange range = NSMakeRange(0, label.text.length);
        NSDictionary *attributes = [attributedString attributesAtIndex:0 effectiveRange:&range];

        XCTAssertNil(attributes[NSKernAttributeName]);
        XCTAssertNotNil(attributes[NSFontAttributeName]);
        XCTAssertEqualObjects(attributes[NSForegroundColorAttributeName], expectedColor);
        XCTAssertNil(attributes[NSParagraphStyleAttributeName],
                     @"BPKFont's attributedString should not have a paragraph style. Adding one is a breaking chagne.");
    }
}

- (void)testSettingFontStyleForRangeDoesntChangeText {
    NSRange range1 = NSMakeRange(0, 5);
    NSRange range2 = NSMakeRange(10, 5);
    NSRange range3 = NSMakeRange(20, 5);

    NSString *sampleText1 = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
    NSString *sampleText2 = @"consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt...";

    BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];

    label.text = sampleText1;
    [label setFontStyle:BPKFontStyleTextLg range:range1];

    label.text = sampleText2;
    [label setFontStyle:BPKFontStyleTextXxxlHeavy range:range2];

    [label setFontStyle:BPKFontStyleTextXxlHeavy range:range3];

    NSDictionary<NSAttributedStringKey, id> *range1Attributes =
        [label.attributedText attributesAtIndex:range1.location + 1 effectiveRange:&range1];
    NSDictionary<NSAttributedStringKey, id> *range2Attributes =
        [label.attributedText attributesAtIndex:range2.location + 1 effectiveRange:&range2];
    NSDictionary<NSAttributedStringKey, id> *range3Attributes =
        [label.attributedText attributesAtIndex:range3.location + 1 effectiveRange:&range3];

    XCTAssertEqualObjects(label.text, sampleText2);
    XCTAssertEqualObjects(range1Attributes, [BPKFont attributesForFontStyle:BPKFontStyleTextBase]);
    XCTAssertEqualObjects(range2Attributes, [BPKFont attributesForFontStyle:BPKFontStyleTextXxxlHeavy]);
    XCTAssertEqualObjects(range3Attributes, [BPKFont attributesForFontStyle:BPKFontStyleTextXxlHeavy]);
}

- (void)testCompareBackpackLabelSizeWithNativeLabel {
    UILabel *nativeLabel = [[UILabel alloc] init];
    nativeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nativeLabel.numberOfLines = 0;
    nativeLabel.textAlignment = NSTextAlignmentCenter;
    nativeLabel.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextCapsEmphasized
                                                                content:@"SDIJSOIFSJFO"];
    CGSize nativeLabelSize = [nativeLabel systemLayoutSizeFittingSize:CGSizeMake(12, 120)
                                        withHorizontalFittingPriority:UILayoutPriorityRequired
                                              verticalFittingPriority:UILayoutPriorityFittingSizeLevel];

    BPKLabel *bpkLabel = [[BPKLabel alloc] init];
    bpkLabel.lineBreakMode = NSLineBreakByWordWrapping;
    bpkLabel.numberOfLines = 0;
    bpkLabel.textAlignment = NSTextAlignmentCenter;
    bpkLabel.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextCapsEmphasized
                                                             content:@"SDIJSOIFSJFO"];
    CGSize bpkLabelSize = [nativeLabel systemLayoutSizeFittingSize:CGSizeMake(12, 120)
                                     withHorizontalFittingPriority:UILayoutPriorityRequired
                                           verticalFittingPriority:UILayoutPriorityFittingSizeLevel];

    XCTAssertEqual(nativeLabelSize.width, bpkLabelSize.width);
    XCTAssertEqual(nativeLabelSize.height, bpkLabelSize.height);
}

@end

NS_ASSUME_NONNULL_END
