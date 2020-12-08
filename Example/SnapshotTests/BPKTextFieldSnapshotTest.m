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

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/TextField.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface BPKTextFieldSnapshotTest : FBSnapshotTestCase
@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKTextFieldSnapshotTest

+ (CGRect)deviceFrame {
    // 375x812 = iPhone X dimensions.
    return CGRectMake(0, 0, 375, 812);
}

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)buildParentField {
    UIView *parentView = [[UIView alloc] initWithFrame:[self class].deviceFrame];
    parentView.backgroundColor = BPKColor.skyGrayTint06;
    return parentView;
}

- (UIStackView *)buildStackField {
    UIStackView *stackField = [[UIStackView alloc] initWithFrame:[self class].deviceFrame];
    stackField.axis = UILayoutConstraintAxisVertical;
    stackField.distribution = UIStackViewDistributionEqualCentering;
    return stackField;
}

- (void)testTextFieldSnapshotWithFontStyle {
    BPKFontStyle styles[] = {BPKFontStyleTextCaps, BPKFontStyleTextXs, BPKFontStyleTextSm,  BPKFontStyleTextBase,
                             BPKFontStyleTextLg,   BPKFontStyleTextXl, BPKFontStyleTextXxl, BPKFontStyleTextXxxl};

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);

    UIStackView *stackField = [self buildStackField];

    for (NSUInteger i = 0; i < length; i++) {
        BPKTextField *textField = [[BPKTextField alloc] initWithFontStyle:styles[i]];
        textField.text = @"Backpack Rocks";
        [stackField addArrangedSubview:textField];
    }
    UIView *parentView = [self buildParentField];
    [parentView addSubview:stackField];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testTextFieldSnapshotWithFontStyleEmphasized {
    BPKFontStyle styles[] = {
        BPKFontStyleTextCapsEmphasized, BPKFontStyleTextXsEmphasized, BPKFontStyleTextSmEmphasized,  BPKFontStyleTextBaseEmphasized,
        BPKFontStyleTextLgEmphasized,   BPKFontStyleTextXlEmphasized, BPKFontStyleTextXxlEmphasized, BPKFontStyleTextXxxlEmphasized,
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);

    UIStackView *stackField = [self buildStackField];

    for (NSUInteger i = 0; i < length; i++) {
        BPKTextField *textField = [[BPKTextField alloc] initWithFontStyle:styles[i]];
        textField.text = @"Backpack Rocks";
        [stackField addArrangedSubview:textField];
    }
    UIView *parentView = [self buildParentField];
    [parentView addSubview:stackField];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testTextFieldSnapshotWithFontStyleHeavy {
    BPKFontStyle styles[] = {
        BPKFontStyleTextXlHeavy,
        BPKFontStyleTextXxlHeavy,
        BPKFontStyleTextXxxlHeavy,
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);

    UIStackView *stackField = [self buildStackField];

    for (NSUInteger i = 0; i < length; i++) {
        BPKTextField *textField = [[BPKTextField alloc] initWithFontStyle:styles[i]];
        textField.text = @"Backpack Rocks";
        [stackField addArrangedSubview:textField];
    }
    UIView *parentView = [self buildParentField];
    [parentView addSubview:stackField];
    FBSnapshotVerifyView(parentView, nil);
}

- (void)testTextFieldSnapshotWithThemeApplied {
    BPKFontStyle styles[] = {
        BPKFontStyleTextCapsEmphasized, BPKFontStyleTextXsEmphasized, BPKFontStyleTextSmEmphasized,  BPKFontStyleTextBaseEmphasized,
        BPKFontStyleTextLgEmphasized,   BPKFontStyleTextXlEmphasized, BPKFontStyleTextXxlEmphasized, BPKFontStyleTextXxxlEmphasized,
    };

    NSUInteger length = sizeof(styles) / sizeof(styles[0]);

    UIStackView *stackField = [self buildStackField];

    for (NSUInteger i = 0; i < length; i++) {
        BPKTextField *textField = [[BPKTextField alloc] initWithFontStyle:styles[i]];
        textField.text = @"Backpack Rocks";
        textField.textColor = UIColor.orangeColor;
        [stackField addArrangedSubview:textField];
    }
    UIView *parentView = [self buildParentField];
    [parentView addSubview:stackField];
    FBSnapshotVerifyView(parentView, nil);
}

@end

NS_ASSUME_NONNULL_END
