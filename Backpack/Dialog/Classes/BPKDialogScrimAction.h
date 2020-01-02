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

NS_ASSUME_NONNULL_BEGIN

/**
* Handler function called when the scrim action is invoked by the user tapping the scrim.
*/
typedef void (^BPKDialogScrimActionHandler)(BOOL didDismiss);

/**
 * An object describing the action to take when the scrim
 * of a `BPKDialogController` is tapped by the user.
 */
NS_SWIFT_NAME(DialogScrimAction) @interface BPKDialogScrimAction : NSObject

/**
 * A block to invoke when the user taps the scrim.
 */
@property(nonatomic, strong, readonly) BPKDialogScrimActionHandler handler;

/**
 * Whether the whole controller should be dismissed on scrim taps.
 */
@property(nonatomic, assign, readonly) BOOL shouldDismiss;

/**
 * Create an instance of the class.
 *
 * @param handler The handler to associate with the action.
 * @param shouldDismiss Wether the controller should dimiss on scrim taps.
 */
+ (instancetype _Nonnull)actionWithHandler:(BPKDialogScrimActionHandler)handler shouldDismiss:(BOOL)shouldDismiss;

/// :nodoc:
- (instancetype _Nonnull)init
    __attribute__((unavailable("use the static method configurationWithActionHandler: instead")));

@end

NS_ASSUME_NONNULL_END
