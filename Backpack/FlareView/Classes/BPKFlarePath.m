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

+ (UIBezierPath *)flarePathForSize:(CGSize)size {
    UIBezierPath *path = [[UIBezierPath alloc] init];

    CGFloat contentBottom = size.height - BPKFlareHeight;

    // top-left:
    [path moveToPoint:CGPointMake(0.0, 0.0)];

    // bottom-left:
    [path addLineToPoint:CGPointMake(0.0, contentBottom)];

    // Flare shape accross bottom:
    [self addFlarePointsToPath:path
                    startPoint:CGPointMake(0.0, contentBottom)
                      endPoint:CGPointMake(size.width, contentBottom)];

    // bottom-right:
    [path addLineToPoint:CGPointMake(size.width, contentBottom)];

    // top-right:
    [path addLineToPoint:CGPointMake(size.width, 0.0)];

    return path;
}

#pragma mark Private

+ (CGPoint)mapPoint:(CGPoint)point withinSpace:(CGSize)space startPoint:(CGPoint)startPoint {
    CGFloat vectorWidth = 234.0;
    CGFloat vectorHeight = 53.0;
    CGFloat scaledX = space.width * point.x / vectorWidth;
    CGFloat scaledY = space.height * point.y / vectorHeight;

    return CGPointMake(startPoint.x + scaledX, startPoint.y + scaledY);
}

+ (void)addFlarePointsToPath:(UIBezierPath *)path startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CGSize flareSize = CGSizeMake(BPKFlareWidth, BPKFlareHeight);

    CGPoint centerPoint = CGPointMake((startPoint.x + endPoint.x) / 2.0, startPoint.y);
    CGPoint curveStartPoint = CGPointMake(centerPoint.x - (BPKFlareWidth / 2.0), startPoint.y);
    CGPoint curveEndPoint = CGPointMake(centerPoint.x + (BPKFlareWidth / 2.0), startPoint.y);

    // Line to the top-left of the flare
    [path addLineToPoint:CGPointMake(curveStartPoint.x, curveStartPoint.y)];

    // point 1:
    [path addCurveToPoint:[self mapPoint:CGPointMake(2.28, 0.0) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint1:[self mapPoint:CGPointMake(2.28, 0.0) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint2:[self mapPoint:CGPointMake(12.6, 0.3) withinSpace:flareSize startPoint:curveStartPoint]];

    // point 2:
    [path addCurveToPoint:[self mapPoint:CGPointMake(31.59, 8.52) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint1:[self mapPoint:CGPointMake(22.68, 3.35) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint2:[self mapPoint:CGPointMake(31.59, 8.52) withinSpace:flareSize startPoint:curveStartPoint]];

    // point 3:
    [path addCurveToPoint:[self mapPoint:CGPointMake(99.74, 47.86) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint1:[self mapPoint:CGPointMake(99.74, 47.86) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint2:[self mapPoint:CGPointMake(110.47, 54.04) withinSpace:flareSize startPoint:curveStartPoint]];

    // point 4:
    [path addCurveToPoint:[self mapPoint:CGPointMake(134.26, 47.86) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint1:[self mapPoint:CGPointMake(123.53, 54.04) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint2:[self mapPoint:CGPointMake(134.26, 47.86) withinSpace:flareSize startPoint:curveStartPoint]];

    // point 5:
    [path addCurveToPoint:[self mapPoint:CGPointMake(202.41, 8.52) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint1:[self mapPoint:CGPointMake(202.41, 8.52) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint2:[self mapPoint:CGPointMake(211.32, 3.35) withinSpace:flareSize startPoint:curveStartPoint]];

    // point 6:
    [path addCurveToPoint:[self mapPoint:CGPointMake(231.72, 0.0) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint1:[self mapPoint:CGPointMake(221.4, 0.3) withinSpace:flareSize startPoint:curveStartPoint]
            controlPoint2:[self mapPoint:CGPointMake(231.72, 0.0) withinSpace:flareSize startPoint:curveStartPoint]];

    [path addLineToPoint:CGPointMake(curveEndPoint.x, curveEndPoint.y)];
}

@end

NS_ASSUME_NONNULL_END
