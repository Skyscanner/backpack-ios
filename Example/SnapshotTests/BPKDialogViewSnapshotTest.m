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

#import <Backpack/Dialog.h>

#import <Backpack/Color.h>
#import <Backpack/Icon.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKDialogViewSnapshotTest : FBSnapshotTestCase

@end

@implementation BPKDialogViewSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)wrapDialog:(BPKDialogView *)dialogView {
    UIView *parent = [[UIView alloc] initWithFrame:CGRectZero];
    parent.layoutMargins = UIEdgeInsetsMake(BPKSpacingBase, BPKSpacingBase, BPKSpacingBase, BPKSpacingBase);
    parent.translatesAutoresizingMaskIntoConstraints = NO;
    parent.backgroundColor = BPKColor.white;
    [parent addSubview:dialogView];

    [NSLayoutConstraint activateConstraints:@[
        [parent.layoutMarginsGuide.topAnchor constraintEqualToAnchor:dialogView.topAnchor],
        [parent.layoutMarginsGuide.leadingAnchor constraintEqualToAnchor:dialogView.leadingAnchor],
        [dialogView.trailingAnchor constraintEqualToAnchor:parent.layoutMarginsGuide.trailingAnchor],
        [dialogView.bottomAnchor constraintEqualToAnchor:parent.layoutMarginsGuide.bottomAnchor],
    ]];

    return parent;
}

- (void)testDialogViewNoButtons {
    BPKDialogView *view = [[BPKDialogView alloc]
              initWithTitle:@"Lorem Ipsum"
                    message:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tempor dapibus laoreet. "
                            @"Maecenas pharetra bibendum condimentum. Nulla malesuada euismod justo, vel commodo metus "
                            @"venenatis vitae. Cras sollicitudin porttitor semper."
        iconBackgroundColor:BPKColor.green500
                  iconImage:[BPKIcon templateIconNamed:BPKIconNameTick size:BPKIconSizeLarge]];

    view.style = BPKDialogControllerStyleAlert;
    [view.widthAnchor constraintLessThanOrEqualToConstant:320].active = YES;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *parent = [self wrapDialog:view];
    [parent layoutIfNeeded];

    FBSnapshotVerifyView(parent, nil);
}

- (void)testDialogViewWithButtons {
    BPKDialogView *view = [[BPKDialogView alloc]
              initWithTitle:@"Lorem Ipsum"
                    message:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tempor dapibus laoreet. "
                            @"Maecenas pharetra bibendum condimentum. Nulla malesuada euismod justo, vel commodo metus "
                            @"venenatis vitae. Cras sollicitudin porttitor semper."
        iconBackgroundColor:BPKColor.yellow500
                  iconImage:[BPKIcon templateIconNamed:BPKIconNameLightning size:BPKIconSizeLarge]];
    BPKDialogButtonAction *continueAction = [BPKDialogButtonAction actionWithTitle:@"Continue"
                                                                             style:BPKButtonStylePrimary
                                                                           handler:^(BPKDialogButtonAction *action){

                                                                           }];
    BPKDialogButtonAction *skipAction = [BPKDialogButtonAction actionWithTitle:@"Skipz"
                                                                         style:BPKButtonStyleLink
                                                                       handler:^(BPKDialogButtonAction *action){

                                                                       }];

    [view addButtonAction:continueAction];
    [view addButtonAction:skipAction];

    view.style = BPKDialogControllerStyleAlert;
    [view.widthAnchor constraintLessThanOrEqualToConstant:320].active = YES;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *parent = [self wrapDialog:view];
    [parent layoutIfNeeded];

    FBSnapshotVerifyView(parent, nil);
}

@end
NS_ASSUME_NONNULL_END
