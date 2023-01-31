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

#import <UIKit/UIKit.h>

#import <Backpack/FlareView.h>

#import "BPKDialogButtonAction.h"
#import "BPKDialogControllerStyle.h"
#import "BPKDialogCornerStyle.h"
#import "BPKDialogViewDelegate.h"

@class BPKShadow;
@class BPKDialogIconDefinition;

NS_ASSUME_NONNULL_BEGIN

/**
 * A `UIView` subclass that renders the Backpack Dialog. Used by
 * `BPKDialogController`, but can also be used directly in rare cases.
 *
 * @see BPKDialogController
 */
@interface BPKDialogView : UIView <UIGestureRecognizerDelegate>

/**
 * The delegate of the view.
 */
@property(nonatomic, weak) id<BPKDialogViewDelegate> delegate;

/**
 * The style of the dialog.
 */
@property(nonatomic, assign) BPKDialogControllerStyle style;

/**
 * The size of the buttons. By default this is `BPKButtonSizeLarge`.
 */
@property(nonatomic, assign) BPKButtonSize buttonSize;

/**
 * The style of the corners of the Dialog.
 *
 * @see BPKDialogCornerStyle
 */
@property(nonatomic, assign) IB_DESIGNABLE BPKDialogCornerStyle cornerStyle;

/**
 * The background color of the icon view at the top
 */
@property(nullable, nonatomic, strong) BPKDialogIconDefinition *iconDefinition;

/**
 * The title to display in the view.
 */
@property(nullable, nonatomic, copy) NSString *title;

/**
 * The description to display in the view.
 */
@property(nullable, nonatomic, copy) NSString *message;

/**
 * Create an instance of `BPKDialogView`.
 *
 * @param title The title to use.
 * @param message The message to use.
 * @param iconDefinition the icon to show at the top of the dialog.
 * @param flareView the BPKFlareView to show at the top of the dialog.
 */
- (instancetype)initWithTitle:(NSString *_Nullable)title
                      message:(NSString *)message
               iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition
                  graphicView:(BPKFlareView *_Nullable)flareView NS_DESIGNATED_INITIALIZER;

/// :nodoc:
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/// :nodoc:
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Add a single button action to the view. Buttons actions
 * are rendered below the description and are layed out
 * in the order they are added. The delegate is notified
 * when an action is invoked.
 *
 * @param action The action to add.
 */
- (void)addButtonAction:(BPKDialogButtonAction *)action NS_SWIFT_NAME(addButtonAction(_:));

@end
NS_ASSUME_NONNULL_END
