#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __has_include(<Backpack_Common/Backpack_Common-Swift.h>)
#import <Backpack_Common/Backpack_Common-Swift.h>
#elif __has_include("Backpack_Common-Swift.h")
#import "Backpack_Common-Swift.h"
#else
@protocol BPKFontDefinitionProtocol <NSObject>
@property(nonatomic, copy, readonly) NSString *fontFamily;
@property(nonatomic, copy, readonly) NSString *regularFontFace;
@property(nonatomic, copy, readonly) NSString *semiboldFontFace;
@property(nonatomic, copy, readonly) NSString *blackFontFace;
@property(nonatomic, copy, readonly) NSString *heavyFontFace;
@end
#endif

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
