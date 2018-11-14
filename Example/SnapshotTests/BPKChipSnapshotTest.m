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
#import <Backpack/Chip.h>
#import <Backpack/Spacing.h>

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
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-padding-[chip]-padding-|" options:0 metrics:@{@"padding":@(BPKSpacingBase)} views:@{@"chip": chip}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[chip]-padding-|" options:0 metrics:@{@"padding":@(BPKSpacingBase)} views:@{@"chip": chip}]];
    [parentView layoutIfNeeded];
}

- (void)testChipEnabledUnselected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    [self configureParentView:parentView forChip:bpkChip];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testChipEnabledSelected {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    [self configureParentView:parentView forChip:bpkChip];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testChipEnabledUnselectedHighlighted {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = NO;
    bpkChip.highlighted = YES;
    [self configureParentView:parentView forChip:bpkChip];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testChipEnabledSelectedHighlighted {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.selected = YES;
    bpkChip.highlighted = YES;
    [self configureParentView:parentView forChip:bpkChip];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testChipDisabled {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKChip *bpkChip = [[BPKChip alloc] initWithFrame:CGRectZero];
    bpkChip.title = @"Test";
    bpkChip.enabled = NO;
    [self configureParentView:parentView forChip:bpkChip];
    FBSnapshotVerifyView(parentView, nil);
}

@end

NS_ASSUME_NONNULL_END
