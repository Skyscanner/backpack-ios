/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

- (UIView *)createChipWithCustomBackgroundColorUnselected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    bpkChip.backgroundTint = UIColor.orangeColor;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipWithCustomBackgroundColorUnselected {
    UIView *lightView = [self createChipWithCustomBackgroundColorUnselected];
    UIView *darkView = [self createChipWithCustomBackgroundColorUnselected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createChipWithCustomBackgroundColorSelected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    bpkChip.backgroundTint = UIColor.orangeColor;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipWithCustomBackgroundColorSelected {
    UIView *lightView = [self createChipWithCustomBackgroundColorSelected];
    UIView *darkView = [self createChipWithCustomBackgroundColorSelected];

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

- (UIView *)createChipEnabledUnselectedWithIcon {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.iconName = BPKIconNameMap;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipEnabledUnselectedWithIcon {
    UIView *lightView = [self createChipEnabledUnselectedWithIcon];
    UIView *darkView = [self createChipEnabledUnselectedWithIcon];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createChipDisabledUnselectedWithIcon {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.iconName = BPKIconNameMap;
    bpkChip.enabled = NO;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipDisabledUnselectedWithIcon {
    UIView *lightView = [self createChipDisabledUnselectedWithIcon];
    UIView *darkView = [self createChipDisabledUnselectedWithIcon];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createChipEnabledSelectedWithIcon {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.iconName = BPKIconNameMap;
    bpkChip.selected = YES;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipEnabledSelectedWithIcon {
    UIView *lightView = [self createChipEnabledSelectedWithIcon];
    UIView *darkView = [self createChipEnabledSelectedWithIcon];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createChipFilledUnselected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.style = BPKChipStyleFilled;
    bpkChip.selected = NO;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipFilledUnselected {
    UIView *lightView = [self createChipFilledUnselected];
    UIView *darkView = [self createChipFilledUnselected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createChipFilledSelected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.style = BPKChipStyleFilled;
    bpkChip.selected = YES;
    [self configureParentView:parentView forChip:bpkChip];
    return parentView;
}

- (void)testChipFilledSelected {
    UIView *lightView = [self createChipFilledSelected];
    UIView *darkView = [self createChipFilledSelected];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end

NS_ASSUME_NONNULL_END
