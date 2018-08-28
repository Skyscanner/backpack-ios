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
#import <Backpack/Badge.h>
#import <Backpack/Color.h>

@interface BPKBadgeSnapshotTest : FBSnapshotTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKBadgeSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)buildParentView {
    // 375x812 = iPhone X dimensions.
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 812)];
    parentView.backgroundColor = [BPKColor gray100];
    return parentView;
}

- (UIStackView *)buildStackView {
    UIStackView *stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 100, 812)];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualCentering;
    return stackView;
}

- (void)testViewSnapshotWithTypes {
    BPKBadgeType types[] = {
        BPKBadgeTypeLight,
        BPKBadgeTypeInverse,
        BPKBadgeTypeOutline,
        BPKBadgeTypeSuccess,
        BPKBadgeTypeWarning,
        BPKBadgeTypeDestructive
    };
    
    NSUInteger length = sizeof(types) / sizeof(types[0]);
    UIStackView *stackView = [self buildStackView];
    
    for (NSUInteger i = 0; i < length; i++) {
        BPKBadge *badge = [[BPKBadge alloc] initWithType:types[i] message:@"Backpack rocks"];
        [stackView addArrangedSubview:badge];
    }
    UIView *parentView = [self buildParentView];
    [parentView addSubview:stackView];
    FBSnapshotVerifyView(parentView, nil);
}

@end

NS_ASSUME_NONNULL_END
