#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BPKFontDefinitionProtocol.h"

@class BPKFontMapping;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(BackpackFontManager)
@interface BPKFontManager : NSObject

@property(nullable, nonatomic) id<BPKFontDefinitionProtocol> fontDefinition;

+ (instancetype)sharedInstance;

- (UIFont *)regularFontWithSize:(CGFloat)size;
- (UIFont *)semiboldFontWithSize:(CGFloat)size;
- (UIFont *)heavyFontWithSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
