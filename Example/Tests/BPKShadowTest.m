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

#import <Backpack/Shadow.h>


@interface BPKShadowTest : XCTestCase
@property(nonatomic, copy) NSArray<NSString *> *selectors;
@end

@implementation BPKShadowTest

- (void)setUp {
    self.selectors =  @[ @"shadowSm", @"shadowLg", @"shadowXl" ];
}

- (void)testExpectedShadowStylesAreAvailable {
    for (NSString *selectorString in self.selectors) {
        SEL selector = NSSelectorFromString(selectorString);
        XCTAssert([BPKShadow respondsToSelector:selector]);
        XCTAssertNotNil([BPKShadow performSelector:selector]);
    }
}

- (void)testStylesAreCached {
    BPKShadow *shadow1 = [BPKShadow shadowSm];
    BPKShadow *shadow2 = [BPKShadow shadowSm];
    XCTAssertEqual(shadow1, shadow2, @"BPKShadow should cache shadow styles");
}

@end
