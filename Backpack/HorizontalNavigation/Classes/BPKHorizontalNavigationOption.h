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

#import <Backpack/Icon.h>

#import "BPKHorizontalNavigationOptionType.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A single option within a horizontal navigation.
 *
 * Can be configured to show an optional icon, always includes a name.
 */
@interface BPKHorizontalNavigationOption : NSObject<BPKHorizontalNavigationOptionType>

/**
 * Name of the optional icon used in the option.
 */
@property(nonatomic, readonly, strong, nullable) BPKIconName iconName;

/**
 * A tag representing the option, can be used to distinguish options from
 * eachother.
 */
@property(nonatomic, readonly) NSInteger tag;

/**
 * Name of the option displayed in the horizontal nav.
 */
@property(nonatomic, readonly, copy) NSString *name;

/**
 * Whether the option has an icon. True if `iconName` is non-nil.
 */
@property(nonatomic, readonly) BOOL hasIcon;

/**
 * Intialize an option with a given name.
 *
 * @param name The name of the option.
 * @return A named option.
 */
- (instancetype)initWithName:(NSString *)name;

/**
* Intialize an option with a given name and tag.
*
* @param name The name of the option.
* @param tag The tag of the option.
* @return A named option with a tag.
*/
- (instancetype)initWithName:(NSString *)name tag:(NSInteger)tag;

/**
* Intialize an option with a given name and icon.
*
* @param name The name of the option.
* @param iconName The name of the icon to display.
* @return A named option with an icon.
*/
- (instancetype)initWithName:(NSString *)name iconName:(BPKIconName)iconName;

/**
* Intialize an option with a given name, tag, and icon.
*
* @param name The name of the option.
* @param iconName The name of the icon to display.
* @param tag The tag of the option.
* @return A named option with an icon and a tag.
*/
- (instancetype)initWithName:(NSString *)name iconName:(BPKIconName)iconName tag:(NSInteger)tag;

/**
* Intialize an option with a given name, tag, and icon.
*
* @param name The name of the option.
* @param tag The tag of the option.
* @param showDot send YES to show a red notification dot
* @return A named option with a tag and a notification dot.
*/
- (instancetype)initWithName:(NSString *)name
                         tag:(NSInteger)tag
         showNotificationDot:(BOOL)showDot;

/**
* Intialize an option with a given name, tag, and icon.
*
* @param name The name of the option.
* @param tag The tag of the option.
* @param iconName The name of the icon to display.
* @param showDot send YES to show a red notification dot
* @return A named option with an icon, a tag and a notification dot.
*/
- (instancetype)initWithName:(NSString *)name
                         tag:(NSInteger)tag
                    iconName:(BPKIconName)iconName
         showNotificationDot:(BOOL)showDot;
@end
NS_ASSUME_NONNULL_END
