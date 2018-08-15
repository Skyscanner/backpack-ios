//
//  BPKBadgeTest.m
//  Backpack_Tests
//
//  Created by Hugo Tunius on 15/08/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <Backpack/Badge.h>


@interface BPKBadgeTest : XCTestCase

@end

@implementation BPKBadgeTest

- (void)testInitWithTypeMessage {
    BPKBadge *badge = [[BPKBadge alloc] initWithType:BPKBadgeTypeSuccess message:@"Backpack rocks!"];

    XCTAssertEqual(badge.type, BPKBadgeTypeSuccess);
    XCTAssertEqualObjects(badge.message, @"Backpack rocks!");
}

@end
