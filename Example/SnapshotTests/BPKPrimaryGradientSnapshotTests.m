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

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

#import <Backpack/Gradient.h>

@interface BPKPrimaryGradientSnapshotTests : FBSnapshotTestCase

@end

@implementation BPKPrimaryGradientSnapshotTests

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (void)testPrimaryGradient {
    BPKPrimaryGradientView *view = [[BPKPrimaryGradientView alloc] initWithFrame:CGRectMake(0, 0, 150, 200)];

    FBSnapshotVerifyView(view, nil);
}

- (void)testPrimaryGradientWithCustomGradient {
    BPKPrimaryGradientView *view = [[BPKPrimaryGradientView alloc] initWithFrame:CGRectMake(0, 0, 150, 200)];
    UIColor *startColor = [UIColor colorWithRed:0.00392 green:0.227 blue:0.463 alpha:1];
    UIColor *endColor = [UIColor colorWithRed:0 green:0.184 blue:0.38 alpha:1];
    CGPoint startPoint = [BPKGradient startPointForDirection:BPKGradientDirectionBottomRight];
    CGPoint endPoint = [BPKGradient endPointForDirection:BPKGradientDirectionBottomRight];

    view.gradient = [[BPKGradient alloc] initWithColors:@[startColor, endColor]
                                             startPoint:startPoint
                                               endPoint:endPoint];

    FBSnapshotVerifyView(view, nil);
}

- (void)testPrimaryGradientWithDirectionOverride {
    BPKPrimaryGradientView *view = [[BPKPrimaryGradientView alloc] initWithFrame:CGRectMake(0, 0, 150, 200)];
    view.directionOverride = @(BPKGradientDirectionLeft);

    FBSnapshotVerifyView(view, nil);
}

@end
