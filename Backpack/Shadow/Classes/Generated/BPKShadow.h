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
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UIColor, CALayer;

/**
 * The `BPKShadow` class contains definitions for Backpack shaddows.
 * It has factory methods for creating instances of supported shaddows.
 */
NS_SWIFT_NAME(Shadow) @interface BPKShadow: NSObject

/**
 * The color of the shadow.
 */
@property(nonatomic, strong, readonly) UIColor *color;

/**
 * The offset of the shadow.
 */
@property(nonatomic, readonly) CGSize offset;

/**
 * The opacity of the shadow.
 */
@property(nonatomic, readonly) CGFloat opacity;

/**
 * The radius of the shadow.
 */
@property(nonatomic, readonly) CGFloat radius;

- (instancetype)init __attribute__((unavailable("init not available, use factory methods")));
+ (instancetype)new __attribute__((unavailable("new not available, use factory methods")));

/**
 * Apply the shadow of the reciever to the given `CALayer`.
 * @param layer The layer to apply the shadow to.
 */
- (void)applyToLayer:(CALayer *)layer NS_SWIFT_NAME(apply(to:));


/**
 * The Skyscanner large shadow.
 */
+ (instancetype)shadowLg;

/**
 * The Skyscanner small shadow.
 */
+ (instancetype)shadowSm;

/**
 * The Skyscanner extra large shadow.
 */
+ (instancetype)shadowXl;

@end
NS_ASSUME_NONNULL_END
