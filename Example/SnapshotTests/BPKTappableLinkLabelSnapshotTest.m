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

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/TappableLinkLabel.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface BPKTappableLinkLabelSnapshotTest : FBSnapshotTestCase
@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKTappableLinkLabelSnapshotTest

+ (CGRect)deviceFrame {
    // 375x812 = iPhone X dimensions.
    return CGRectMake(0, 0, 375, 812);
}

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)buildParentView {
    UIView *parentView = [[UIView alloc] initWithFrame:[self class].deviceFrame];
    parentView.backgroundColor = [BPKColor gray100];
    return parentView;
}

- (UIStackView *)buildStackView {
    UIStackView *stackView = [[UIStackView alloc] initWithFrame:[self class].deviceFrame];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualCentering;
    return stackView;
}

- (void)testViewSnapshotWithFontStyle {
    BPKFontStyle styles[] = {BPKFontStyleTextCaps, BPKFontStyleTextXs, BPKFontStyleTextSm,  BPKFontStyleTextBase,
                             BPKFontStyleTextLg,   BPKFontStyleTextXl, BPKFontStyleTextXxl, BPKFontStyleTextXxxl};

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);

    UIStackView *stackView = [self buildStackView];

    for (NSUInteger i = 0; i < length; i++) {
        BPKTappableLinkLabel *label = [[BPKTappableLinkLabel alloc] initWithFontStyle:styles[i]];
        label.text = @"Backpack Rocks";
        [label addLinkToURL:[NSURL URLWithString:@"https://backpack.github.io/"] withRange:NSMakeRange(0, 8)];
        [stackView addArrangedSubview:label];
        [label sizeToFit];
    }
    UIView *parentView = [self buildParentView];
    [parentView addSubview:stackView];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testViewSnapshotWithFontStyleEmphasized {
    BPKFontStyle styles[] = {
        BPKFontStyleTextCapsEmphasized, BPKFontStyleTextXsEmphasized,   BPKFontStyleTextSmEmphasized,
        BPKFontStyleTextBaseEmphasized, BPKFontStyleTextLgEmphasized,   BPKFontStyleTextXlEmphasized,
        BPKFontStyleTextXxlEmphasized,  BPKFontStyleTextXxxlEmphasized,
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);

    UIStackView *stackView = [self buildStackView];

    for (NSUInteger i = 0; i < length; i++) {
        BPKTappableLinkLabel *label = [[BPKTappableLinkLabel alloc] initWithFontStyle:styles[i]];
        label.text = @"Backpack Rocks";
        [label addLinkToURL:[NSURL URLWithString:@"https://backpack.github.io/"] withRange:NSMakeRange(0, 8)];
        [stackView addArrangedSubview:label];
        [label sizeToFit];
    }
    UIView *parentView = [self buildParentView];
    [parentView addSubview:stackView];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testViewSnapshotWithFontStyleHeavy {
    BPKFontStyle styles[] = {
        BPKFontStyleTextXlHeavy,
        BPKFontStyleTextXxlHeavy,
        BPKFontStyleTextXxxlHeavy,
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);

    UIStackView *stackView = [self buildStackView];

    for (NSUInteger i = 0; i < length; i++) {
        BPKTappableLinkLabel *label = [[BPKTappableLinkLabel alloc] initWithFontStyle:styles[i]];
        label.text = @"Backpack Rocks";
        [label addLinkToTransitInformation:@{} withRange:NSMakeRange(0, 8)];
        [stackView addArrangedSubview:label];
        [label sizeToFit];
    }
    UIView *parentView = [self buildParentView];
    [parentView addSubview:stackView];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testViewSnapshotWithAlternateStyle {
    BPKFontStyle styles[] = {BPKFontStyleTextCaps, BPKFontStyleTextXs, BPKFontStyleTextSm,  BPKFontStyleTextBase,
                             BPKFontStyleTextLg,   BPKFontStyleTextXl, BPKFontStyleTextXxl, BPKFontStyleTextXxxl};

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);

    UIStackView *stackView = [self buildStackView];

    for (NSUInteger i = 0; i < length; i++) {
        BPKTappableLinkLabel *label = [[BPKTappableLinkLabel alloc] initWithFontStyle:styles[i]];
        label.text = @"Backpack Rocks";
        label.style = BPKTappableLinkLabelStyleAlternate;
        [label addLinkToURL:[NSURL URLWithString:@"https://backpack.github.io/"] withRange:NSMakeRange(0, 8)];
        [stackView addArrangedSubview:label];
        [label sizeToFit];
    }
    UIView *parentView = [self buildParentView];
    [parentView addSubview:stackView];
    parentView.backgroundColor = BPKColor.blue500;
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testViewSnapshotWithThemeApplied {
    BPKFontStyle styles[] = {
        BPKFontStyleTextCapsEmphasized, BPKFontStyleTextXsEmphasized,   BPKFontStyleTextSmEmphasized,
        BPKFontStyleTextBaseEmphasized, BPKFontStyleTextLgEmphasized,   BPKFontStyleTextXlEmphasized,
        BPKFontStyleTextXxlEmphasized,  BPKFontStyleTextXxxlEmphasized,
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);

    UIStackView *stackView = [self buildStackView];

    for (NSUInteger i = 0; i < length; i++) {
        BPKTappableLinkLabel *label = [[BPKTappableLinkLabel alloc] initWithFontStyle:styles[i]];
        label.fontMapping = [[BPKFontMapping alloc] initWithFamily:@"SnellRoundhand"
                                                   regularFontFace:@"SnellRoundhand"
                                                  semiboldFontFace:@"SnellRoundhand-Bold"
                                                     heavyFontFace:@"SnellRoundhand-Black"];
        label.linkColor = UIColor.orangeColor;
        label.text = @"Backpack Rocks";
        [label addLinkToURL:[NSURL URLWithString:@"https://backpack.github.io/"] withRange:NSMakeRange(0, 8)];
        [stackView addArrangedSubview:label];
        [label sizeToFit];
    }
    UIView *parentView = [self buildParentView];
    [parentView addSubview:stackView];
    FBSnapshotVerifyView(parentView, nil);
}

@end

NS_ASSUME_NONNULL_END
