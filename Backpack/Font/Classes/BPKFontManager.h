#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BPKFontDefinitionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKFontManager : NSObject

@property(nullable, nonatomic) id<BPKFontDefinitionProtocol> fontDefinition;
@property(nonatomic) BOOL dynamicTypeEnabled;

+ (instancetype)sharedInstance;

- (UIFont *)regularFontWithSize:(CGFloat)size textStyle:(UIFontTextStyle)style;
- (UIFont *)semiboldFontWithSize:(CGFloat)size textStyle:(UIFontTextStyle)style;
- (UIFont *)heavyFontWithSize:(CGFloat)size textStyle:(UIFontTextStyle)style;

@end

NS_ASSUME_NONNULL_END
