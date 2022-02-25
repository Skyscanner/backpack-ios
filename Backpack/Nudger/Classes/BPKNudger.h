/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BPKNudgerConfiguration;

/**
 * A component for selecting a numerical value by incrementing and decrementing in defined steps.
 */
IB_DESIGNABLE @interface BPKNudger : UIControl

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

/// :nodoc:
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

/// :nodoc:
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/// :nodoc:
- (instancetype)initWithFrame:(CGRect)frame primaryAction:(nullable UIAction *)primaryAction NS_UNAVAILABLE;

/**
 * Create a `BPKNudger` with the given configuration.
 *
 * @param configuration The configuration that the nudger will use.
 */
- (instancetype)initWithConfiguration:(BPKNudgerConfiguration *)configuration;

/**
 * The current value of the nudger.
 *
 * Must be between the minimumValue and maximumValue. If you change either minimumValue or maximumValue,
 * the value will automatically align if out of range.
 *
 * The default value of this property is 0.
 */
@property(nonatomic, assign) double value;

/**
 * The minimum value the nudger will allow adjusting to.
 *
 * Must be numerically less than maximumValue. If you attempt to set a value equal to or greater than maximumValue,
 * the receive raises an NSInvalidArgumentException exception.
 * If you set a maximumValue greater than the current value, the current value will align to the maximumValue.
 *
 * The default value of this property is 0.
 */
@property(nonatomic, assign) double minimumValue;

/**
 * The maximum value the nudger will allow adjusting to.
 *
 * Must be numerically greater than minimumValue. If you attempt to set a value equal to or lower than minimumValue,
 * the receiver raises an NSInvalidArgumentException exception.
 * If you set a minimumValue greater than the current value, the current value will align to the minimumValue.
 *
 * The default value of this property is 100.
 */
@property(nonatomic, assign) double maximumValue;

/**
 * The step, or increment, value of the nudger.
 *
 * Must be numerically greater than 0. If you attempt to set this property’s value to 0 or to a negative number,
 * the receiver raises an NSInvalidArgumentException exception.
 *
 * The default value of this property is 1.
 */
@property(nonatomic, assign) double stepValue;

@end
NS_ASSUME_NONNULL_END
