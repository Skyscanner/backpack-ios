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
#import <Backpack/DarkMode.h>
#import <Backpack/Font.h>
#import <Backpack/TextView.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface BPKBorkedDarkModeSnapshotTest : FBSnapshotTestCase
@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKBorkedDarkModeSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIColor *)dynamicColor1 {
#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return UIColor.greenColor;
                } else {
                    return UIColor.purpleColor;
                }
     }];
}
#endif
  return UIColor.blackColor;
}

- (UIColor *)dynamicColor2 {
#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return UIColor.orangeColor;
                } else {
                    return UIColor.cyanColor;
                }
     }];
}
#endif
  return UIColor.blackColor;
}

- (UIView *)buildView {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    parentView.backgroundColor = [self dynamicColor1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"This is a test";
    label.textColor = [self dynamicColor2];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addSubview:label];
    [NSLayoutConstraint activateConstraints:@[
        [label.leadingAnchor constraintEqualToAnchor:parentView.leadingAnchor constant:16.0],
        [label.topAnchor constraintEqualToAnchor:parentView.topAnchor constant:16.0]
    ]];
    return parentView;
}

- (void)testBorkednessOfXCTestsWithDarkmodeOverrides {
    UIView *lightView = [self buildView];

    FBSnapshotVerifyView(lightView, @"light-mode");

    UIView *darkView = [self buildView];
    if (@available(iOS 13.0, *)) {
        darkView.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        printf("NOT USING IOS 13.0");
        darkView.backgroundColor = UIColor.blackColor;
    }

    FBSnapshotVerifyView(darkView, @"dark-mode");
}

@end

NS_ASSUME_NONNULL_END
