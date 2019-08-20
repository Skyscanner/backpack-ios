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

// Original vector dimensions: 234.0x53.0
CGFloat const BPKFlareHeight = 20;
CGFloat const BPKFlareWidth = 88.301886792;
CGFloat const BPKFlareVectorWidth = 234.0;
CGFloat const BPKFlareVectorHeight = 53.0;

+ (UIBezierPath *)flareViewPathForSize:(CGSize)size {
    UIBezierPath *path = [[UIBezierPath alloc] init];

    CGFloat contentBottom = size.height - BPKFlareHeight;

    // top-left:
    [path moveToPoint:CGPointMake(0.0, 0.0)];

    // bottom-left:
    [path addLineToPoint:CGPointMake(0.0, contentBottom)];

    // bottom-right:
    [path addLineToPoint:CGPointMake(size.width, contentBottom)];

    // top-right:
    [path addLineToPoint:CGPointMake(size.width, 0.0)];

    UIBezierPath *flarePath = [self flarePathForSize:size];
    [path appendPath:flarePath];

    return path;
}

#pragma mark Private

+ (UIBezierPath *)flarePathForSize:(CGSize)size {
    UIBezierPath *flarePath = [self flarePath];
    CGAffineTransform translation =
        CGAffineTransformMakeTranslation((size.width - BPKFlareWidth) / 2.0, size.height - BPKFlareHeight);
    [flarePath applyTransform:translation];
    return flarePath;
}

+ (UIBezierPath *)flarePath {
    static dispatch_once_t onceToken;
    static UIBezierPath *flarePath;
    dispatch_once(&onceToken, ^{
      flarePath = [self generateflarePath];
    });
    return [flarePath copy];
}

+ (UIBezierPath *)generateflarePath {
    UIBezierPath *path = [[UIBezierPath alloc] init];

    [path moveToPoint:CGPointMake(136.264, 47.858)];
    [path addCurveToPoint:CGPointMake(101.736, 47.858)
            controlPoint1:CGPointMake(125.632, 54.043)
            controlPoint2:CGPointMake(112.469, 54.043)];
    [path addLineToPoint:CGPointMake(33.592, 8.518)];
    [path addCurveToPoint:CGPointMake(4.276, 0)
            controlPoint1:CGPointMake(24.682, 3.345)
            controlPoint2:CGPointMake(14.604, 0.303)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(238, 0)];
    [path addLineToPoint:CGPointMake(233.671, 0)];
    [path addCurveToPoint:CGPointMake(204.307, 8.517)
            controlPoint1:CGPointMake(223.336095, 0.409248008)
            controlPoint2:CGPointMake(213.256908, 3.33270635)];
    [path addLineToPoint:CGPointMake(136.264, 47.858)];

    CGFloat scale = BPKFlareWidth / BPKFlareVectorWidth;
    CGAffineTransform scaleTransformation = CGAffineTransformMakeScale(scale, scale);
    [path applyTransform:scaleTransformation];

    return path;
}

@end

NS_ASSUME_NONNULL_END
