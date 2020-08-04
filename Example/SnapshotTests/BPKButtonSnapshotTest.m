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
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

#import <Backpack/Button.h>
#import <Backpack/Icon.h>
#import <Backpack/Spacing.h>

#import "BPKSnapshotTest.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKButtonSnapshotTest : FBSnapshotTestCase
//- (UIStackView *)createAllVariantsOfSize:(BPKButtonSize)size style:(BPKButtonStyle)style applyTheme:(BOOL)applyTheme;
@end

@implementation BPKButtonSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)createDefaultPrimary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStylePrimary
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultPrimary {
    UIView *lightView = [self createDefaultPrimary];
    UIView *darkView = [self createDefaultPrimary];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDefaultLoadingPrimary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStylePrimary
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultLoadingPrimary {
    UIView *lightView = [self createDefaultLoadingPrimary];
    UIView *darkView = [self createDefaultLoadingPrimary];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDefaultSecondary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleSecondary
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultSecondary {
    UIView *lightView = [self createDefaultSecondary];
    UIView *darkView = [self createDefaultSecondary];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDefaultLoadingSecondary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleSecondary
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultLoadingSecondary {
    UIView *lightView = [self createDefaultLoadingSecondary];
    UIView *darkView = [self createDefaultLoadingSecondary];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDefaultDestructive {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleDestructive
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultDestructive {
    UIView *lightView = [self createDefaultDestructive];
    UIView *darkView = [self createDefaultDestructive];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDefaultLoadingDestructive {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleDestructive
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultLoadingDestructive {
    UIView *lightView = [self createDefaultLoadingDestructive];
    UIView *darkView = [self createDefaultLoadingDestructive];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDefaultFeatured {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleFeatured
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultFeatured {
    UIView *lightView = [self createDefaultFeatured];
    UIView *darkView = [self createDefaultFeatured];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDefaultLoadingFeatured {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleFeatured
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultLoadingFeatured {
    UIView *lightView = [self createDefaultLoadingFeatured];
    UIView *darkView = [self createDefaultLoadingFeatured];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDefaultLink {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleLink
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultLink {
    UIView *lightView = [self createDefaultLink];
    UIView *darkView = [self createDefaultLink];

    BPKSnapshotVerifyViewLightWithOptions(lightView, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
    BPKSnapshotVerifyViewDarkWithOptions(darkView, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
}

- (UIView *)createDefaultLoadingLink {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleLink
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultLoadingLink {
    UIView *lightView = [self createDefaultLoadingLink];
    UIView *darkView = [self createDefaultLoadingLink];

    BPKSnapshotVerifyViewLightWithOptions(lightView, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
    BPKSnapshotVerifyViewDarkWithOptions(darkView, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
}

- (UIView *)createDefaultOutline {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleOutline
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultOutline {
    UIView *lightView = [self createDefaultOutline];
    UIView *darkView = [self createDefaultOutline];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDefaultLoadingOutline {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleOutline
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDefaultLoadingOutline {
    UIView *lightView = [self createDefaultLoadingOutline];
    UIView *darkView = [self createDefaultLoadingOutline];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargePrimary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStylePrimary
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargePrimary {
    UIView *lightView = [self createLargePrimary];
    UIView *darkView = [self createLargePrimary];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargeLoadingPrimary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStylePrimary
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeLoadingPrimary {
    UIView *lightView = [self createLargeLoadingPrimary];
    UIView *darkView = [self createLargeLoadingPrimary];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargeSecondary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStyleSecondary
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeSecondary {
    UIView *lightView = [self createLargeSecondary];
    UIView *darkView = [self createLargeSecondary];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargeLoadingSecondary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStyleSecondary
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeLoadingSecondary {
    UIView *lightView = [self createLargeLoadingSecondary];
    UIView *darkView = [self createLargeLoadingSecondary];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargeDestructive {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStyleDestructive
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeDestructive {
    UIView *lightView = [self createLargeDestructive];
    UIView *darkView = [self createLargeDestructive];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargeLoadingDestructive {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStyleDestructive
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeLoadingDestructive {
    UIView *lightView = [self createLargeLoadingDestructive];
    UIView *darkView = [self createLargeLoadingDestructive];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargeFeatured {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStyleFeatured
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeFeatured {
    UIView *lightView = [self createLargeFeatured];
    UIView *darkView = [self createLargeFeatured];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargeLoadingFeatured {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStyleFeatured
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeLoadingFeatured {
    UIView *lightView = [self createLargeLoadingFeatured];
    UIView *darkView = [self createLargeLoadingFeatured];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargeLink {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStyleLink
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeLink {
    UIView *lightView = [self createLargeLink];
    UIView *darkView = [self createLargeLink];

    BPKSnapshotVerifyViewLightWithOptions(lightView, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
    BPKSnapshotVerifyViewDarkWithOptions(darkView, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
}

- (UIView *)createLargeLoadingLink {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStyleLink
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeLoadingLink {
    UIView *lightView = [self createLargeLoadingLink];
    UIView *darkView = [self createLargeLoadingLink];

    BPKSnapshotVerifyViewLightWithOptions(lightView, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
    BPKSnapshotVerifyViewDarkWithOptions(darkView, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
}

- (UIView *)createLargeOutline {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStyleOutline
                                           applyTheme:NO
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeOutline {
    UIView *lightView = [self createLargeOutline];
    UIView *darkView = [self createLargeOutline];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createLargeLoadingOutline {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge
                                                style:BPKButtonStyleOutline
                                           applyTheme:NO
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testLargeLoadingOutline {
    UIView *lightView = [self createLargeLoadingOutline];
    UIView *darkView = [self createLargeLoadingOutline];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createPrimaryWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStylePrimary
                                           applyTheme:YES
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testPrimaryWithTheme {
    UIView *lightView = [self createPrimaryWithTheme];
    UIView *darkView = [self createPrimaryWithTheme];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createPrimaryLoadingWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStylePrimary
                                           applyTheme:YES
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testPrimaryLoadingWithTheme {
    UIView *lightView = [self createPrimaryLoadingWithTheme];
    UIView *darkView = [self createPrimaryLoadingWithTheme];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createSecondaryWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleSecondary
                                           applyTheme:YES
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testSecondaryWithTheme {
    UIView *lightView = [self createSecondaryWithTheme];
    UIView *darkView = [self createSecondaryWithTheme];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createSecondaryLoadingWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleSecondary
                                           applyTheme:YES
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testSecondaryLoadingWithTheme {
    UIView *lightView = [self createSecondaryLoadingWithTheme];
    UIView *darkView = [self createSecondaryLoadingWithTheme];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createFeaturedWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleFeatured
                                           applyTheme:YES
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testFeaturedWithTheme {
    UIView *lightView = [self createFeaturedWithTheme];
    UIView *darkView = [self createFeaturedWithTheme];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createFeaturedLoadingWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleFeatured
                                           applyTheme:YES
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testFeaturedLoadingWithTheme {
    UIView *lightView = [self createFeaturedLoadingWithTheme];
    UIView *darkView = [self createFeaturedLoadingWithTheme];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDestructiveWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleDestructive
                                           applyTheme:YES
                                              loading:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDestructiveWithTheme {
    UIView *lightView = [self createDestructiveWithTheme];
    UIView *darkView = [self createDestructiveWithTheme];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDestructiveLoadingWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleDestructive
                                           applyTheme:YES
                                              loading:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    return view;
}

- (void)testDestructiveLoadingWithTheme {
    UIView *lightView = [self createDestructiveLoadingWithTheme];
    UIView *darkView = [self createDestructiveLoadingWithTheme];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

#pragma mark - Private

- (UIStackView *)createAllVariantsOfSize:(BPKButtonSize)size
                                   style:(BPKButtonStyle)style
                              applyTheme:(BOOL)applyTheme
                                 loading:(BOOL)loading {
    UIImage *smallIcon = [BPKIcon templateIconNamed:@"long-arrow-right" size:BPKIconSizeSmall];

    UIStackView *horizontalStackview = [[UIStackView alloc] initWithFrame:CGRectZero];
    horizontalStackview.axis = UILayoutConstraintAxisHorizontal;
    horizontalStackview.alignment = UIStackViewAlignmentCenter;
    horizontalStackview.distribution = UIStackViewDistributionEqualSpacing;
    horizontalStackview.spacing = BPKSpacingSm * 5;

    BPKButton *textOnly = [[BPKButton alloc] initWithSize:size style:style];
    textOnly.title = @"Button";
    textOnly.isLoading = loading;
    [horizontalStackview addArrangedSubview:textOnly];

    BPKButton *textAndIconTrailing = [[BPKButton alloc] initWithSize:size style:style];
    textAndIconTrailing.imagePosition = BPKButtonImagePositionTrailing;
    textAndIconTrailing.title = @"With icon";
    [textAndIconTrailing setImage:smallIcon];
    textAndIconTrailing.isLoading = loading;
    [horizontalStackview addArrangedSubview:textAndIconTrailing];

    BPKButton *textAndIconLeading = [[BPKButton alloc] initWithSize:size style:style];
    textAndIconLeading.imagePosition = BPKButtonImagePositionLeading;
    textAndIconLeading.title = @"With icon";
    [textAndIconLeading setImage:smallIcon];
    textAndIconLeading.isLoading = loading;
    [horizontalStackview addArrangedSubview:textAndIconLeading];

    BPKButton *iconOnly = [[BPKButton alloc] initWithSize:size style:style];
    [iconOnly setImage:smallIcon];
    iconOnly.isLoading = loading;
    [horizontalStackview addArrangedSubview:iconOnly];

    if (applyTheme) {
        [self applyTheme:textOnly];
        [self applyTheme:textAndIconTrailing];
        [self applyTheme:textAndIconLeading];
        [self applyTheme:iconOnly];
    }

    return horizontalStackview;
}

- (void)applyTheme:(BPKButton *)button {
    button.primaryGradientStartColor = UIColor.redColor;
    button.primaryGradientEndColor = UIColor.blueColor;
    button.primaryContentColor = UIColor.blackColor;
    button.secondaryBorderColor = UIColor.purpleColor;
    button.secondaryContentColor = UIColor.redColor;
    button.secondaryBackgroundColor = UIColor.cyanColor;
    button.featuredGradientStartColor = UIColor.brownColor;
    button.featuredGradientEndColor = UIColor.magentaColor;
    button.featuredContentColor = UIColor.yellowColor;
    button.destructiveBorderColor = UIColor.greenColor;
    button.destructiveContentColor = UIColor.blueColor;
    button.destructiveBackgroundColor = UIColor.orangeColor;
    button.linkContentColor = UIColor.purpleColor;
}

@end
NS_ASSUME_NONNULL_END
