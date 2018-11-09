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
#import "BPKGradient.h"

#import <Backpack/Color.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKGradient()
@property(nonatomic, copy) NSArray<UIColor *> *colors;
@property(nonatomic, copy) NSArray<NSNumber *> *stops;
@property(nonatomic) CGPoint startPoint;
@property(nonatomic) CGPoint endPoint;

- (instancetype)initPrimaryWithDirection:(BPKGradientDirection)direction;
- (instancetype)initBaselineScrimWithDirection:(BPKGradientDirection)direction;
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@implementation BPKGradient

- (instancetype)initWithColors:(NSArray<UIColor *> *)colors
                    startPoint:(CGPoint)startPoint
                      endPoint:(CGPoint)endPoint {
    NSMutableArray *stops = [[NSMutableArray alloc] initWithCapacity:colors.count];

    for (NSUInteger i = 0; i < colors.count; i++) {
        stops[i] = @(1.0 / (colors.count - 1) * i);
    }

    return [self initWithColors:colors stops:stops startPoint:startPoint endPoint:endPoint];
}


- (instancetype)initWithColors:(NSArray<UIColor *> *)colors
                         stops:(NSArray<NSNumber *> *)stops
                    startPoint:(CGPoint)startPoint
                      endPoint:(CGPoint)endPoint {
    self = [super init];

    if (self) {
        self.colors = colors;
        self.stops = stops;
        self.startPoint = startPoint;
        self.endPoint = endPoint;
    }

    return self;
}


- (instancetype)initPrimaryWithDirection:(BPKGradientDirection)direction {
    return [self initWithColors:@[BPKColor.blue500, BPKColor.primaryGradientLight]
                     startPoint:[[self class] startPointForDirection:direction]
                       endPoint:[[self class] endPointForDirection:direction]];
}

- (instancetype)initBaselineScrimWithDirection:(BPKGradientDirection)direction {
    return [self initWithColors:@[[BPKColor.gray900 colorWithAlphaComponent:0.6], [[self class] scrimBaselineEndColor]]
                     startPoint:[[self class] startPointForDirection:direction]
                       endPoint:[[self class] endPointForDirection:direction]];
}

+ (instancetype)primary {
    static dispatch_once_t gradientOnceToken;
    static BPKGradient *gradient;
    
    dispatch_once(&gradientOnceToken, ^{
        gradient = [[BPKGradient alloc] initPrimaryWithDirection:BPKGradientDirectionBottomRight];
        
    });
    
    return gradient;
}

+ (instancetype)primaryWithDirection:(BPKGradientDirection)direction {
    static dispatch_once_t gradientOnceToken;
    static NSMutableDictionary<NSNumber *, BPKGradient *> *dict;
    
    dispatch_once(&gradientOnceToken, ^{
        dict = [NSMutableDictionary new];
    });
    @synchronized(dict){
        NSNumber *boxedDirection = [NSNumber numberWithUnsignedInteger:(NSUInteger)direction];
        
        if ([dict objectForKey:boxedDirection] != nil) {
            return [dict objectForKey:boxedDirection];
        }
        
        BPKGradient *gradient = [[BPKGradient alloc] initPrimaryWithDirection:direction];
        [dict setObject:gradient forKey:boxedDirection];
        
        return gradient;
    }
    
    return nil;
}

+ (instancetype)baselineScrim {
    static dispatch_once_t gradientOnceToken;
    static BPKGradient *gradient;

    dispatch_once(&gradientOnceToken, ^{
        gradient = [[BPKGradient alloc] initBaselineScrimWithDirection:BPKGradientDirectionUp];

    });

    return gradient;
}

+ (instancetype)baselineScrimWithDirection:(BPKGradientDirection)direction {
    static dispatch_once_t gradientOnceToken;
    static NSMutableDictionary<NSNumber *, BPKGradient *> *dict;

    dispatch_once(&gradientOnceToken, ^{
        dict = [NSMutableDictionary new];
    });
    @synchronized(dict){
        NSNumber *boxedDirection = [NSNumber numberWithUnsignedInteger:(NSUInteger)direction];

        if ([dict objectForKey:boxedDirection] != nil) {
            return [dict objectForKey:boxedDirection];
        }

        BPKGradient *gradient = [[BPKGradient alloc] initBaselineScrimWithDirection:direction];
        [dict setObject:gradient forKey:boxedDirection];

        return gradient;
    }

    return nil;
}

+ (CGPoint)startPointForDirection:(BPKGradientDirection)direction {
    switch (direction) {
        case BPKGradientDirectionUp:
            return CGPointMake(0.5, 1.0);
        case BPKGradientDirectionDown:
            return CGPointMake(0.5, 0.0);
        case BPKGradientDirectionLeft:
            return CGPointMake(1.0, 0.5);
        case BPKGradientDirectionRight:
            return CGPointMake(0.0, 0.5);
        case BPKGradientDirectionTopLeft:
            return CGPointMake(1.0, 1.0);
        case BPKGradientDirectionTopRight:
            return CGPointMake(0.0, 1.0);
        case BPKGradientDirectionBottomLeft:
            return CGPointMake(1.0, 0.0);
        case BPKGradientDirectionBottomRight:
            return CGPointMake(0.0, 0.0);
        default:
            return CGPointMake(0.0, 0.0);
    }
}

+ (CGPoint)endPointForDirection:(BPKGradientDirection)direction {
    switch (direction) {
        case BPKGradientDirectionUp:
            return CGPointMake(0.5, 0.0);
        case BPKGradientDirectionDown:
            return CGPointMake(0.5, 1.0);
        case BPKGradientDirectionLeft:
            return CGPointMake(0.0, 0.5);
        case BPKGradientDirectionRight:
            return CGPointMake(1.0, 0.5);
        case BPKGradientDirectionTopLeft:
            return CGPointMake(0.0, 0.0);
        case BPKGradientDirectionTopRight:
            return CGPointMake(1.0, 0.0);
        case BPKGradientDirectionBottomLeft:
            return CGPointMake(0.0, 1.0);
        case BPKGradientDirectionBottomRight:
            return CGPointMake(1.0, 1.0);
        default:
            return CGPointMake(1.0, 1.0);
    }
}

+ (UIColor *)scrimBaselineEndColor {
    return [UIColor colorWithRed:0.298 green:0.263 blue:0.384 alpha:0.0];
}

@end
NS_ASSUME_NONNULL_END
