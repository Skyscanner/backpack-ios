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

#import <Backpack/Card.h>
#import <Backpack/Color.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

@interface BPKCardSnapshotTest : FBSnapshotTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKCardSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (void)configureParentView:(UIView *)parentView forCard:(BPKCard *)card {
    parentView.translatesAutoresizingMaskIntoConstraints = NO;
    parentView.backgroundColor = [BPKColor white];
    [parentView addSubview:card];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-16-[card]-16-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"card": card}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[card]-16-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"card": card}]];
    [parentView layoutIfNeeded];
}

- (void)configureCard:(BPKCard *)card withInnerView:(UIView *)innerView {
    card.translatesAutoresizingMaskIntoConstraints = NO;
    [card setSubview:innerView];
    [card addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[innerView(90)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"innerView": innerView}]];
    [card addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[innerView(80)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"innerView": innerView}]];
}

- (void)configureDividedCard:(BPKDividedCard *)card
              firstInnerView:(UIView *)firstInnerView
             secondInnerView:(UIView *)secondInnerView {
    card.translatesAutoresizingMaskIntoConstraints = NO;
    [card setPrimarySubview:firstInnerView secondarySubview:secondInnerView];
}

- (void)testViewSnapshotWithoutPadded {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:NO];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testViewSnapshotWithoutPaddedAndLargeCornerStyle {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:NO cornerStyle:BPKCardCornerStyleLarge];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testViewSnapshotWithPadded {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:YES];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testViewSnapshotWithPaddedAndBackgroundColor {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:YES];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];
    card.backgroundColor = BPKColor.glencoe;

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testViewSnapshotWithPaddedAndLargeCornerStyle {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:YES cornerStyle:BPKCardCornerStyleLarge];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testDividedSnapshotWithPaddedHorizontal {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:YES];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    firstInnerView.text = @"Lorem ipse";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testDividedSnapshotWithPaddedHorizontalAndLargeCornerStyle {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:YES];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    firstInnerView.text = @"Lorem ipse";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];
    dividedCard.cornerStyle = BPKCardCornerStyleLarge;

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testDividedSnapshotWithPaddedVertical {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:YES];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    firstInnerView.text = @"Lorem ipse";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];

    dividedCard.orientation = UILayoutConstraintAxisVertical;

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testDividedSnapshotWithoutPaddedHorizontal {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:NO];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    firstInnerView.text = @"Lorem ipse";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testDividedSnapshotWithoutPaddedHorizontalAndLargeCornerStyle {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:NO];
    [[dividedCard.heightAnchor constraintGreaterThanOrEqualToConstant:2 * BPKSpacingLg] setActive:YES];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    firstInnerView.text = @"Lorem ipse";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];
    dividedCard.cornerStyle = BPKCardCornerStyleLarge;

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testDividedSnapshotWithoutPaddedVertical {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:NO];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    firstInnerView.text = @"Lorem ipse";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];

    dividedCard.orientation = UILayoutConstraintAxisVertical;

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    FBSnapshotVerifyView(parentView, nil);
}

@end

NS_ASSUME_NONNULL_END
