/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import "BPKGradientLayer.h"

#import "BPKGradient.h"

NS_ASSUME_NONNULL_BEGIN
@implementation BPKGradientLayer

- (instancetype)init {
    self = [super init];

    if (self) {
        self.needsDisplayOnBoundsChange = YES;
    }

    return self;
}

- (void)setGradient:(BPKGradient *_Nullable)gradient {
    _gradient = gradient;

    // NOTE: We could not make this work with `needsDisplayForKey:`
    // this this explicit call is required.
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    CGContextSaveGState(ctx);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);

    if (self.gradient == nil) {
        CGContextRestoreGState(ctx);
        return;
    }

    NSArray<UIColor *> *colors = self.gradient.colors;
    NSArray<NSNumber *> *stops = self.gradient.stops;

    NSAssert(colors.count == stops.count, @"`colors` and `stops` must have the same length");
    if (colors.count != stops.count) {
        CGContextRestoreGState(ctx);
        return;
    }

    if (colors.count == 0 || width == 0.0 || height == 0.0) {
        CGContextRestoreGState(ctx);
        return;
    }

    CGFloat *locations = nil;
    locations = malloc(sizeof(CGFloat) * colors.count);
    for (NSInteger i = 0; i < colors.count; i++) {
        locations[i] = stops[i].floatValue;
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSMutableArray *cgColors = [[NSMutableArray alloc] initWithCapacity:colors.count];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)color.CGColor];
    }
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)cgColors, locations);
    free(locations);
    CGPoint start = self.gradient.startPoint, end = self.gradient.endPoint;
    CGContextDrawLinearGradient(ctx, gradient, CGPointMake(start.x * width, start.y * height), CGPointMake(end.x * width, end.y * height),
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(ctx);
}
NS_ASSUME_NONNULL_END

@end
