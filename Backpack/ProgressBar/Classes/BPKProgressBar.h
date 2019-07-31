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

/**
 * Enum values for specifying the style of progress bar
 */
typedef NS_ENUM(NSUInteger, BPKProgressBarStyle) {
    BPKProgressBarStyleRounded = 0,
    BPKProgressBarStyleBar = 1,
};

/**
 * `BPKProgressBar` is a lightweight subclass of `UIProgressView` with Skyscanner styling applied.
 */
NS_SWIFT_NAME(ProgressBar) IB_DESIGNABLE @interface BPKProgressBar : UIProgressView

/**
 * The colour to use in the progress track.
 */
@property(nonatomic, strong) UIColor *fillColor UI_APPEARANCE_SELECTOR;

@property(nonatomic) BPKProgressBarStyle style;

@end
NS_ASSUME_NONNULL_END
