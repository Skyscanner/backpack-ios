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

- (void)testSnackbarWithText {
    BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithText:@"Descriptive text"
                                                        title:nil
                                                     duration:BPKSnackbarDurationShort
                                               viewController:self.parentViewController
                                                     delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

- (void)testSnackbarWithTextAndTitle {
    BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithText:@"Descriptive text"
                                                        title:@"Snackbar Title"
                                                     duration:BPKSnackbarDurationShort
                                               viewController:self.parentViewController
                                                     delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}


- (void)testSnackbarWithTextAndRightButton {
    BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithText:@"Descriptive text"
                                                        title:nil
                                                       button:[BPKSnackbarButton buttonWithTitle:@"Button title"]
                                                      leftIcon:nil
                                                      duration:BPKSnackbarDurationShort
                                                viewController:self.parentViewController
                                                      delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

- (void)testSnackbarWithTextAndRightButtonIconOnly {
    UIImage *closeIcon = [BPKIcon smallTemplateIconNamed:BPKSmallIconNameClose];
    BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithText:@"Descriptive text"
                                                        title:nil
                                                       button:[BPKSnackbarButton buttonWithIcon:closeIcon accessibilityLabel:@"Close"]
                                                     leftIcon:nil
                                                     duration:BPKSnackbarDurationShort
                                               viewController:self.parentViewController
                                                     delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

- (void)testSnackbarWithTextAndRightButtonAndAccesoryIcon {
    UIImage *closeIcon = [BPKIcon smallTemplateIconNamed:BPKSmallIconNameClose];
    UIImage *leftIcon = [BPKIcon smallTemplateIconNamed:BPKSmallIconNameTickCircle];
    BPKSnackbar *snackBar = [[BPKSnackbar alloc] initWithText:@"Descriptive text"
                                                        title:nil
                                                       button:[BPKSnackbarButton buttonWithIcon:closeIcon accessibilityLabel:@"Close"]
                                                     leftIcon:leftIcon
                                                     duration:BPKSnackbarDurationShort
                                               viewController:self.parentViewController
                                                     delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

- (void)testSnackbarWithLongTextAndRightButton {
    BPKSnackbar *snackBar =
        [[BPKSnackbar alloc] initWithText:@"Descriptive text Descriptive text Descriptive text Descriptive text"
                                    title:nil
                                   button:[BPKSnackbarButton buttonWithTitle:@"Button Title"]
                                 leftIcon:nil
                                 duration:BPKSnackbarDurationShort
                           viewController:self.parentViewController
                                 delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

- (void)testSnackbarWithLongTextLongTitleAndRightButton {
    BPKSnackbar *snackBar =
        [[BPKSnackbar alloc] initWithText:@"Long text long text long text"
                                    title:@"Snackbar Title Snackbar Title Snackbar Title Snackbar Title"
                                   button:[BPKSnackbarButton buttonWithTitle:@"Button Title"]
                                 leftIcon:nil
                                 duration:BPKSnackbarDurationShort
                           viewController:self.parentViewController
                                 delegate:nil];
    [snackBar show];
    FBSnapshotVerifyView(self.parentViewController.view, nil);
}

@end
NS_ASSUME_NONNULL_END
