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

#import <Backpack/Button.h>
#import <Backpack/Spacing.h>
#import <Backpack/Icon.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKButtonSnapshotTest : FBSnapshotTestCase
- (UIStackView *)createAllVariantsOfSize:(BPKButtonSize)size style:(BPKButtonStyle)style;
@end

@implementation BPKButtonSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (void)testDefaultPrimary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDefaultSecondary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStyleSecondary];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDefaultDestructive {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStyleDestructive];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDefaultFeatured {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStyleFeatured];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDefaultOutline {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStyleOutline];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDefaultLink {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStyleLink];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyViewWithOptions(view, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
}

- (void)testLargePrimary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStylePrimary];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testLargeSecondary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStyleSecondary];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testLargeDestructive {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStyleDestructive];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testLargeFeatured {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStyleFeatured];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testLargeLink {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStyleLink];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyViewWithOptions(view, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
}

- (void)testLargeOutline {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStyleOutline];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

#pragma mark - Private

- (UIStackView *)createAllVariantsOfSize:(BPKButtonSize)size style:(BPKButtonStyle)style {
    UIImage *smallIcon = [BPKIcon templateIconNamed:@"long-arrow-right" size:BPKIconSizeSmall];

    UIStackView *horizontalStackview = [[UIStackView alloc] initWithFrame:CGRectZero];
    horizontalStackview.axis = UILayoutConstraintAxisHorizontal;
    horizontalStackview.alignment = UIStackViewAlignmentCenter;
    horizontalStackview.distribution = UIStackViewDistributionEqualSpacing;
    horizontalStackview.spacing = BPKSpacingSm * 5;

    BPKButton *textOnly = [[BPKButton alloc] initWithSize:size style:style];
    [textOnly setTitle:@"Button"];
    [horizontalStackview addArrangedSubview:textOnly];

    BPKButton *textAndIconTrailing = [[BPKButton alloc] initWithSize:size style:style];
    textAndIconTrailing.imagePosition = BPKButtonImagePositionTrailing;
    [textAndIconTrailing setTitle:@"With icon"];
    [textAndIconTrailing setImage:smallIcon];
    [horizontalStackview addArrangedSubview:textAndIconTrailing];

    BPKButton *textAndIconLeading = [[BPKButton alloc] initWithSize:size style:style];
    textAndIconLeading.imagePosition = BPKButtonImagePositionLeading;
    [textAndIconLeading setTitle:@"With icon"];
    [textAndIconLeading setImage:smallIcon];
    [horizontalStackview addArrangedSubview:textAndIconLeading];

    BPKButton *iconOnly = [[BPKButton alloc] initWithSize:size style:style];
    [iconOnly setImage:smallIcon];
    [horizontalStackview addArrangedSubview:iconOnly];

    return horizontalStackview;
}

@end
NS_ASSUME_NONNULL_END
