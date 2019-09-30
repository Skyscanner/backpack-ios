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

#import <Backpack/Color.h>
#import <Backpack/Icon.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface BPKIconSnapshotTest : FBSnapshotTestCase

@end

@implementation BPKIconSnapshotTest

- (void)setUp {
    [super setUp];

    self.recordMode = NO;
}

- (void)testSmallIcon {
    UIImage *icon = [BPKIcon iconNamed:@"flight" color:[BPKColor skyBlue] size:BPKIconSizeSmall];
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
    view.image = icon;

    FBSnapshotVerifyView(view, nil)
}

- (void)testLargeIcon {
    UIImage *icon = [BPKIcon iconNamed:@"hotels" color:[BPKColor skyBlue] size:BPKIconSizeLarge];
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
    view.image = icon;

    FBSnapshotVerifyView(view, nil)
}

@end
