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

#import "BPKContainerController.h"
#import "BPKThemeDefinition.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A subclass of BPKContainerController which manages the application of a theme.
 *
 * The view controller hierarchy and thus view hierarchy contained in the controller is conditionally
 * rendered inside a container. By leveraging the container relationship consumers can use
 * `UIAppearance` to alter the look of all views rendered within the container.
 */
NS_SWIFT_NAME(ThemeContainerController) @interface BPKThemeContainerController : BPKContainerController

/**
 * Create an instance with a given theme and root view controller.
 *
 * @param themeDefinition The theme that we want to wrap the view hierarchy in.
 * @param rootViewController The root view controller to be used as a child view controller.
 * @return A configured instance that can further be contained or set to be the `rootViewController` of a `window`.
 */
- (instancetype)initWithThemeDefinition:(id<BPKThemeDefinition>)themeDefinition
                     rootViewController:(UIViewController *)rootViewController;

- (instancetype)initWithContainerClass:(Class)containerClass
                    rootViewController:(UIViewController *)rootViewController NS_UNAVAILABLE;

/**
 * The theme container that is currently being used if the theme is active.
 * Changing the value of this property will immediately cause the view hierarchy to update to reflect the
 * new state. As such it should only be called on the main thread.
 */
@property(nonatomic, strong) id<BPKThemeDefinition> themeDefinition;
@end

NS_ASSUME_NONNULL_END
