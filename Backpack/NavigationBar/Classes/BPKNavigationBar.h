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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BPKNavigationBarButton;

NS_ASSUME_NONNULL_BEGIN
/**
 * A navigation bar component similar to `UINavigationBar` from UIKit implementing
 * the iOS 11 style large title pattern.
 */
NS_SWIFT_NAME(NavigationBar) @interface BPKNavigationBar : UIView
/**
 * A `BPKNavigationBarButton` to show on the left side inside the navigation
 */
@property(nonatomic, strong) BPKNavigationBarButton *leftButton;

/**
 * A `BPKNavigationBarButton` to show on the right side inside the navigation
 */
@property(nonatomic, strong) BPKNavigationBarButton *rightButton;

/**
 * The title text to display in the navigation bar
 */
@property(nonatomic, copy) NSString *title;

/**
 * Set the color of the large title. When `nil` the
 * default color, BPKColor.skyGray` will be used.
 */
@property(nonatomic, strong, nullable) UIColor *largeTitleTextColor UI_APPEARANCE_SELECTOR;

/**
 * The layout margins for the large title.
 */
@property(nonatomic, assign) UIEdgeInsets largeTitleLayoutMargins;

/**
 * The text alignment of the large title text.
 */
@property(nonatomic, assign) NSTextAlignment largeTitleTextAlignment;

/**
 * Initializes and returns a newly allocated navigation bar by decoding a NSCoder
 *
 * @param aDecoder The decoder to deocde
 * @return An initialized `BPKNavigationBar`
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Initializes and returns a newly allocated navigation bar with a specific frame
 *
 * @param frame The frame to use
 * @return An initialized `BPKNavigationBar`
 */

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * Prepare the navigation bar for use with a `UIScrollView`.
 * This method should be called in `viewDidLoad` or at another
 * appropriate time in the view lifecycle.
 * This method **must** be called before any calls to
 * `updateWithScrollView:`.
 *
 * @param scrollView The scrollview that the receiver will track.
 */
- (void)setUpForScrollview:(UIScrollView *)scrollView NS_SWIFT_NAME(setUp(for:));

/**
 * Update the state of the navigation bar based on the state
 * of the `UIScrollView` that this navigation bar tracks.
 * Users **should** call this method everytime the scrollview
 * scrolls by implementing `scrollViewDidScroll:`.
 *
 * @param scrollView The scrollview to base updates on.
 */
- (void)updateWithScrollView:(UIScrollView *)scrollView;

/**
 * Will adjust the `UIScrollView` if necessary in order to ensure
 * that the title is fully visible.
 * Users **should** call this method everytime the scrollview
 * ends decelerating using `scrollViewDidEndDecelerating:`, and
 * also everytime the scrollview ends dragging (unless it will decelerate)
 * using `scrollViewDidEndDragging:willDecelerate`.
 *
 * @param scrollView The scrollview to base updates on.
 */
- (void)makeTitleVisibleWithScrollView:(UIScrollView *)scrollView;

@end
NS_ASSUME_NONNULL_END
