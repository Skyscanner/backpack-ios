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

#import "BPKDialogButtonAction.h"
#import "BPKDialogViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A `UIView` subclass that renders the content of a Backpack Dialog. Used by
 * `BPKDialogView`.
 *
 * @see BPKDialogView
 */
@interface BPKDialogContentView : UIView <UIGestureRecognizerDelegate>

/**
 * The delegate of the view.
 */
@property(nonatomic, weak) id<BPKDialogViewDelegate> delegate;

/**
 * The size of the buttons. By default this is `BPKButtonSizeLarge`.
 */
@property(nonatomic, assign) BPKButtonSize buttonSize;

/**
 * The title to display in the view.
 */
@property(nullable, nonatomic, copy) NSString *title;

/**
 * The description to display in the view.
 */
@property(nullable, nonatomic, copy) NSString *message;

/**
 * Whether the reiever has at least one button action configured.
 */
@property(nonatomic, readonly, assign) BOOL hasButtonActions;

/**
 * Whether the reiever has a non-empty title set.
 */
@property(nonatomic, readonly, assign) BOOL hasTitle;

/**
 * Set the alignment of the text in the content view, this will change how the title and message align
 */
@property(nonatomic, assign) NSTextAlignment textAlignment;

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
