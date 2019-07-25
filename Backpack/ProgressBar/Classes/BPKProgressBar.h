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

#import <Backpack/Font.h>

NS_ASSUME_NONNULL_BEGIN

///**
// * Enum values for specifying the navigation size
// */
//typedef NS_ENUM(NSUInteger, BPKHorizontalNavigationSize) {
//    BPKHorizontalNavigationSizeDefault = 0,
//    BPKHorizontalNavigationSizeSmall = 1,
//};

/**
 * A `BPKHorizontalNavigation` is a control comprising of multiple segments, where each acts as a discrete button.
 */
NS_SWIFT_NAME(ProgressBar) IB_DESIGNABLE @interface BPKProgressBar : UIProgressView

@property(nonatomic, strong) UIColor *fillColor UI_APPEARANCE_SELECTOR;

///**
// * The size of the horizontal navigation.
// *
// * see BPKHorizontalNavigationSize
// */
//@property(nonatomic) BPKHorizontalNavigationSize size;

@end
NS_ASSUME_NONNULL_END
