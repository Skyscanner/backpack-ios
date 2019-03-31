/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2019 Skyscanner Ltd
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

/**
 * A container view controller that manages the application of a theme for its hierarchy of
 * views.
 *
 * The view controller hierarchy and thus view hierarchy contained in the controller is conditionally
 * rendered inside a container. By leveraging the container relationship consumers can use
 * `UIAppearance` to alter the look of all views rendered within the container.
 */
NS_SWIFT_NAME(ThemeContainerController) @interface BPKThemeContainerController : UIViewController

/**
 * Create an instance with a given container view and root view controller.
 *
 * @param container The container view to render the root view controller's view hierarchy inside.
 * @param rootViewController The root view controller to be used as a child view controller.
 * @return A configured instance than can further be contained or set to be the `rootViewController` of a `window`.
 */
- (instancetype)initWithThemeContainer:(UIView *)container
                    rootViewController:(UIViewController *)rootViewController NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
    __attribute__((unavailable("use initWithThemeContainer:rootViewController: instead")));
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil
    __attribute__((unavailable("use initWithThemeContainer:rootViewController: instead")));

- (BPKThemeContainerController *)createIdenticalThemeContainerForRootController:(UIViewController *)rootController;

/**
 * Controls whether the theme defined in the container is currently active. The default value is `YES`.
 * Changing the value of this property will immediately cause the view hierarchy to update to reflect the
 * new state. As such it should only be called on the main thread.
 */
@property(nonatomic, assign, getter=isThemeActive) BOOL themeActive;

/**
 * The theme container that is currently being used if the theme is active.
 * Changing the value of this property will immediately cause the view hierarchy to update to reflect the
 * new state. As such it should only be called on the main thread.
 */
@property(nonatomic, strong) UIView *themeContainer;
@end

NS_ASSUME_NONNULL_END
