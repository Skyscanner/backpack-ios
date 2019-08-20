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

#import <Backpack/Color.h>
#import <Backpack/FlareView.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

@interface BPKFlareViewSnapshotTest : FBSnapshotTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKFlareViewSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (void)configureParentView:(UIView *)parentView forFlareView:(BPKFlareView *)flareView {
    flareView.translatesAutoresizingMaskIntoConstraints = NO;
    parentView.translatesAutoresizingMaskIntoConstraints = NO;
    parentView.backgroundColor = [BPKColor white];
    [parentView addSubview:flareView];
    [NSLayoutConstraint activateConstraints:@[
        [flareView.topAnchor constraintEqualToAnchor:parentView.topAnchor constant:BPKSpacingBase],
        [flareView.leadingAnchor constraintEqualToAnchor:parentView.leadingAnchor constant:BPKSpacingBase],
        [parentView.trailingAnchor constraintEqualToAnchor:flareView.trailingAnchor constant:BPKSpacingBase],
        [parentView.bottomAnchor constraintEqualToAnchor:flareView.bottomAnchor constant:BPKSpacingBase],
    ]];
    [parentView layoutIfNeeded];
}

- (void)configureFlareView:(BPKFlareView *)flareView withInnerView:(UIView *)innerView {
    flareView.translatesAutoresizingMaskIntoConstraints = NO;
    innerView.translatesAutoresizingMaskIntoConstraints = NO;
    flareView.backgroundView.backgroundColor = BPKColor.blue500;
    [flareView.contentView addSubview:innerView];
    [NSLayoutConstraint activateConstraints:@[
        [innerView.widthAnchor constraintEqualToConstant:150.0],
        [innerView.heightAnchor constraintEqualToConstant:100.0],
        [innerView.topAnchor constraintEqualToAnchor:flareView.contentView.topAnchor],
        [innerView.leadingAnchor constraintEqualToAnchor:flareView.contentView.leadingAnchor],
        [flareView.contentView.trailingAnchor constraintEqualToAnchor:innerView.trailingAnchor],
        [flareView.contentView.bottomAnchor constraintEqualToAnchor:innerView.bottomAnchor],
    ]];
}

- (void)testFlareViewSnapshot {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKFlareView *flareView = [[BPKFlareView alloc] initWithFrame:CGRectZero];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor red500];
    flareView.isFlareVisible = YES;

    [self configureFlareView:flareView withInnerView:innerView];
    [self configureParentView:parentView forFlareView:flareView];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testFlareHiddenSnapshot {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKFlareView *flareView = [[BPKFlareView alloc] initWithFrame:CGRectZero];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor red500];

    [self configureFlareView:flareView withInnerView:innerView];
    [self configureParentView:parentView forFlareView:flareView];
    FBSnapshotVerifyView(parentView, nil);
}

@end

NS_ASSUME_NONNULL_END
