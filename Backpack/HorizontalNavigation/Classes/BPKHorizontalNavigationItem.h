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
#import <Backpack/Button.h>

#import "BPKHorizontalNavigation.h"

NS_ASSUME_NONNULL_BEGIN

@class BPKHorizontalNavigationOption;
NS_SWIFT_NAME(HorizontalNavigationItem) IB_DESIGNABLE @interface BPKHorizontalNavigationItem : UIButton

@property(nullable, nonatomic, strong) UIColor *selectedColor UI_APPEARANCE_SELECTOR;

/**
 * The font mapping of the horizontal navigation.
 *
 * see BPKFontMapping
 */
@property(nonatomic) BPKFontMapping *fontMapping;

/**
 * The definition of the option, which will be displayed as a button in the component.
 *
 * see BPKHorizontalNavigationOption
 */
@property(readonly, nullable, nonatomic, strong) BPKHorizontalNavigationOption *definition;

/**
 * Create a `BPKHorizontalNavigationItem` with a set of options and an optionaly selected option.
 *
 * @param definition BPKHorizontalNavigationOption the specification for the navigation item
 */
- (instancetype)initWithDefinition:(BPKHorizontalNavigationOption *)definition NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style NS_UNAVAILABLE;

@end
NS_ASSUME_NONNULL_END
