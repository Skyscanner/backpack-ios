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

#import "BPKHorizontalNavigationDelegate.h"
#import <Backpack/Font.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKHorizontalNavigation` is a subclass of `UIControl`.
 * The `createHorizontalNavigationItem` method can be overridden to create cutom looking cells.
 * By default it will just return a new instance of `BPKHorizontalNavigationItem`.
 */
@class BPKHorizontalNavigationItem;
@class BPKHorizontalNavigationOption;
NS_SWIFT_NAME(HorizontalNavigation) IB_DESIGNABLE @interface BPKHorizontalNavigation : UIControl

@property(nullable, nonatomic, strong) UIColor *selectedColor UI_APPEARANCE_SELECTOR;

/**
 * The options to display within the navigation.
 *
 * see BPKHorizontalNavigationOption
 */
@property(nonatomic, copy) NSArray<BPKHorizontalNavigationOption *> *options;

/**
 * Whether to show a bar under the selected item
 */
@property(nonatomic) Boolean showSelectedBar;

/**
 * The index of the currently selected item.
 * By default the first item is selected.
 * If the index is out of bounds for the options available (eg -1) then no item will be selected.
 */
@property(nonatomic) NSInteger selectedItem;

/**
 * A delegate that can be informed of changes to the selection.
 */
@property(nonatomic, weak) id<BPKHorizontalNavigationDelegate> delegate;

/**
 * Create a `BPKHorizontalNavigation` with a set of options and an optionaly selected option.
 *
 * @param options NSArray<NSString> the options available to the useR
 * @param selectedItem NSString the initially selected item
 */
- (instancetype)initWithOptions:(NSArray<NSString *> *)options
                       selected:(NSInteger)selectedItem NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end
NS_ASSUME_NONNULL_END
