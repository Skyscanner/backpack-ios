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

#import <Backpack/Button.h>
#import <Backpack/Icon.h>

#import "BPKHorizontalNavigation.h"

NS_ASSUME_NONNULL_BEGIN

@class BPKHorizontalNavigationOption;
IB_DESIGNABLE @interface BPKHorizontalNavigationItemDefault : UIButton<BPKHorizontalNavigationItem>

@property(nullable, nonatomic, strong) UIColor *selectedColor UI_APPEARANCE_SELECTOR;

/**
 * The size of the horizontal navigation.
 *
 * see BPKHorizontalNavigationSize
 */
@property(nonatomic) BPKHorizontalNavigationSize size;

@property(nonatomic) BPKHorizontalNavigationAppearance appearance;

/**
 * The icon to display within the item.
 *
 * see BPKIconName
 */
@property(nonatomic, strong, nullable) BPKIconName iconName;

/**
 * The name to display within the item.
 */
@property(nonatomic, copy) NSString *name;

/**
 * Create a `BPKHorizontalNavigationItem` with a set of options and an optionaly selected option.
 *
 * @param name NSString the name for the navigation item
 * @param iconName BPKIconName the icon for the navigation item
 */
- (instancetype)initWithName:(NSString *)name iconName:(BPKIconName)iconName;

/**
 * Create a `BPKHorizontalNavigationItem` with a set of options and an optionaly selected option.
 *
 * @param name NSString the name for the navigation item
 * @param iconName BPKIconName the icon for the navigation item
 * @param showDot send YES to show a red notification dot
 */
- (instancetype)initWithName:(NSString *)name iconName:(BPKIconName)iconName showNotificationDot:(BOOL)showDot NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style NS_UNAVAILABLE;

@end
NS_ASSUME_NONNULL_END
