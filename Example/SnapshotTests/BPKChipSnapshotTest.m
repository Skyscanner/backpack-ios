/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import <Backpack/Chip.h>
#import <Backpack/Spacing.h>

#import "BPKSnapshotTest.h"

@interface BPKChipSnapshotTest : FBSnapshotTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKChipSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (void)configureParentView:(UIView *)parentView forChip:(BPKChip *)chip {
    parentView.translatesAutoresizingMaskIntoConstraints = NO;
    chip.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addSubview:chip];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-padding-[chip]-padding-|"
                                                                       options:0
                                                                       metrics:@{@"padding": @(BPKSpacingBase)}
                                                                         views:@{@"chip": chip}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[chip]-padding-|"
                                                                       options:0
                                                                       metrics:@{@"padding": @(BPKSpacingBase)}
                                                                         views:@{@"chip": chip}]];
    [parentView layoutIfNeeded];
}

- (UIView *)createChipEnabledUnselected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipEnabledUnselected {
    UIView *lightView = [self createChipEnabledUnselected];
    UIView *darkView = [self createChipEnabledUnselected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipEnabledSelected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipEnabledSelected {
    UIView *lightView = [self createChipEnabledSelected];
    UIView *darkView = [self createChipEnabledSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipWithoutShadowEnabledUnselected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.shadowEnabled = false;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipWithoutShadowEnabledUnselected {
    UIView *lightView = [self createChipWithoutShadowEnabledUnselected];
    UIView *darkView = [self createChipWithoutShadowEnabledUnselected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipWithoutShadowEnabledSelected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    bpkChip.shadowEnabled = false;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipWithoutShadowEnabledSelected {
    UIView *lightView = [self createChipWithoutShadowEnabledSelected];
    UIView *darkView = [self createChipWithoutShadowEnabledSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)creteChipWithCustomBackgroundColorWithoutShadowEnabledSelected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    bpkChip.backgroundTint = UIColor.orangeColor;
    bpkChip.shadowEnabled = false;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipWithCustomBackgroundColorWithoutShadowEnabledSelected {
    UIView *lightView = [self creteChipWithCustomBackgroundColorWithoutShadowEnabledSelected];
    UIView *darkView = [self creteChipWithCustomBackgroundColorWithoutShadowEnabledSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipWithCustomBackgroundAndUnselectedColorEnabledColorWithoutShadowEnabledSelected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    bpkChip.backgroundTint = UIColor.orangeColor;
    bpkChip.colorUnselectedState = YES;
    bpkChip.shadowEnabled = false;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipWithCustomBackgroundAndUnselectedColorEnabledColorWithoutShadowEnabledSelected {
    UIView *lightView = [self createChipWithCustomBackgroundAndUnselectedColorEnabledColorWithoutShadowEnabledSelected];
    UIView *darkView = [self createChipWithCustomBackgroundAndUnselectedColorEnabledColorWithoutShadowEnabledSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipUnselectedColorEnabledColorWithoutShadowEnabledSelected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    bpkChip.colorUnselectedState = YES;
    bpkChip.shadowEnabled = false;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipUnselectedColorEnabledColorWithoutShadowEnabledSelected {
    UIView *lightView = [self createChipUnselectedColorEnabledColorWithoutShadowEnabledSelected];
    UIView *darkView = [self createChipUnselectedColorEnabledColorWithoutShadowEnabledSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipWithCustomBackgroundColorWithoutShadowEnabledUnselected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.backgroundTint = UIColor.orangeColor;
    bpkChip.shadowEnabled = false;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipWithCustomBackgroundColorWithoutShadowEnabledUnselected {
    UIView *lightView = [self createChipWithCustomBackgroundColorWithoutShadowEnabledUnselected];
    UIView *darkView = [self createChipWithCustomBackgroundColorWithoutShadowEnabledUnselected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipWithCustomBackgroundAndUnselectedColorEnabledColorWithoutShadowEnabledUnselected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.backgroundTint = UIColor.orangeColor;
    bpkChip.colorUnselectedState = YES;
    bpkChip.shadowEnabled = false;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipWithCustomBackgroundAndUnselectedColorEnabledColorWithoutShadowEnabledUnselected {
    UIView *lightView = [self createChipWithCustomBackgroundAndUnselectedColorEnabledColorWithoutShadowEnabledUnselected];
    UIView *darkView = [self createChipWithCustomBackgroundAndUnselectedColorEnabledColorWithoutShadowEnabledUnselected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipUnselectedColorEnabledColorWithoutShadowEnabledUnselected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.colorUnselectedState = YES;
    bpkChip.shadowEnabled = false;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipUnselectedColorEnabledColorWithoutShadowEnabledUnselected {
    UIView *lightView = [self createChipUnselectedColorEnabledColorWithoutShadowEnabledUnselected];
    UIView *darkView = [self createChipUnselectedColorEnabledColorWithoutShadowEnabledUnselected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipEnabledSelectedThemed {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.primaryColor = UIColor.greenColor;
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipEnabledSelectedThemed {
    UIView *lightView = [self createChipEnabledSelectedThemed];
    UIView *darkView = [self createChipEnabledSelectedThemed];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipEnabledUnselectedHighlighted {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = NO;
    bpkChip.highlighted = YES;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipEnabledUnselectedHighlighted {
    UIView *lightView = [self createChipEnabledUnselectedHighlighted];
    UIView *darkView = [self createChipEnabledUnselectedHighlighted];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipEnabledSelectedHighlighted {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    bpkChip.highlighted = YES;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipEnabledSelectedHighlighted {
    UIView *lightView = [self createChipEnabledSelectedHighlighted];
    UIView *darkView = [self createChipEnabledSelectedHighlighted];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (UIView *)createChipDisabled {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.enabled = NO;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipDisabled {
    UIView *lightView = [self createChipDisabled];
    UIView *darkView = [self createChipDisabled];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end

NS_ASSUME_NONNULL_END
