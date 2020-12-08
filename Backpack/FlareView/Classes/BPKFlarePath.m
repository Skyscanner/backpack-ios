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

#import "BPKFlarePath.h"

#import <Backpack/Backpack.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKFlarePath

CGFloat const BPKFlareVectorWidth = 234.0;
CGFloat const BPKFlareVectorHeight = 53.0;

// For information on how this path is calculated, see
// https://github.com/Skyscanner/backpack-ios/blob/master/Backpack/FlareView/reference/FlarePath_calculation.png
+ (UIBezierPath *)flareViewPathForSize:(CGSize)size
                           flareHeight:(CGFloat)flareHeight
                          cornerRadius:(CGFloat)cornerRadius
                         flarePosition:(BPKFlarePosition)flarePosition {
    BOOL hasCornerRadius = cornerRadius > 0.01;

    UIBezierPath *path = [[UIBezierPath alloc] init];

    CGFloat contentTop = 0;
    CGFloat contentBottom = size.height - flareHeight;
    if (flarePosition == BPKFlarePositionTop) {
        contentTop = flareHeight;
        contentBottom = size.height;
    }

    // top-left:
    CGPoint firstCorner = CGPointMake(0, contentTop);
    CGPoint firstCornerCurveStart = CGPointMake(firstCorner.x + cornerRadius, firstCorner.y);
    CGPoint firstCornerCurveEnd = CGPointMake(firstCorner.x, firstCorner.y + cornerRadius);

    // bottom-left:
    CGPoint secondCorner = CGPointMake(0.0, contentBottom);
    CGPoint secondCornerCurveStart = CGPointMake(secondCorner.x, secondCorner.y - cornerRadius);
    CGPoint secondCornerCurveEnd = CGPointMake(secondCorner.x + cornerRadius, secondCorner.y);

    // bottom-right:
    CGPoint thirdCorner = CGPointMake(size.width, contentBottom);
    CGPoint thirdCornerCurveStart = CGPointMake(thirdCorner.x - cornerRadius, thirdCorner.y);
    CGPoint thirdCornerCurveEnd = CGPointMake(thirdCorner.x, thirdCorner.y - cornerRadius);

    // top-right:
    CGPoint fourthCorner = CGPointMake(size.width, contentTop);
    CGPoint fourthCornerCurveStart = CGPointMake(fourthCorner.x, fourthCorner.y + cornerRadius);
    CGPoint fourthCornerCurveEnd = CGPointMake(fourthCorner.x - cornerRadius, fourthCorner.y);

    [path moveToPoint:firstCornerCurveStart];
    if (hasCornerRadius) {
        [path addQuadCurveToPoint:firstCornerCurveEnd controlPoint:firstCorner];
    }
    [path addLineToPoint:secondCornerCurveStart];
    if (hasCornerRadius) {
        [path addQuadCurveToPoint:secondCornerCurveEnd controlPoint:secondCorner];
    }

    if (flarePosition == BPKFlarePositionBottom) {
        // add flare shape at bottom
        [self appendFlareToPath:path size:size flareHeight:flareHeight flarePosition:flarePosition];
    }

    [path addLineToPoint:thirdCornerCurveStart];
    if (hasCornerRadius) {
        [path addQuadCurveToPoint:thirdCornerCurveEnd controlPoint:thirdCorner];
    }
    [path addLineToPoint:fourthCornerCurveStart];
    if (hasCornerRadius) {
        [path addQuadCurveToPoint:fourthCornerCurveEnd controlPoint:fourthCorner];
    }

    if (flarePosition == BPKFlarePositionTop) {
        // add flare shape at top
        [self appendFlareToPath:path size:size flareHeight:flareHeight flarePosition:flarePosition];
    }

    return path;
}

#pragma mark Private

+ (void)appendFlareToPath:(UIBezierPath *)path size:(CGSize)size flareHeight:(CGFloat)flareHeight flarePosition:(BPKFlarePosition)flarePosition {
    CGFloat scale = flareHeight / BPKFlareVectorHeight;
    if (flarePosition == BPKFlarePositionTop) {
        scale = -1 * scale;
    }

    CGFloat flareWidth = scale * BPKFlareVectorWidth;

    CGFloat startPointX = (size.width - flareWidth) / 2.0;
    CGFloat startPointY = size.height - flareHeight;
    if (flarePosition == BPKFlarePositionTop) {
        startPointY = flareHeight;
    }

    CGPoint sp = CGPointMake(startPointX, startPointY);

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
