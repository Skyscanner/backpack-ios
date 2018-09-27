//
//  BPKIconTest.m
//  Backpack_Tests
//
//  Created by Hugo Tunius on 27/09/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <Backpack/Icon.h>
#import <Backpack/Color.h>

@interface BPKIconTest : XCTestCase

@end

@implementation BPKIconTest

- (void)testCreateWithEnum {
    UIImage *rendered = [BPKIcon iconNamed:BPKIconNameFlag color:BPKColor.red500 size:BPKIconSizeLarge];

    XCTAssertNotNil(rendered);
}

@end
