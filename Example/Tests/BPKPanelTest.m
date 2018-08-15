//
//  BPKPanelTest.m
//  Backpack_Tests
//
//  Created by Hugo Tunius on 15/08/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Backpack/Panel.h>

@interface BPKPanelTest : XCTestCase

@end

@implementation BPKPanelTest

- (void)testInitWithPadded {
    BPKPanel *p1 = [[BPKPanel alloc] initWithPadded:YES];
    XCTAssertTrue(p1.padded);

    BPKPanel *p2 = [[BPKPanel alloc] initWithPadded:NO];
    XCTAssertFalse(p2.padded);
}

@end
