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
#import <Backpack/Spinner.h>
#import <Backpack/Spacing.h>

@interface BPKSpinnerSnapshotTest : FBSnapshotTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKSpinnerSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (void)testSpinners {
    UIStackView *view = [self createAllVariants];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);
    
    FBSnapshotVerifyView(view, nil);
}

#pragma mark - Private

- (UIStackView *)createAllVariants {
    UIStackView *horizontalStackview = [[UIStackView alloc] initWithFrame:CGRectZero];
    horizontalStackview.axis = UILayoutConstraintAxisHorizontal;
    horizontalStackview.alignment = UIStackViewAlignmentCenter;
    horizontalStackview.distribution = UIStackViewDistributionEqualSpacing;
    horizontalStackview.spacing = BPKSpacingSm * 5;
    
    BPKSpinner *defaultPrimary = [[BPKSpinner alloc] initWithStyle:BPKSpinnerStylePrimary size:BPKSpinnerSizeDefault];
    [defaultPrimary setHidesWhenStopped:NO];
    [horizontalStackview addArrangedSubview:defaultPrimary];
    
    BPKSpinner *defaultDark = [[BPKSpinner alloc] initWithStyle:BPKSpinnerStyleDark size:BPKSpinnerSizeDefault];
    [defaultDark setHidesWhenStopped:NO];
    [horizontalStackview addArrangedSubview:defaultDark];
    
    BPKSpinner *defaultLight = [[BPKSpinner alloc] initWithStyle:BPKSpinnerStyleLight size:BPKSpinnerSizeDefault];
    [defaultLight setHidesWhenStopped:NO];
    [horizontalStackview addArrangedSubview:defaultLight];
    
    BPKSpinner *smallPrimary = [[BPKSpinner alloc] initWithStyle:BPKSpinnerStylePrimary size:BPKSpinnerSizeSmall];
    [smallPrimary setHidesWhenStopped:NO];
    [horizontalStackview addArrangedSubview:smallPrimary];
    
    BPKSpinner *smallDark = [[BPKSpinner alloc] initWithStyle:BPKSpinnerStyleDark size:BPKSpinnerSizeSmall];
    [smallDark setHidesWhenStopped:NO];
    [horizontalStackview addArrangedSubview:smallDark];
    
    BPKSpinner *smallLight = [[BPKSpinner alloc] initWithStyle:BPKSpinnerStyleLight size:BPKSpinnerSizeSmall];
    [smallLight setHidesWhenStopped:NO];
    [horizontalStackview addArrangedSubview:smallLight];
    
    return horizontalStackview;
}

@end

NS_ASSUME_NONNULL_END
