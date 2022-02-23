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

#import <Backpack/Color.h>
#import <Backpack/Spacing.h>
#import <Backpack/Spinner.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

#import "BPKSnapshotTest.h"

@interface BPKSpinnerSnapshotTest : FBSnapshotTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKSpinnerSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)createSpinnersTestView {
    NSArray<BPKSpinner *> *views = [self createAllSpinnerVariantsWithTheming:NO];
    UIView *view = [self embedViewsInStackView:views];

    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testSpinners {
    UIView *lightView = [self createSpinnersTestView];
    UIView *darkView = [self createSpinnersTestView];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createSpinnersWithThemeTestView {
    NSArray<BPKSpinner *> *views = [self createAllSpinnerVariantsWithTheming:YES];
    UIView *view = [self embedViewsInStackView:views];

    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testSpinnersWithTheme {
    UIView *lightView = [self createSpinnersWithThemeTestView];
    UIView *darkView = [self createSpinnersWithThemeTestView];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

#pragma mark - Private

- (NSArray<BPKSpinner *> *)createAllSpinnerVariantsWithTheming:(BOOL)themed {
    return @[
        [self createSpinnerForSnapshotTestWithStyle:BPKSpinnerStylePrimary size:BPKSpinnerSizeDefault themed:themed],
        [self createSpinnerForSnapshotTestWithStyle:BPKSpinnerStyleSecondary size:BPKSpinnerSizeDefault themed:themed],
        [self createSpinnerForSnapshotTestWithStyle:BPKSpinnerStyleDark size:BPKSpinnerSizeDefault themed:themed],
        [self createSpinnerForSnapshotTestWithStyle:BPKSpinnerStyleLight size:BPKSpinnerSizeDefault themed:themed],
        [self createSpinnerForSnapshotTestWithStyle:BPKSpinnerStylePrimary size:BPKSpinnerSizeSmall themed:themed],
        [self createSpinnerForSnapshotTestWithStyle:BPKSpinnerStyleSecondary size:BPKSpinnerSizeSmall themed:themed],
        [self createSpinnerForSnapshotTestWithStyle:BPKSpinnerStyleDark size:BPKSpinnerSizeSmall themed:themed],
        [self createSpinnerForSnapshotTestWithStyle:BPKSpinnerStyleLight size:BPKSpinnerSizeSmall themed:themed]
    ];
}

- (BPKSpinner *)createSpinnerForSnapshotTestWithStyle:(BPKSpinnerStyle)style size:(BPKSpinnerSize)size themed:(BOOL)themed {
    BPKSpinner *spinner = [[BPKSpinner alloc] initWithStyle:style size:size];
    if (themed) {
        spinner.primaryColor = [BPKColor dynamicColorWithLightVariant:UIColor.purpleColor darkVariant:UIColor.yellowColor];
    }
    [spinner setHidesWhenStopped:NO];
    return spinner;
}

- (UIStackView *)embedViewsInStackView:(NSArray<UIView *> *)views {
    UIStackView *horizontalStackview = [[UIStackView alloc] initWithFrame:CGRectZero];
    horizontalStackview.axis = UILayoutConstraintAxisHorizontal;
    horizontalStackview.alignment = UIStackViewAlignmentCenter;
    horizontalStackview.distribution = UIStackViewDistributionEqualSpacing;
    horizontalStackview.spacing = BPKSpacingSm * 5;

    for (UIView *view in views) {
        [horizontalStackview addArrangedSubview:view];
    }

    return horizontalStackview;
}

@end

NS_ASSUME_NONNULL_END
