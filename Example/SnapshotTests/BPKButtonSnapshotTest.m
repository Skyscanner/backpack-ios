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

#import <Backpack/Button.h>
#import <Backpack/Icon.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKButtonSnapshotTest : FBSnapshotTestCase
- (UIStackView *)createAllVariantsOfSize:(BPKButtonSize)size style:(BPKButtonStyle)style applyTheme:(BOOL)applyTheme;
@end

@implementation BPKButtonSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (void)testDefaultPrimary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStylePrimary applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDefaultSecondary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStyleSecondary applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDefaultDestructive {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleDestructive
                                           applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDefaultFeatured {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStyleFeatured applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDefaultOutline {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStyleOutline applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDefaultLink {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStyleLink applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyViewWithOptions(view, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
}

- (void)testLargePrimary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStylePrimary applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testLargeSecondary {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStyleSecondary applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testLargeDestructive {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStyleDestructive applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testLargeFeatured {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStyleFeatured applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testLargeLink {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStyleLink applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyViewWithOptions(view, nil, FBSnapshotTestCaseDefaultSuffixes(), 0.01);
}

- (void)testLargeOutline {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeLarge style:BPKButtonStyleOutline applyTheme:NO];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testPrimaryWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStylePrimary applyTheme:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testSecondaryWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleSecondary
                                           applyTheme:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testFeaturedWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault style:BPKButtonStyleFeatured applyTheme:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

- (void)testDestructiveWithTheme {
    UIStackView *view = [self createAllVariantsOfSize:BPKButtonSizeDefault
                                                style:BPKButtonStyleDestructive
                                           applyTheme:YES];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    view.frame = CGRectMake(0, 0, size.width, size.height);

    FBSnapshotVerifyView(view, nil);
}

#pragma mark - Private

- (UIStackView *)createAllVariantsOfSize:(BPKButtonSize)size style:(BPKButtonStyle)style applyTheme:(BOOL)applyTheme {
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
    button.cornerRadius = @4.0;
}

@end
NS_ASSUME_NONNULL_END
