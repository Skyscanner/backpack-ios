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

+ (UIBezierPath *)flareViewPathForSize:(CGSize)size flareSize:(CGSize)flareSize flarePosition:(BPKFlarePosition)flarePosition {
    UIBezierPath *path = [[UIBezierPath alloc] init];

    CGFloat contentBottom = size.height - flareSize.height;

    CGPoint firstCorner = CGPointZero;
    CGPoint secondCorner = CGPointZero;
    CGPoint thirdCorner = CGPointZero;
    CGPoint fourthCorner = CGPointZero;

    switch (flarePosition) {
    case BPKFlarePositionBottom:
        // top-left:
        firstCorner = CGPointMake(0, 0);

        // bottom-left:
        secondCorner = CGPointMake(0.0, contentBottom);

        // bottom-right:
        thirdCorner = CGPointMake(size.width, contentBottom);

        // top-right:
        fourthCorner = CGPointMake(size.width, 0.0);
        break;
    case BPKFlarePositionTop:
        // bottom-left:
        firstCorner = CGPointMake(0, size.height);

        // top-left:
        secondCorner = CGPointMake(0.0, BPKFlareHeight);

        // top-right:
        thirdCorner = CGPointMake(size.width, BPKFlareHeight);

        // bottom-right:
        fourthCorner = CGPointMake(size.width, size.height);
        break;
    }

    [path moveToPoint:firstCorner];
    [path addLineToPoint:secondCorner];

    // flare shape
    [self appendFlareToPath:path size:size flareSize:flareSize flarePosition:flarePosition];

    [path addLineToPoint:thirdCorner];
    [path addLineToPoint:fourthCorner];
    [path addLineToPoint:firstCorner];

    return path;
}

#pragma mark Private

+ (void)appendFlareToPath:(UIBezierPath *)path size:(CGSize)size flareSize:(CGSize)flareSize flarePosition:(BPKFlarePosition)flarePosition {
    CGFloat scaleX = flareSize.width / BPKFlareVectorWidth;
    CGFloat scaleY = scaleX;

    CGFloat startPointX = (size.width - flareSize.width) / 2.0;
    CGFloat startPointY = size.height - flareSize.height;

    if (flarePosition == BPKFlarePositionTop) {
        startPointY = BPKFlareHeight;
        scaleY = -1 * scaleX;
    }
    CGPoint sp = CGPointMake(startPointX, startPointY);

    [path addLineToPoint:CGPointMake(sp.x + 238 * scaleX, sp.y + 0 * scaleY)];
    [path addLineToPoint:CGPointMake(sp.x + 233.671 * scaleX, sp.y + 0 * scaleY)];
    [path addCurveToPoint:CGPointMake(sp.x + 204.307 * scaleX, sp.y + 8.517 * scaleY)
            controlPoint1:CGPointMake(sp.x + 223.336095 * scaleX, sp.y + 0.409248008 * scaleY)
            controlPoint2:CGPointMake(sp.x + 213.256908 * scaleX, sp.y + 3.33270635 * scaleY)];
    [path addLineToPoint:CGPointMake(sp.x + 136.264 * scaleX, sp.y + 47.858 * scaleY)];
    [path addLineToPoint:CGPointMake(sp.x + 136.264 * scaleX, sp.y + 47.858 * scaleY)];
    [path addCurveToPoint:CGPointMake(sp.x + 101.736 * scaleX, sp.y + 47.858 * scaleY)
            controlPoint1:CGPointMake(sp.x + 125.632 * scaleX, sp.y + 54.043 * scaleY)
            controlPoint2:CGPointMake(sp.x + 112.469 * scaleX, sp.y + 54.043 * scaleY)];
    [path addLineToPoint:CGPointMake(sp.x + 33.592 * scaleX, sp.y + 8.518 * scaleY)];
    [path addCurveToPoint:CGPointMake(sp.x + 4.276 * scaleX, sp.y + 0 * scaleY)
            controlPoint1:CGPointMake(sp.x + 24.682 * scaleX, sp.y + 3.345 * scaleY)
            controlPoint2:CGPointMake(sp.x + 14.604 * scaleX, sp.y + 0.303 * scaleY)];
    [path addLineToPoint:CGPointMake(sp.x + 0 * scaleX, sp.y + 0 * scaleY)];
}

@end

NS_ASSUME_NONNULL_END
