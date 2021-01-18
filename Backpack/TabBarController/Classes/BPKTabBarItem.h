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
IB_DESIGNABLE @interface BPKTabBarItem : UITabBarItem

@property(nullable, strong) UIImage *originalImage;

@property(nonatomic) UIUserInterfaceStyle interfaceStyle;

@property(nullable, strong) BPKTabBarDotImageDefinition *dotImageDefinition;

@property BOOL dotShown;

@property (nonatomic) BOOL selected;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag dotImageDefinition:(BPKTabBarDotImageDefinition *)dotImageDefinition;

-(void)addDot;

-(void)removeDot;

@end

NS_ASSUME_NONNULL_END
