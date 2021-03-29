/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019 Skyscanner Ltd. All rights reserved.
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

#import <Backpack/BPKToast.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKToastSnapshotTest : FBSnapshotTestCase
@end

@implementation BPKToastSnapshotTest
- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)createToastWithMode:(BPKToastMode)toastMode {
    UIView *parent = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    parent.backgroundColor = UIColor.whiteColor;
    BPKToast *toast = [BPKToast showToastAddedTo:parent animated:NO];
    toast.mode = toastMode;
    toast.labelText = @"Toast Title Text";
    toast.detailsLabelText = @"Toast detail text";

    return parent;
}

- (void)testToastWithTextMode {
    FBSnapshotVerifyView([self createToastWithMode:BPKToastModeText], nil);
}

- (void)testToastWithDefaultMode {
    FBSnapshotVerifyView([self createToastWithMode:BPKToastModeIndeterminate], nil);
}

@end
NS_ASSUME_NONNULL_END
