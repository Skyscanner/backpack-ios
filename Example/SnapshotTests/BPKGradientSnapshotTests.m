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

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

#import <Backpack/Gradient.h>

@interface BPKGradientSnapshotTests : FBSnapshotTestCase

@end

@implementation BPKGradientSnapshotTests

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (void)testPrimaryGradient {
    BPKGradientView *view = [[BPKGradientView alloc] initWithGradient:[BPKGradient primary]];
    view.frame = CGRectMake(0, 0, 150, 200);

    FBSnapshotVerifyView(view, nil);
}


@end
