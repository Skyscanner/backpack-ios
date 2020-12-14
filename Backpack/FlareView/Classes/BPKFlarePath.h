/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import "BPKFlarePosition.h"

NS_ASSUME_NONNULL_BEGIN

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
IB_DESIGNABLE @interface BPKFlarePath : NSObject

/**
 * Creates and returns a UIBeizerPath of the flare mask for a given size.
 *
 * @param size CGSize of the path required.
 * @param flareHeight CGFloat height of the flare required.
 * @param cornerRadius CGFloat cornerRadius to apply to the four corners of the rectangle area.
 * @param flarePosition BPKFlarePosition of the path required.
 */
+ (UIBezierPath *)flareViewPathForSize:(CGSize)size
                           flareHeight:(CGFloat)flareHeight
                          cornerRadius:(CGFloat)cornerRadius
                         flarePosition:(BPKFlarePosition)flarePosition NS_SWIFT_NAME(makeFlarePath(size:flareHeight:
                                                                                                   cornerRadius:
                                                                                                   flarePosition:));
@end

NS_ASSUME_NONNULL_END
