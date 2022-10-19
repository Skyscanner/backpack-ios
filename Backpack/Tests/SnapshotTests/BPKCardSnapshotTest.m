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

#import <Backpack/Card.h>
#import <Backpack/Color.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

#import "BPKSnapshotTest.h"

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
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-16-[card]-16-|" options:0 metrics:nil views:@{@"card": card}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[card]-16-|" options:0 metrics:nil views:@{@"card": card}]];
    [parentView layoutIfNeeded];
}

- (void)configureCard:(BPKCard *)card withInnerView:(UIView *)innerView {
    card.translatesAutoresizingMaskIntoConstraints = NO;
    [card setSubview:innerView];
    [card addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[innerView(90)]" options:0 metrics:nil views:@{@"innerView": innerView}]];
    [card addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[innerView(80)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"innerView": innerView}]];
}

- (void)configureDividedCard:(BPKDividedCard *)card firstInnerView:(UIView *)firstInnerView secondInnerView:(UIView *)secondInnerView {
    card.translatesAutoresizingMaskIntoConstraints = NO;
    [card setPrimarySubview:firstInnerView secondarySubview:secondInnerView];
}

- (UIView *)createViewSnapshotWithoutPadded {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:NO];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    return parentView;
}

- (void)testViewSnapshotWithoutPadded {
    UIView *lightView = [self createViewSnapshotWithoutPadded];
    UIView *darkView = [self createViewSnapshotWithoutPadded];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createViewSnapshotWithoutPaddedAndLargeCornerStyle {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:NO cornerStyle:BPKCardCornerStyleLarge];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    return parentView;
}

- (void)testViewSnapshotWithoutPaddedAndLargeCornerStyle {
    UIView *lightView = [self createViewSnapshotWithoutPaddedAndLargeCornerStyle];
    UIView *darkView = [self createViewSnapshotWithoutPaddedAndLargeCornerStyle];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createViewSnapshotWithoutElevation {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:NO cornerStyle:BPKCardCornerStyleLarge];
    card.isElevated = NO;
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    return parentView;
}

- (void)testViewSnapshotWithoutElevation {
    UIView *lightView = [self createViewSnapshotWithoutElevation];
    UIView *darkView = [self createViewSnapshotWithoutElevation];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createViewSnapshotWithPadded {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:YES];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    return parentView;
}

- (void)testViewSnapshotWithPadded {
    UIView *lightView = [self createViewSnapshotWithPadded];
    UIView *darkView = [self createViewSnapshotWithPadded];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createViewSnapshotWithPaddedAndBackgroundColor {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:YES];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];
    card.backgroundColor = BPKColor.glencoe;

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    return parentView;
}

- (void)testViewSnapshotWithPaddedAndBackgroundColor {
    UIView *lightView = [self createViewSnapshotWithPaddedAndBackgroundColor];
    UIView *darkView = [self createViewSnapshotWithPaddedAndBackgroundColor];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createViewSnapshotWithPaddedAndLargeCornerStyle {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKCard *card = [[BPKCard alloc] initWithPadded:YES cornerStyle:BPKCardCornerStyleLarge];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
    innerView.backgroundColor = [BPKColor panjin];

    [self configureCard:card withInnerView:innerView];
    [self configureParentView:parentView forCard:card];
    return parentView;
}

- (void)testViewSnapshotWithPaddedAndLargeCornerStyle {
    UIView *lightView = [self createViewSnapshotWithPaddedAndLargeCornerStyle];
    UIView *darkView = [self createViewSnapshotWithPaddedAndLargeCornerStyle];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDividedSnapshotWithPaddedHorizontal {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:YES];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    firstInnerView.text = @"Lorem ipsum";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    return parentView;
}

- (void)testDividedSnapshotWithPaddedHorizontal {
    UIView *lightView = [self createDividedSnapshotWithPaddedHorizontal];
    UIView *darkView = [self createDividedSnapshotWithPaddedHorizontal];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDividedSnapshotWithPaddedHorizontalAndLargeCornerStyle {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:YES];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    firstInnerView.text = @"Lorem ipsum";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];
    dividedCard.cornerStyle = BPKCardCornerStyleLarge;

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    return parentView;
}

- (void)testDividedSnapshotWithPaddedHorizontalAndLargeCornerStyle {
    UIView *lightView = [self createDividedSnapshotWithPaddedHorizontalAndLargeCornerStyle];
    UIView *darkView = [self createDividedSnapshotWithPaddedHorizontalAndLargeCornerStyle];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDividedSnapshotWithPaddedVertical {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:YES];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    firstInnerView.text = @"Lorem ipsum";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];

    dividedCard.orientation = UILayoutConstraintAxisVertical;

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    return parentView;
}

- (void)testDividedSnapshotWithPaddedVertical {
    UIView *lightView = [self createDividedSnapshotWithPaddedVertical];
    UIView *darkView = [self createDividedSnapshotWithPaddedVertical];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDividedSnapshotWithoutPaddedHorizontal {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:NO];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    firstInnerView.text = @"Lorem ipsum";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    return parentView;
}

- (void)testDividedSnapshotWithoutPaddedHorizontal {
    UIView *lightView = [self createDividedSnapshotWithoutPaddedHorizontal];
    UIView *darkView = [self createDividedSnapshotWithoutPaddedHorizontal];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDividedSnapshotWithoutPaddedHorizontalAndLargeCornerStyle {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:NO];
    [[dividedCard.heightAnchor constraintGreaterThanOrEqualToConstant:2 * BPKSpacingLg] setActive:YES];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    firstInnerView.text = @"Lorem ipsum";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];
    dividedCard.cornerStyle = BPKCardCornerStyleLarge;

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    return parentView;
}

- (void)testDividedSnapshotWithoutPaddedHorizontalAndLargeCornerStyle {
    UIView *lightView = [self createDividedSnapshotWithoutPaddedHorizontalAndLargeCornerStyle];
    UIView *darkView = [self createDividedSnapshotWithoutPaddedHorizontalAndLargeCornerStyle];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDividedSnapshotWithoutPaddedVertical {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:NO];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    firstInnerView.text = @"Lorem ipsum";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor panjin];
    secondInnerView.backgroundColor = [BPKColor monteverde];

    dividedCard.orientation = UILayoutConstraintAxisVertical;

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    return parentView;
}

- (void)testDividedSnapshotWithoutPaddedVertical {
    UIView *lightView = [self createDividedSnapshotWithoutPaddedVertical];
    UIView *darkView = [self createDividedSnapshotWithoutPaddedVertical];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDividedSnapshotWithVerticalSolidLine {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:YES];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    firstInnerView.text = @"Lorem ipsum";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor statusDangerFillColor];
    secondInnerView.backgroundColor = [BPKColor statusSuccessFillColor];

    dividedCard.orientation = UILayoutConstraintAxisVertical;
    dividedCard.lineStyle = BPKCardDividerLineSolid;

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    return parentView;
}

- (void)testDividedSnapshotVerticalSolidLine {
    UIView *lightView = [self createDividedSnapshotWithVerticalSolidLine];
    UIView *darkView = [self createDividedSnapshotWithVerticalSolidLine];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (UIView *)createDividedSnapshotWithVerticalSolidLineWithoutPadding {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectZero];
    BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPadded:NO];
    BPKLabel *firstInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    BPKLabel *secondInnerView = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    firstInnerView.text = @"Lorem ipsum";
    secondInnerView.text = @"dolor sit amet";
    firstInnerView.backgroundColor = [BPKColor statusDangerFillColor];
    secondInnerView.backgroundColor = [BPKColor statusSuccessFillColor];

    dividedCard.orientation = UILayoutConstraintAxisVertical;
    dividedCard.lineStyle = BPKCardDividerLineSolid;

    [self configureDividedCard:dividedCard firstInnerView:firstInnerView secondInnerView:secondInnerView];
    [self configureParentView:parentView forCard:dividedCard];
    return parentView;
}

- (void)testDividedSnapshotVerticalSolidLineWithouPadding {
    UIView *lightView = [self createDividedSnapshotWithVerticalSolidLineWithoutPadding];
    UIView *darkView = [self createDividedSnapshotWithVerticalSolidLineWithoutPadding];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end

NS_ASSUME_NONNULL_END
