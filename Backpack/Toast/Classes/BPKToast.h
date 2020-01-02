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
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BPKToastMode) {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    BPKToastModeIndeterminate,
    /** Shows only labels */
    BPKToastModeText
};

/**
 * `BPKToast` is a subclass of `UIView` configured with Skyscanner style properties.
 */
NS_SWIFT_NAME(Toast) IB_DESIGNABLE @interface BPKToast : UIView

/**
 * BPKToast operation mode. The default is BPKToastModeIndeterminate.
 *
 * @see BPKToastMode
 */
@property(nonatomic, assign) BPKToastMode mode;

/**
 * The minimum time (in seconds) that the Toast is shown.
 * This avoids the problem of the Toast being shown and than instantly hidden.
 * Defaults to 0 (no minimum show time).
 */
@property(assign) float minShowTime;

/**
 * An optional short message to be displayed below the activity indicator. The Toast is automatically resized to fit
 * the entire text. If the text is too long it will get clipped by displaying "..." at the end. If left unchanged or
 * set to @"", then no message is displayed.
 */
@property(nonatomic, copy) NSString *labelText;

/**
 * An optional details message displayed below the labelText message. This message is displayed only if the labelText
 * property is also set and is different from an empty string (@""). The details text can span multiple lines.
 */
@property(nonatomic, copy) NSString *detailsLabelText;

/**
 * Removes the Toast from its parent view when hidden.
 * Defaults to NO.
 */
@property(nonatomic, assign) BOOL removeFromSuperViewOnHide;

/**
 * Creates a new Toast, adds it to provided view and shows it.
 *
 * @note This method sets `removeFromSuperViewOnHide`. The Toast will automatically be removed from the view hierarchy
 * when hidden.
 *
 * @param view The view that the Toast will be added to
 * @param animated If set to YES the Toast will appear using the current animationType. If set to NO the Toast will not
 * use animations while appearing.
 * @return A reference to the created Toast.
 *
 */
+ (instancetype)showToastAddedTo:(UIView *)view animated:(BOOL)animated;

/**
 * A convenience constructor that initializes the Toast with the view's bounds. Calls the designated constructor with
 * view.bounds as the parameter
 *
 * @param view The view instance that will provide the bounds for the Toast. Should be the same instance as
 * the Toast's superview (i.e., the view that the Toast will be added to).
 */
- (instancetype)initWithView:(UIView *)view;

/**
 * Display the Toast. You need to make sure that the main thread completes its run loop soon after this method call so
 * the user interface can be updated. Call this method when your task is already set-up to be executed in a new thread
 * (e.g., when using something like NSOperation or calling an asynchronous call like NSURLRequest).
 *
 * @param animated If set to YES the Toast will appear using the current animationType. If set to NO the Toast will not
 * use animations while appearing.
 *
 */
- (void)show:(BOOL)animated;

/**
 * Hide the Toast. This is the counterpart of the show: method.
 * Use it to hide the Toast when your task completes.
 *
 * @param animated If set to YES the Toast will disappear using the current animationType. If set to NO the Toast will
 * not use animations while disappearing.
 *
 */
- (void)hide:(BOOL)animated;

/**
 * Hide the Toast after a delay. This is the counterpart of the show: method.
 * Use it to hide the Toast when your task completes.
 *
 * @param animated If set to YES the Toast will disappear using the current animationType. If set to NO the Toast will
 * not use animations while disappearing.
 * @param delay Delay in seconds until the Toast is hidden.
 *
 */
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
