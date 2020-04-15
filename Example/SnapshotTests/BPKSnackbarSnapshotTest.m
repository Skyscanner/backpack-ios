/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019 Skyscanner Ltd. All rights reserved.
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

#import <Backpack/Icon.h>
#import <Backpack/Snackbar.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKSnackbarSnapshotTest : FBSnapshotTestCase
@property(nonatomic, strong) UIViewController *parentViewController;
@end

@implementation BPKSnackbarSnapshotTest
- (void)setUp {
    [super setUp];
    self.recordMode = NO;
    self.parentViewController = [[UIViewController alloc] init];
    self.parentViewController.view.frame = [[UIScreen mainScreen] bounds];
}

- (void)testSnackbarWithTitle {
    BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithTitle:@"Snackbar Title"
                                                          text:nil
                                                      duration:BPKSnackbarDurationShort
                                                viewController:self.parentViewController
                                                      delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

- (void)testSnackbarWithTitleAndText {
    BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithTitle:@"Snackbar Title"
                                                          text:@"Descriptive text"
                                                      duration:BPKSnackbarDurationShort
                                                viewController:self.parentViewController
                                                      delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}


- (void)testSnackbarWithitleAndRightButton {
    UIImage *closeIcon = [BPKIcon templateIconNamed:@"close" size:BPKIconSizeSmall];
    BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithTitle:@"Snackbar Title"
                                                          text:nil
                                                        button:[BPKSnackbarButton buttonWithIcon:closeIcon title:@"Button Title"]
                                                      leftIcon:nil
                                                      duration:BPKSnackbarDurationShort
                                                viewController:self.parentViewController
                                                      delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

- (void)testSnackbarWithitleAndRightButtonIconOnly {
    UIImage *closeIcon = [BPKIcon templateIconNamed:@"close" size:BPKIconSizeSmall];
    BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithTitle:@"Snackbar Title"
                                                          text:nil
                                                        button:[BPKSnackbarButton buttonWithIcon:closeIcon accessibilityLabel:@"Close"]
                                                      leftIcon:nil
                                                      duration:BPKSnackbarDurationShort
                                                viewController:self.parentViewController
                                                      delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

- (void)testSnackbarWithitleAndRightButtonAndAccesoryIcon {
    UIImage *closeIcon = [BPKIcon templateIconNamed:@"close" size:BPKIconSizeSmall];
    UIImage *leftIcon = [BPKIcon templateIconNamed:@"tick-circle" size:BPKIconSizeSmall];
    BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithTitle:@"Snackbar Title"
                                                          text:nil
                                                        button:[BPKSnackbarButton buttonWithIcon:closeIcon title:@"Button Title"]
                                                      leftIcon:leftIcon
                                                      duration:BPKSnackbarDurationShort
                                                viewController:self.parentViewController
                                                      delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

- (void)testSnackbarWithLongTitleAndRightButton {
    UIImage *closeIcon = [BPKIcon templateIconNamed:@"close" size:BPKIconSizeSmall];
    BPKSnackbar *snackBar =
        [[BPKSnackbar alloc] initWithTitle:@"Snackbar Title Snackbar Title Snackbar Title Snackbar Title"
                                      text:nil
                                    button:[BPKSnackbarButton buttonWithIcon:closeIcon title:@"Button Title"]
                                  leftIcon:nil
                                  duration:BPKSnackbarDurationShort
                            viewController:self.parentViewController
                                  delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

- (void)testSnackbarWithLongTitleLongTextAndRightButton {
    UIImage *closeIcon = [BPKIcon templateIconNamed:@"close" size:BPKIconSizeSmall];
    BPKSnackbar *snackBar =
        [[BPKSnackbar alloc] initWithTitle:@"Snackbar Title Snackbar Title Snackbar Title Snackbar Title"
                                      text:@"Long text long text long text"
                                    button:[BPKSnackbarButton buttonWithIcon:closeIcon title:@"Button Title"]
                                  leftIcon:nil
                                  duration:BPKSnackbarDurationShort
                            viewController:self.parentViewController
                                  delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

@end
NS_ASSUME_NONNULL_END
