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

#import <Foundation/Foundation.h>

#import <Backpack/Button.h>

NS_ASSUME_NONNULL_BEGIN
@class BPKDialogButtonAction;

/**
 * Handler function called when an action in a dialog is invoked.
 */
typedef void (^BPKDialogButtonActionHandler)(BPKDialogButtonAction *);

/**
 * An object describing individual button actions in a
 * `BPKDialogController` or `BPKDialogView`. Each action
 * has an associated handler to invoke when the button is
 * tapped or otherwise triggered.
 */
@interface BPKDialogButtonAction : NSObject

/**
 * The style of the button.
 *
 * @see BPKButtonStyle
 */
@property(nonatomic, assign, readonly) BPKButtonStyle style;

/**
 * The title of the button.
 */
@property(nonatomic, copy, readonly) NSString *title;

/**
 * The handler to invoke when the button is tapped.
 */
@property(nonatomic, strong, readonly) BPKDialogButtonActionHandler handler;

/**
 * Create an instance of the class.
 *
 * @param title The title to use.
 * @param style The style of the `BPKButton` to use.
 * @param handler The handler to invoke when the button is tapped.
 */
+ (instancetype _Nonnull)actionWithTitle:(NSString *)title style:(BPKButtonStyle)style handler:(BPKDialogButtonActionHandler)handler;

/// :nodoc:
- (instancetype _Nonnull)init __attribute__((unavailable("init not available, use actionWithTitle:")));

@end
NS_ASSUME_NONNULL_END
