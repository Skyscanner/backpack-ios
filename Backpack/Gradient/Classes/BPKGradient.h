#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BPKGradientDirection) {
    BPKGradientDirectionUp,
    BPKGradientDirectionDown,
    BPKGradientDirectionLeft,
    BPKGradientDirectionRight,
    BPKGradientDirectionTopLeft,
    BPKGradientDirectionTopRight,
    BPKGradientDirectionBottomLeft,
    BPKGradientDirectionBottomRight,
};

NS_ASSUME_NONNULL_BEGIN
@class UIColor;
@interface BPKGradient: NSObject
@property (copy, nonatomic, readonly) NSArray<UIColor *> *colors;
@property (nonatomic, readonly) NSArray<NSValue *> *stops;

- (instancetype)init __attribute__((unavailable("init not available, use factory methods")));
+ (instancetype)new __attribute__((unavailable("new not available, use factory methods")));

+ (instancetype)primary;
+ (instancetype)primaryWithDirection:(BPKGradientDirection)direction;

@end
NS_ASSUME_NONNULL_END
