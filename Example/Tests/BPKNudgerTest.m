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
#import <Backpack/Nudger.h>
#import <Backpack/Theme.h>
#import <XCTest/XCTest.h>

@interface BPKNudgerTest : XCTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKNudgerTest

-(BPKNudgerConfiguration *)nudgerConfiguration {
    BPKNudgerConfiguration *nudgerConfiguration = [[BPKNudgerConfiguration alloc]
                                                   initWithLabel:@"Passengers"
                                                   valueFormatter:^(double value) {
            return [NSNumberFormatter localizedStringFromNumber:@(value) numberStyle:NSNumberFormatterDecimalStyle];
        }
    ];
    return nudgerConfiguration;
}

- (void)testNudgerConfigurationIsAppliedToControl {
    BPKNudgerConfiguration *nudgerConfiguration = [self nudgerConfiguration];
    BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];

    UILabel *label = [nudger performSelector:@selector(label)];
    XCTAssertTrue([label.text isEqualToString:@"0"]);
    XCTAssertEqualObjects(nudger.accessibilityValue, @"0");
    XCTAssertEqualObjects(nudger.accessibilityLabel, @"Passengers");
}

- (void)testHasAdjustableAccessibilityTrait {
    BPKNudgerConfiguration *nudgerConfiguration = [self nudgerConfiguration];
    BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];

    XCTAssertTrue((nudger.accessibilityTraits & UIAccessibilityTraitAdjustable) == UIAccessibilityTraitAdjustable);
}

- (void)testSettingMinimumValueCausesValueToAlign {
    BPKNudgerConfiguration *nudgerConfiguration = [self nudgerConfiguration];
    BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];
    nudger.value = 1;
    nudger.minimumValue = 5;

    XCTAssertEqual(nudger.value, 5);
}

- (void)testSettingMaximumValueCausesValueToAlign {
    BPKNudgerConfiguration *nudgerConfiguration = [self nudgerConfiguration];
    BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];
    nudger.value = 10;
    nudger.maximumValue = 5;

    XCTAssertEqual(nudger.value, 5);
}

- (void)testAccessibilityDecrementReducesValue {
    BPKNudgerConfiguration *nudgerConfiguration = [self nudgerConfiguration];
    BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];
    nudger.value = 5;
    [nudger performSelector:@selector(accessibilityDecrement)];

    XCTAssertEqual(nudger.value, 4);
}

- (void)testAccessibilityDecrementDoesNotReduceValueAtMin {
    BPKNudgerConfiguration *nudgerConfiguration = [self nudgerConfiguration];
    BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];
    nudger.minimumValue = 5;
    nudger.value = 5;
    [nudger performSelector:@selector(accessibilityDecrement)];

    XCTAssertEqual(nudger.value, 5);
}

- (void)testAccessibilityIncrementIncreasesValue {
    BPKNudgerConfiguration *nudgerConfiguration = [self nudgerConfiguration];
    BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];
    nudger.value = 5;
    [nudger performSelector:@selector(accessibilityIncrement)];

    XCTAssertEqual(nudger.value, 6);
}

- (void)testAccessibilityIncrementDoesNotIncreaseValueAtMax {
    BPKNudgerConfiguration *nudgerConfiguration = [self nudgerConfiguration];
    BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];
    nudger.maximumValue = 5;
    nudger.value = 5;
    [nudger performSelector:@selector(accessibilityIncrement)];

    XCTAssertEqual(nudger.value, 5);
}

- (void)testIncrementsBySpecifiedStep {
    BPKNudgerConfiguration *nudgerConfiguration = [self nudgerConfiguration];
    BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];
    nudger.value = 1;
    nudger.stepValue = 3;
    [nudger performSelector:@selector(accessibilityIncrement)];

    XCTAssertEqual(nudger.value, 4);
}

- (void)testDecrementsBySpecifiedStep {
    BPKNudgerConfiguration *nudgerConfiguration = [self nudgerConfiguration];
    BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];
    nudger.value = 4;
    nudger.stepValue = 3;
    [nudger performSelector:@selector(accessibilityDecrement)];

    XCTAssertEqual(nudger.value, 1);
}

@end

NS_ASSUME_NONNULL_END
