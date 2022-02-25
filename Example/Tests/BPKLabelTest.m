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
        BPKFontStyleTextHero1,
        BPKFontStyleTextHero2,
        BPKFontStyleTextHero3,
        BPKFontStyleTextHero4,
        BPKFontStyleTextHero5,
        BPKFontStyleTextHeading5,
        BPKFontStyleTextHeading4,
        BPKFontStyleTextHeading3,
        BPKFontStyleTextHeading2,
        BPKFontStyleTextHeading1,
        BPKFontStyleTextSubheading,
        BPKFontStyleTextBodyLongform,
        BPKFontStyleTextBodyDefault,
        BPKFontStyleTextLabel2,
        BPKFontStyleTextLabel1,
        BPKFontStyleTextFootnote,
        BPKFontStyleTextCaption
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);
    UIColor *expectedColor = BPKColor.textPrimaryColor;

    for (NSUInteger i = 0; i < length; i++) {
        BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:styles[i]];
        label.text = @"Hello world";

        NSAttributedString *attributedString = label.attributedText;
        NSRange range = NSMakeRange(0, label.text.length);
        NSDictionary *attributes = [attributedString attributesAtIndex:0 effectiveRange:&range];

        XCTAssertNotNil(attributes[NSFontAttributeName]);
        XCTAssertEqualObjects(attributes[NSForegroundColorAttributeName], expectedColor);
    }
}

- (void)testSettingFontStyleForRangeDoesntChangeText {
    NSRange range1 = NSMakeRange(0, 5);
    NSRange range2 = NSMakeRange(10, 5);
    NSRange range3 = NSMakeRange(20, 5);

    NSString *sampleText1 = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
    NSString *sampleText2 = @"consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt...";

    BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];

    label.text = sampleText1;
    [label setFontStyle:BPKFontStyleTextBodyLongform range:range1];

    label.text = sampleText2;
    [label setFontStyle:BPKFontStyleTextHeading1 range:range2];

    [label setFontStyle:BPKFontStyleTextHeading2 range:range3];

    NSMutableDictionary<NSAttributedStringKey, id> *range1Attributes = [[label.attributedText attributesAtIndex:range1.location + 1 effectiveRange:&range1] mutableCopy];
    NSMutableDictionary<NSAttributedStringKey, id> *range2Attributes = [[label.attributedText attributesAtIndex:range2.location + 1 effectiveRange:&range2] mutableCopy];
    NSMutableDictionary<NSAttributedStringKey, id> *range3Attributes = [[label.attributedText attributesAtIndex:range3.location + 1 effectiveRange:&range3] mutableCopy];
    
    // Needed because of the way paragraph style attribute is applied automatically by the system
    range1Attributes[NSParagraphStyleAttributeName] = nil;
    range2Attributes[NSParagraphStyleAttributeName] = nil;
    range3Attributes[NSParagraphStyleAttributeName] = nil;

    XCTAssertEqualObjects(label.text, sampleText2);
    XCTAssertEqualObjects(range1Attributes, [BPKFont attributesForFontStyle:BPKFontStyleTextBodyDefault]);
    XCTAssertEqualObjects(range2Attributes, [BPKFont attributesForFontStyle:BPKFontStyleTextHeading1]);
    XCTAssertEqualObjects(range3Attributes, [BPKFont attributesForFontStyle:BPKFontStyleTextHeading2]);
}

- (void)testCompareBackpackLabelSizeWithNativeLabel {
    UILabel *nativeLabel = [[UILabel alloc] init];
    nativeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nativeLabel.numberOfLines = 0;
    nativeLabel.textAlignment = NSTextAlignmentCenter;
    nativeLabel.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextCaption content:@"SDIJSOIFSJFO"];
    CGSize nativeLabelSize = [nativeLabel systemLayoutSizeFittingSize:CGSizeMake(12, 120)
                                        withHorizontalFittingPriority:UILayoutPriorityRequired
                                              verticalFittingPriority:UILayoutPriorityFittingSizeLevel];

    BPKLabel *bpkLabel = [[BPKLabel alloc] init];
    bpkLabel.lineBreakMode = NSLineBreakByWordWrapping;
    bpkLabel.numberOfLines = 0;
    bpkLabel.textAlignment = NSTextAlignmentCenter;
    bpkLabel.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextCaption content:@"SDIJSOIFSJFO"];
    CGSize bpkLabelSize = [nativeLabel systemLayoutSizeFittingSize:CGSizeMake(12, 120)
                                     withHorizontalFittingPriority:UILayoutPriorityRequired
                                           verticalFittingPriority:UILayoutPriorityFittingSizeLevel];

    XCTAssertEqual(nativeLabelSize.width, bpkLabelSize.width);
    XCTAssertEqual(nativeLabelSize.height, bpkLabelSize.height);
}

@end

NS_ASSUME_NONNULL_END
