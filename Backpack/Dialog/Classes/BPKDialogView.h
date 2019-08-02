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

#import <UIKit/UIKit.h>

#import "BPKDialogButtonAction.h"
#import "BPKDialogControllerStyle.h"

@class BPKShadow;

NS_ASSUME_NONNULL_BEGIN

@protocol BPKDialogViewDelegate <NSObject>
@required
/**
 * Called when a button action is invoked. At this point the handler has
 * not yet been called. The receiver should call it.
 */
- (void)didInvokeButtonAction:(BPKDialogButtonAction *)action;
@end

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
 * The background color of the icon view at the top
 */
@property(nullable, nonatomic, strong) UIColor *iconBackgroundColor;

/**
 * The icon to display in the icon view at the top.
 * Must be 24x24 points in size. Should preferably
 * be a template image, but can also be a regular
 * image with white content.
 */
@property(nullable, nonatomic, strong) UIImage *iconImage;

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
 * @param iconBackgroundColor the background color of the icon view.
 * @param iconImage the icon to render in the icon view. Should preferably
 *                  be a template image otherwise. The image must be 24x24 points.
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
          iconBackgroundColor:(UIColor *)iconBackgroundColor
                    iconImage:(UIImage *)iconImage;

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
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
