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
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * An object that represents the icon displayed atop a dialog.
 */
NS_SWIFT_NAME(DialogIconDefinition)
@interface BPKDialogIconDefinition : NSObject

/**
 * The background color behind the icon
 */
@property(nonatomic, strong) UIColor *iconBackgroundColor;

/**
 * The icon to show at the top of the dialog
 */
@property(nonatomic, strong) UIImage *iconImage;

/**
 * Create an instance of `BPKDialogIconDefinition`.
 *
 * @param iconBackgroundColor the background color of the icon view.
 * @param iconImage the icon to render in the icon view. Should preferably
 * be a template image. Otherwise the image must be 24x24 points.
 */
- (instancetype)initWithIcon:(UIImage *)iconImage iconBackgroundColor:(UIColor *)iconBackgroundColor;

@end

NS_ASSUME_NONNULL_END
