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

#import "BPKFlarePath.h"

#import <Backpack/Backpack.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKFlarePath

CGFloat const BPKFlareHeight = 20;
CGFloat const BPKFlareWidth = 88.301886792;
CGFloat const BPKFlareVectorWidth = 234.0;
CGFloat const BPKFlareVectorHeight = 53.0;

+ (UIBezierPath *)flareViewPathForSize:(CGSize)size {
    UIBezierPath *path = [[UIBezierPath alloc] init];

    CGFloat contentBottom = size.height - BPKFlareHeight;

    // top-left:
    [path moveToPoint:CGPointMake(0.0, 0.0)];

    // top-right:
    [path addLineToPoint:CGPointMake(size.width, 0.0)];

    // bottom-right:
    [path addLineToPoint:CGPointMake(size.width, contentBottom)];

    // flare shape
    [self appendFlareToPath:path size:size];

    // bottom-left:
    [path addLineToPoint:CGPointMake(0.0, contentBottom)];

    return path;
}

#pragma mark Private

+ (void)appendFlareToPath:(UIBezierPath *)path size:(CGSize)size {
    CGPoint sp = CGPointMake((size.width - BPKFlareWidth) / 2.0, size.height - BPKFlareHeight);
    CGFloat scale = BPKFlareWidth / BPKFlareVectorWidth;

    [path addLineToPoint:CGPointMake(sp.x + 238 * scale, sp.y + 0 * scale)];
    [path addLineToPoint:CGPointMake(sp.x + 233.671 * scale, sp.y + 0 * scale)];
    [path addCurveToPoint:CGPointMake(sp.x + 204.307 * scale, sp.y + 8.517 * scale)
            controlPoint1:CGPointMake(sp.x + 223.336095 * scale, sp.y + 0.409248008 * scale)
            controlPoint2:CGPointMake(sp.x + 213.256908 * scale, sp.y + 3.33270635 * scale)];
    [path addLineToPoint:CGPointMake(sp.x + 136.264 * scale, sp.y + 47.858 * scale)];
    [path addLineToPoint:CGPointMake(sp.x + 136.264 * scale, sp.y + 47.858 * scale)];
    [path addCurveToPoint:CGPointMake(sp.x + 101.736 * scale, sp.y + 47.858 * scale)
            controlPoint1:CGPointMake(sp.x + 125.632 * scale, sp.y + 54.043 * scale)
            controlPoint2:CGPointMake(sp.x + 112.469 * scale, sp.y + 54.043 * scale)];
    [path addLineToPoint:CGPointMake(sp.x + 33.592 * scale, sp.y + 8.518 * scale)];
    [path addCurveToPoint:CGPointMake(sp.x + 4.276 * scale, sp.y + 0 * scale)
            controlPoint1:CGPointMake(sp.x + 24.682 * scale, sp.y + 3.345 * scale)
            controlPoint2:CGPointMake(sp.x + 14.604 * scale, sp.y + 0.303 * scale)];
    [path addLineToPoint:CGPointMake(sp.x + 0 * scale, sp.y + 0 * scale)];
}

@end

NS_ASSUME_NONNULL_END
