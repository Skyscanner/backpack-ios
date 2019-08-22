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
 * The height at which the BPKFlare should be rendered
 */
extern CGFloat const BPKFlareHeight;

/**
 * The width at which the BPKFlare should be rendered
 */
extern CGFloat const BPKFlareWidth;

/**
 * The width of the original flare vector
 */
extern CGFloat const BPKFlareVectorWidth;

/**
 * The height of the original flare vector
 */
extern CGFloat const BPKFlareVectorHeight;

/**
 * `BPKFlarePath` is class that can provide the flare shape in the form of a BeizerPath
 */
NS_SWIFT_NAME(FlarePath) IB_DESIGNABLE @interface BPKFlarePath : NSObject

/**
 * Creates and returns a UIBeizerPath of the flare mask for a given size.
 *
 * @param size CGSize of the path required.
 */
+ (UIBezierPath *)flareViewPathForSize:(CGSize)size NS_SWIFT_NAME(makeFlarePath(size:));

@end

NS_ASSUME_NONNULL_END
