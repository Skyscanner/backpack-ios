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
#import <Backpack/Panel.h>
#import <Backpack/Color.h>

@interface BPKPanelSnapshotTest : FBSnapshotTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKPanelSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (void)configureParentView:(UIView *)parentView forPanel:(BPKPanel *)panel {
    parentView.translatesAutoresizingMaskIntoConstraints = NO;
    parentView.backgroundColor = [BPKColor white];
    [parentView addSubview:panel];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-16-[panel]-16-|" options:0 metrics:nil views:@{@"panel": panel}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[panel]-16-|" options:0 metrics:nil views:@{@"panel": panel}]];
    [parentView layoutIfNeeded];
}

- (void)configurePanel:(BPKPanel *)panel withInnerView:(UIView *)innerView {
    panel.translatesAutoresizingMaskIntoConstraints = NO;
    [panel addSubview:innerView];
    [panel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[innerView(90)]" options:0 metrics:nil views:@{@"innerView": innerView}]];
    [panel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[innerView(80)]" options:0 metrics:nil views:@{@"innerView": innerView}]];
}

- (void)testViewSnapshotWithoutPadded {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKPanel *panel = [[BPKPanel alloc] initWithPadded:NO];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor red500];

    [self configurePanel:panel withInnerView:innerView];
    [self configureParentView:parentView forPanel:panel];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testViewSnapshotWithPadded {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKPanel *panel = [[BPKPanel alloc] initWithPadded:YES];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor red500];
    
    [self configurePanel:panel withInnerView:innerView];
    [self configureParentView:parentView forPanel:panel];
    FBSnapshotVerifyView(parentView, nil);
}

@end

NS_ASSUME_NONNULL_END
