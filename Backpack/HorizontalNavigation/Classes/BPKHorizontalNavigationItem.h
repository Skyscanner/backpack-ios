/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import "BPKHorizontalNavigationAppearance.h"
#import "BPKHorizontalNavigationSize.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BPKHorizontalNavigationItem
@required

/**
 * The size of the horizontal navigation.
 *
 * see BPKHorizontalNavigationSize
 */
@property(nonatomic, assign) BPKHorizontalNavigationSize size;

/**
 * The selected colour to use.
 *
 * This colour should be used to change the UI to make it clear
 * that the item is selected.
 */
@property(nonatomic, nullable, strong) UIColor *selectedColor;

@property(nonatomic, assign) BPKHorizontalNavigationAppearance appearance;

@end

NS_ASSUME_NONNULL_END
