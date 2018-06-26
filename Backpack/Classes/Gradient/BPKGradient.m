#import "BPKGradient.h"

#import <Backpack/Color.h>
#import <UIKit/UIKit.h>

CGPoint startPointForDirection(BPKGradientDirection direction) {
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

CGPoint endPointForDirection(BPKGradientDirection direction) {
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

NS_ASSUME_NONNULL_BEGIN
@interface BPKGradient()
@property (copy, nonatomic) NSArray<UIColor *> *colors;
@property (nonatomic) NSArray<NSValue *> *stops;
- (instancetype)initPrimaryWithDirection:(BPKGradientDirection)direction;
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@implementation BPKGradient

- (instancetype)initPrimaryWithDirection:(BPKGradientDirection)direction {
    self = [super init];
    
    if (self) {
        self.colors = @[BPKColor.blue500, BPKColor.primaryGradientLight];
        NSValue *start = [NSValue valueWithCGPoint:startPointForDirection(direction)];
        NSValue *end = [NSValue valueWithCGPoint:endPointForDirection(direction)];
        
        self.stops = @[start, end];
    }
    
    return self;
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

@end
NS_ASSUME_NONNULL_END
