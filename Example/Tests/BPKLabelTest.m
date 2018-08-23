//
//  BPKLabelTest.m
//  Backpack_Tests
//
//  Created by Hugo Tunius on 2018-08-23.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Backpack/Label.h>
#import <Backpack/Color.h>

@interface BPKLabelTest : XCTestCase

@end

@implementation BPKLabelTest

- (void)testInitWithFontStyle {
    BPKFontStyle styles[] = {
        BPKFontStyleTextBase, BPKFontStyleTextBaseEmphasized,
        BPKFontStyleTextLg, BPKFontStyleTextLgEmphasized,
        BPKFontStyleTextSm, BPKFontStyleTextSmEmphasized,
        BPKFontStyleTextXl, BPKFontStyleTextXlEmphasized,
        BPKFontStyleTextXs, BPKFontStyleTextXsEmphasized
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);
    UIColor *expectedColor = [BPKColor gray700];

    for (NSUInteger i = 0; i < length; i++) {
        BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:styles[i]];
        UIFont *labelFont = label.font;
        UIFont *expectedFont = [BPKFont fontWithStyle:styles[i]];

        XCTAssertEqualObjects(labelFont, expectedFont);
        XCTAssertEqualObjects(label.textColor, expectedColor);
    }
}
@end
