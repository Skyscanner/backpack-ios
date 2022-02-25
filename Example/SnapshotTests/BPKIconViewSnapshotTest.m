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

#import <Backpack/Color.h>
#import <Backpack/Icon.h>

#import "BPKSnapshotTest.h"

@interface BPKIconViewSnapshotTest : FBSnapshotTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKIconViewSnapshotTest

- (void)setUp {
    [super setUp];

    self.recordMode = NO;
}

- (UIView *)createLargeIconWithDefaultTint {
    BPKIconView *view = [[BPKLargeIconView alloc] initWithIconName:BPKIconNameAccessibility];

    return view;
}

- (void)testLargeIconWithDefaultTint {
    UIView *lightView = [self createLargeIconWithDefaultTint];
    UIView *darkView = [self createLargeIconWithDefaultTint];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargeWithTint {
    BPKIconView *view = [[BPKLargeIconView alloc] initWithIconName:BPKIconNameAccessibility];
    view.tintColor = BPKColor.panjin;

    return view;
}

- (void)testLargeWithTint {
    UIView *lightView = [self createLargeWithTint];
    UIView *darkView = [self createLargeWithTint];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createSmallWithTint {
    BPKSmallIconView *view = [[BPKSmallIconView alloc] initWithIconName:BPKIconNameAccessibility];
    view.tintColor = BPKColor.panjin;

    return view;
}

- (void)testSmallWithTint {
    UIView *lightView = [self createSmallWithTint];
    UIView *darkView = [self createSmallWithTint];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createXlWithTint {
    BPKXlIconView *view = [[BPKXlIconView alloc] initWithIconName:BPKIconNameStar];
    view.tintColor = BPKColor.panjin;

    return view;
}

- (void)testXlWithTint {
    UIView *lightView = [self createXlWithTint];
    UIView *darkView = [self createXlWithTint];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end

NS_ASSUME_NONNULL_END
