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

#import <Backpack/Map.h>

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import "BPKSnapshotTest.h"

@interface BPKMapSnapshotTest : FBSnapshotTestCase
@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKMapSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

-(BPKMapView *)createMapView {
    BPKMapView *mapView = [[BPKMapView alloc] initWithFrame:CGRectMake(0, 0, 100, 250)];
    return mapView;
}

- (void)testMapView {
    UIView *lightView = [self createMapView];
    UIView *darkView = [self createMapView];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end
NS_ASSUME_NONNULL_END
