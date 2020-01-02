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

#import "BPKSnackbarProtocol.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Snackbar duration
 *
 * BPKSnackbarDurationIndefinite   the snackbar wont disappear.
 * BPKSnackbarDurationShort  the snackbar will disappear after 2 seconds.
 * BPKSnackbarDurationLong  the snackbar will disappear after 3.5 seconds.
 */
typedef NS_ENUM(NSInteger, BPKSnackbarDuration) {
    BPKSnackbarDurationIndefinite,
    BPKSnackbarDurationShort,
    BPKSnackbarDurationLong
};

NS_SWIFT_NAME(Snackbar) @interface BPKSnackbar : UIView

/**
 *  Creates a new Snackbar instance and shows it into the screen
 *
 *  @param title    The content that is displayed in the snackbar's title
 *  @param duration     time for the snackbar to disappear
 *  @param viewController   viewController where the snackbar will be presented
 *  @param delegate   class that conform the BPKSnackbarProtocol
 */
- (instancetype)initWithTitle:(NSString *)title
                     duration:(BPKSnackbarDuration)duration
               viewController:(UIViewController *)viewController
                     delegate:(id<BPKSnackbarProtocol> _Nullable)delegate;

/**
 *  Creates a new Snackbar instance and shows it into the screen
 *
 *  @param title    The content that is displayed in the snackbar's title
 *  @param buttonTitle  Right button title
 *  @param buttonIcon   Right button icon
 *  @param leftIcon     Left icon displayed before the titleThe text content that is displayed inside the snackbar
 *  @param duration     time for the snackbar to disappear
 *  @param viewController   viewController where the snackbar will be presented
 *  @param delegate   class that conform the BPKSnackbarProtocol
 */
- (instancetype)initWithTitle:(NSString *)title
                  buttonTitle:(NSString *_Nullable)buttonTitle
                   buttonIcon:(UIImage *_Nullable)buttonIcon
                     leftIcon:(UIImage *_Nullable)leftIcon
                     duration:(BPKSnackbarDuration)duration
               viewController:(UIViewController *)viewController
                     delegate:(id<BPKSnackbarProtocol> _Nullable)delegate;

/**
 *  Show the snackbar
 */
- (void)show;

/**
 *  Dismiss the snackbar
 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
