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

/**
 * `BPKButtonAppearance` is a subclass of `NSObject` that describes the appearance of a button using colour properties for each aspect of the button's visual appearance.
 */
@interface BPKButtonAppearance : NSObject

/**
 * The color of the button border, if shown
 */
@property(nullable, nonatomic, strong) UIColor *borderColor;

/**
 * The color of the top of the button background gradient
 */
@property(nullable, nonatomic, strong) UIColor *gradientStartColor;

/**
 * The color of the bottom of the button background gradient
 */
@property(nullable, nonatomic, strong) UIColor *gradientEndColor;

/**
 * The color of the button foreground, including text, icons and spinners.
 */
@property(nullable, nonatomic, strong) UIColor *foregroundColor;

/*
 * Creates an instance of `BPKButtonAppearence` with the values provided.
 */
- (instancetype)initWithBorderColor:(UIColor *_Nullable)borderColor gradientStartColor:(UIColor *)gradientStartColor gradientEndColor:(UIColor *)gradientEndColor foregroundColor:(UIColor *)foregroundColor;

/*
 * Creates a new instance of `BPKButtonAppearance` with the same apearance properties as the current instance.
 */
- (instancetype)clone;

@end

NS_ASSUME_NONNULL_END
