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
#import "BPKFont.h"

#import <Backpack/Color.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKFont()
@property(nonatomic, strong, readonly) NSCache<NSString *, NSDictionary *> *attributesCache;

+ (NSString *)cacheKeyForFontStyle:(BPKFontStyle)style;
+ (UIFont *)fontForStyle:(BPKFontStyle)style;
+ (NSNumber *_Nullable)trackingForStyle:(BPKFontStyle)style;
@end

@implementation BPKFont

+ (UIFont * _Nullable)fontWithStyle:(BPKFontStyle)style {
    switch (style) {
    
        case BPKFontStyleTextBase:
            return [BPKFont textBase];
        case BPKFontStyleTextBaseEmphasized:
            return [BPKFont textBaseEmphasized];
        case BPKFontStyleTextCaps:
            return [BPKFont textCaps];
        case BPKFontStyleTextCapsEmphasized:
            return [BPKFont textCapsEmphasized];
        case BPKFontStyleTextLg:
            return [BPKFont textLg];
        case BPKFontStyleTextLgEmphasized:
            return [BPKFont textLgEmphasized];
        case BPKFontStyleTextSm:
            return [BPKFont textSm];
        case BPKFontStyleTextSmEmphasized:
            return [BPKFont textSmEmphasized];
        case BPKFontStyleTextXl:
            return [BPKFont textXl];
        case BPKFontStyleTextXlEmphasized:
            return [BPKFont textXlEmphasized];
        case BPKFontStyleTextXlHeavy:
            return [BPKFont textXlHeavy];
        case BPKFontStyleTextXs:
            return [BPKFont textXs];
        case BPKFontStyleTextXsEmphasized:
            return [BPKFont textXsEmphasized];
        case BPKFontStyleTextXxl:
            return [BPKFont textXxl];
        case BPKFontStyleTextXxlEmphasized:
            return [BPKFont textXxlEmphasized];
        case BPKFontStyleTextXxlHeavy:
            return [BPKFont textXxlHeavy];
        case BPKFontStyleTextXxxl:
            return [BPKFont textXxxl];
        case BPKFontStyleTextXxxlEmphasized:
            return [BPKFont textXxxlEmphasized];
        case BPKFontStyleTextXxxlHeavy:
            return [BPKFont textXxxlHeavy];
    }

    return nil;
}


+ (UIFont *)textBase {
    return [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
}

+ (UIFont *)textBaseEmphasized {
    return [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
}

+ (UIFont *)textCaps {
    return [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
}

+ (UIFont *)textCapsEmphasized {
    return [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
}

+ (UIFont *)textLg {
    return [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
}

+ (UIFont *)textLgEmphasized {
    return [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
}

+ (UIFont *)textSm {
    return [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
}

+ (UIFont *)textSmEmphasized {
    return [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXl {
    return [UIFont systemFontOfSize:24 weight:UIFontWeightRegular];
}

+ (UIFont *)textXlEmphasized {
    return [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXlHeavy {
    return [UIFont systemFontOfSize:24 weight:UIFontWeightHeavy];
}

+ (UIFont *)textXs {
    return [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
}

+ (UIFont *)textXsEmphasized {
    return [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXxl {
    return [UIFont systemFontOfSize:36 weight:UIFontWeightRegular];
}

+ (UIFont *)textXxlEmphasized {
    return [UIFont systemFontOfSize:36 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXxlHeavy {
    return [UIFont systemFontOfSize:36 weight:UIFontWeightHeavy];
}

+ (UIFont *)textXxxl {
    return [UIFont systemFontOfSize:42 weight:UIFontWeightRegular];
}

+ (UIFont *)textXxxlEmphasized {
    return [UIFont systemFontOfSize:42 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXxxlHeavy {
    return [UIFont systemFontOfSize:42 weight:UIFontWeightHeavy];
}


+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle content:(NSString *)content {
    NSDictionary *attributes = [self attributesForFontStyle:fontStyle];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:content attributes:attributes];

    return attributedString;
}

+ (NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle content:(NSString *)content textColor:(UIColor *)textColor {
    NSMutableDictionary *attributes = [[self attributesForFontStyle:fontStyle] mutableCopy];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:content attributes:[attributes copy]];


    return attributedString;
}


#pragma mark - Private

+ (NSCache<NSString *, NSDictionary *> *)attributesCache {
    static dispatch_once_t onceToken;
    static NSCache *_attributesCache = nil;
    dispatch_once(&onceToken, ^{
        _attributesCache = [[NSCache alloc] init];
    });

    return _attributesCache;
}

+ (NSDictionary *)attributesForFontStyle:(BPKFontStyle)style {
    NSString *cacheKey = [self cacheKeyForFontStyle:style];
    NSDictionary *potentialCacheHit = [[self attributesCache] objectForKey:cacheKey];

    if (potentialCacheHit) {
        return potentialCacheHit;
    }

    UIFont *font = [self fontForStyle:style];
    NSNumber *_Nullable tracking = [self trackingForStyle:style];
    NSDictionary *result;

    if (tracking) {
        result = @{
                   NSKernAttributeName: tracking,
                   NSForegroundColorAttributeName: BPKColor.gray700,
                   NSFontAttributeName: font,
                   };

    } else {
        result = @{
                   NSForegroundColorAttributeName: BPKColor.gray700,
                   NSFontAttributeName: font,
                   };
   }


    [[self attributesCache] setObject:result forKey:cacheKey];

    return result;
}

+ (NSString *)cacheKeyForFontStyle:(BPKFontStyle)style {
    return [NSString stringWithFormat:@"%ld", (unsigned long)style];
}

+ (UIFont *)fontForStyle:(BPKFontStyle)style {
    switch (style) {
        
            case BPKFontStyleTextBase:
                return [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
            case BPKFontStyleTextBaseEmphasized:
                return [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
            case BPKFontStyleTextCaps:
                return [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
            case BPKFontStyleTextCapsEmphasized:
                return [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
            case BPKFontStyleTextLg:
                return [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
            case BPKFontStyleTextLgEmphasized:
                return [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
            case BPKFontStyleTextSm:
                return [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
            case BPKFontStyleTextSmEmphasized:
                return [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
            case BPKFontStyleTextXl:
                return [UIFont systemFontOfSize:24 weight:UIFontWeightRegular];
            case BPKFontStyleTextXlEmphasized:
                return [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold];
            case BPKFontStyleTextXlHeavy:
                return [UIFont systemFontOfSize:24 weight:UIFontWeightHeavy];
            case BPKFontStyleTextXs:
                return [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
            case BPKFontStyleTextXsEmphasized:
                return [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
            case BPKFontStyleTextXxl:
                return [UIFont systemFontOfSize:36 weight:UIFontWeightRegular];
            case BPKFontStyleTextXxlEmphasized:
                return [UIFont systemFontOfSize:36 weight:UIFontWeightSemibold];
            case BPKFontStyleTextXxlHeavy:
                return [UIFont systemFontOfSize:36 weight:UIFontWeightHeavy];
            case BPKFontStyleTextXxxl:
                return [UIFont systemFontOfSize:42 weight:UIFontWeightRegular];
            case BPKFontStyleTextXxxlEmphasized:
                return [UIFont systemFontOfSize:42 weight:UIFontWeightSemibold];
            case BPKFontStyleTextXxxlHeavy:
                return [UIFont systemFontOfSize:42 weight:UIFontWeightHeavy];
            default:
              NSAssert(NO, @"Unknown fontStyle %ld", (unsigned long)style);
    }
}

+ (NSNumber *_Nullable)trackingForStyle:(BPKFontStyle)style {
    switch (style) {
        
            case BPKFontStyleTextBase:
              
                return @(0.12);
              
            case BPKFontStyleTextBaseEmphasized:
              
                return @(0.12);
              
            case BPKFontStyleTextCaps:
              
                return @(0.28);
              
            case BPKFontStyleTextCapsEmphasized:
              
                return @(0.28);
              
            case BPKFontStyleTextLg:
              
                return  nil;
              
            case BPKFontStyleTextLgEmphasized:
              
                return  nil;
              
            case BPKFontStyleTextSm:
              
                return @(0.154);
              
            case BPKFontStyleTextSmEmphasized:
              
                return @(0.154);
              
            case BPKFontStyleTextXl:
              
                return  nil;
              
            case BPKFontStyleTextXlEmphasized:
              
                return  nil;
              
            case BPKFontStyleTextXlHeavy:
              
                return  nil;
              
            case BPKFontStyleTextXs:
              
                return  nil;
              
            case BPKFontStyleTextXsEmphasized:
              
                return  nil;
              
            case BPKFontStyleTextXxl:
              
                return  nil;
              
            case BPKFontStyleTextXxlEmphasized:
              
                return  nil;
              
            case BPKFontStyleTextXxlHeavy:
              
                return  nil;
              
            case BPKFontStyleTextXxxl:
              
                return  nil;
              
            case BPKFontStyleTextXxxlEmphasized:
              
                return  nil;
              
            case BPKFontStyleTextXxxlHeavy:
              
                return  nil;
              
            default:
              NSAssert(NO, @"Unknown fontStyle %ld", (unsigned long)style);
    }
}

@end
NS_ASSUME_NONNULL_END
