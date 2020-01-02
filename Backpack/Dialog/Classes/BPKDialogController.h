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

#import "BPKDialogControllerStyle.h"
#import "BPKDialogCornerStyle.h"
#import "BPKDialogView.h"

@class BPKDialogConfiguration;
@class BPKDialogScrimAction;
@class BPKDialogButtonAction;
@class BPKDialogDoneButtonAction;
@class BPKDialogIconDefinition;
@class BPKShadow;

NS_ASSUME_NONNULL_BEGIN

/**
 * A `UIViewController` subclass encapsulating the Backpack dialog component.
 * The controller is preconfigured to use itself as the `transitioningDelegate`
 * consumers should not change this as it breaks the custom transition support.
 * The dialog always contains a title and message as-well as zero or more action buttons.
 * The scrim display behind the content view can be configured to dismiss the view controller
 * where appropriate.
 *
 * The controller is exclusively intended to be used with `presentViewController:`.

 */
NS_SWIFT_NAME(DialogController)
@interface BPKDialogController : UIViewController <BPKDialogViewDelegate, UIViewControllerTransitioningDelegate>

/**
 * The style of the dialog.
 */
@property(nonatomic, assign) BPKDialogControllerStyle style;

/**
 * Add a button action to the dialog. For both styles
 * the buttons actions are display in the order they are
 * added after the title and message.
 *
 * @param action The action to add
 */
- (void)addButtonAction:(BPKDialogButtonAction *)action NS_SWIFT_NAME(addButtonAction(_:));

/**
 * The scrim tap action for the dailog. This action is invoked
 * whenever the scrim is tapped, if `shouldDismiss` is `YES`/`true`
 * the controller is immediately dismissed after calling the handler.
 *
 * @see BPKDialogScrimAction
 */
@property(nonatomic, strong, nullable) BPKDialogScrimAction *scrimAction;

/**
 * The style of the corners of the Dialog.
 *
 * @see BPKDialogCornerStyle
 */
@property(nonatomic, assign) IB_DESIGNABLE BPKDialogCornerStyle cornerStyle;

/**
 * The size of the buttons. By default this is `BPKButtonSizeLarge`.
 */
@property(nonatomic, assign) BPKButtonSize buttonSize;


/// :nodoc:
- (instancetype)init __attribute__((
    unavailable("init not available, use alertControllerWithTitle:message:style:shadow:headColor:iconImage: instead")));

/**
 * Create an instance of the controller.
 *
 * @param title The tile to display in the dialog.
 * @param message The message to display in the body of the dialog.
 * @param style The style of the dialog.
 * @param iconDefinition the icon specification to show at the top of the dialog.
 */
+ (instancetype)dialogControllerWithTitle:(NSString *_Nullable)title
                                  message:(NSString *)message
                                    style:(BPKDialogControllerStyle)style
                           iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition;

/**
 * Create an instance of the controller.
 *
 * @param title The tile to display in the dialog.
 * @param message The message to display in the body of the dialog.
 * @param style The style of the dialog.
 * @param iconDefinition the icon specification to show at the top of the dialog.
 * @param flareView the BPKFlareView to show at the top of the dialog.
 */
+ (instancetype)dialogControllerWithTitle:(NSString *_Nullable)title
                                  message:(NSString *)message
                                    style:(BPKDialogControllerStyle)style
                           iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition
                                flareView:(BPKFlareView *_Nullable)flareView;

// Protected

/**
 * Used internally for animation, not intended for public use.
 */
- (void)_setScrimAlpha:(double)scrimAlpha;

/**
 * Used internally for animation, not intended for public use.
 */
- (void)_addPresentingKeyFrameContentAnimationWithRelativeStartTime:(double)startTime relativeDuration:(double)duration;

/**
 * Used internally for animation, not intended for public use.
 */
- (void)_addDismissingKeyFrameContentAnimationWithRelativeStartTime:(double)startTime relativeDuration:(double)duration;
@end

NS_ASSUME_NONNULL_END
