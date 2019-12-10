#import "BPKFontManager.h"

@interface BPKFontManager ()
@end

@implementation BPKFontManager

- (instancetype)init {
    self = [super init];

    if (self) {
        [self generateCacheKey];
    }

    return self;
}

+ (instancetype)sharedInstance {
    static BPKFontManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sharedInstance = [[BPKFontManager alloc] init];
    });
    return sharedInstance;
}

- (UIFont *)fontWithName:(NSString *_Nullable)name size:(CGFloat)size weight:(UIFontWeight)weight {
    if (name == nil) {
        return [UIFont systemFontOfSize:size weight:weight];
    }

    UIFont *font = [UIFont fontWithName:name size:size];
    NSString *error = [NSString
        stringWithFormat:@"The fontface %@ is not available. Please make sure you have installed it correctly!", name];
    NSAssert(font != nil, error);
    if (font != nil) {
        return font;
    }

    return [UIFont systemFontOfSize:size weight:weight];
}

- (UIFont *)regularFontWithSize:(CGFloat)size {
    NSString *fontName = self.fontDefinition ? self.fontDefinition.regularFontFace : nil;
    return [self fontWithName:fontName size:size weight:UIFontWeightRegular];
}

- (UIFont *)semiboldFontWithSize:(CGFloat)size {
    NSString *fontName = self.fontDefinition ? self.fontDefinition.semiboldFontFace : nil;
    return [self fontWithName:fontName size:size weight:UIFontWeightSemibold];
}

- (UIFont *)heavyFontWithSize:(CGFloat)size {
    NSString *fontName = self.fontDefinition ? self.fontDefinition.heavyFontFace : nil;
    return [self fontWithName:fontName size:size weight:UIFontWeightHeavy];
}

- (void)setFontDefinition:(id<BPKFontDefinitionProtocol>)fontDefinition {
    if (_fontDefinition != fontDefinition) {
        _fontDefinition = fontDefinition;
        [self generateCacheKey];
    }
}

- (void)generateCacheKey {
    _cacheKey = [NSUUID UUID].UUIDString;
}

@end
