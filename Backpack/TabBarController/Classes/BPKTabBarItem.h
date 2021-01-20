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

NS_ASSUME_NONNULL_BEGIN

@class BPKTabBarDotImageDefinition;

/**
 * `BPKTabBarItem` is a subclass of `UITabBarItem` configured with Skyscanner style properties.
 */
IB_DESIGNABLE @interface BPKTabBarItem: UITabBarItem

/**
 * The base image to use when a dot is not shown
 */
@property(nullable, strong) UIImage *originalImage;

/**
 * The images to show when a dot is applied.
 */
@property(nullable, strong) BPKTabBarDotImageDefinition *dotImageDefinition;

/**
 * The interface style to be used in determining which dot image to use.
 * Has no effect when a dot is not shown.
 */
@property(nonatomic) UIUserInterfaceStyle interfaceStyle;

/**
 * Whether the dot should be shown on the tab bar item or not.
 */
@property(nonatomic) BOOL dotShown;

/**
 * Whether the tab bar item is selected or not
 */
@property(nonatomic) BOOL selected;

/**
 * Create a `BPKTabBarItem`..
 *
 * @param title The title to show in the tab bar item.
 * @param image The image to show in the tab bar item when there is no dot.
 * @param tag The tag to assign to the tab bar item.
 * @param dotImageDefinition The images to show in the tab bar item when a dot is shown.
 * @return `BPKTabBarItem` instance.
 */
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag dotImageDefinition:(BPKTabBarDotImageDefinition *)dotImageDefinition;

/**
 * Apply the dot by using the dotImageDefinition images
 */
-(void)addDot;

/**
 * Remove the dot if currently shown.
 */
-(void)removeDot;

@end

NS_ASSUME_NONNULL_END
