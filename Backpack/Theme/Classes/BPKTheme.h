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

NS_ASSUME_NONNULL_BEGIN

/**
 * An abstract base class to define a theme that can be applied to a
 * view hierarchy containing Backpack components. This should be subclassed
 * to create concrete themes.
 */
@protocol BPKThemeDefinition;
NS_SWIFT_NAME(Theme) @interface BPKTheme : NSObject

@property(class, nonatomic, assign, readonly) NSString *didChangeNotification;

/**
 * Returns the themed primary color for a given `UIViewController`.
 *
 * @return the themed `UIColor` value.
 */
+ (UIColor *)primaryColorFor:(UIViewController *)viewController;

/**
 * Creates and returns an instance of the container view for the receiver's theme.
 *
 * @return An instance of the container to use with this theme.
 */
+ (UIView *)containerFor:(id<BPKThemeDefinition>)theme;

/**
 * Apply the theme when contained in the default container
 * as specified in `themeContainerClass`.
 *
 * @see themeContainerClass
 */
+ (void)applyTheme:(id<BPKThemeDefinition>)theme;

/**
 * Apply the theme when contained in a specific view container class.
 *
 * @param class The class of the view to apply the theme to.
 */
+ (void)applyTheme:(id<BPKThemeDefinition>)theme withContainer:(Class)class;

@end

NS_ASSUME_NONNULL_END
