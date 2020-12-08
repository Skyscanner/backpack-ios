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
#import "BPKIcon.h"

#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN
NSString *const BPKIconFallbackGlyph = @"\u25A1"; // White box glyph
NSString *const BPKIconFontName = @"BpkIconIOS";

@interface BPKIcon ()
@property(class, nonatomic, readonly) UIFont *iconFont;
@property(class, nonatomic, readonly) NSCache<NSString *, UIImage *> *imageCache;
@property(class, nonatomic, readonly) NSParagraphStyle *paragraphStyle;

+ (NSBundle *)iconBundle;
+ (NSString *)cacheKeyForIconNamed:(NSString *)name withColor:(UIColor *)color size:(BPKIconSize)size;
+ (NSString *)stringForUnicodeCodepoint:(nullable NSString *)codepoint;
@end

@implementation BPKIcon
@dynamic imageCache;
@dynamic iconFont;
@dynamic paragraphStyle;
@dynamic iconMapping;

+ (void)load {
#ifdef TARGET_INTERFACE_BUILDER
    // This loading of the icon font breaks IB previews
#else
    NSBundle *bundle = [self iconBundle];

    NSURL *url = [bundle URLForResource:BPKIconFontName withExtension:@"ttf"];
    NSAssert(url != nil, @"`%@.ttf` must be present in the bundle.", BPKIconFontName);
    if (url == nil) {
        return;
    }

    NSError *dataError;
    NSData *fontData = [NSData dataWithContentsOfURL:url options:0 error:&dataError];
    NSAssert(dataError == nil, @"%@.ttf could not be read with error %@", BPKIconFontName, dataError);
    if (dataError != nil) {
        return;
    }

    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);

    if (font) {
        CFErrorRef error = NULL;
        if (CTFontManagerRegisterGraphicsFont(font, &error) == NO) {
            NSError *registerError = (__bridge NSError *)error;

            // If the font has already been registered the error is safe to ignore
            if ([registerError code] != kCTFontManagerErrorAlreadyRegistered) {
                NSAssert(NO, @"Failed to register %@.ttf with error %@", BPKIconFontName,
                         (__bridge_transfer NSString *)CFErrorCopyDescription(error));
            }
        }

        CFRelease(font);
    }

    CFRelease(provider);
#endif
}

+ (UIImage *)templateIconNamed:(NSString *)name size:(BPKIconSize)size {
    UIImage *image = [self iconNamed:name color:UIColor.blackColor size:size];

    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

+ (UIImage *)iconNamed:(NSString *)name color:(UIColor *)color size:(BPKIconSize)size {
    CGSize iconSize = [self concreteSizeForIconSize:size];

    NSString *cacheKey = [self cacheKeyForIconNamed:name withColor:color size:size];
    UIImage *icon = [self.imageCache objectForKey:cacheKey];

    if (icon) {
        return icon;
    }

    UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);

    NSString *codepoint = [self codepointForIcon:name size:size];
    NSString *iconCodepoint = [self stringForUnicodeCodepoint:codepoint];

    UIFont *font = [UIFont fontWithName:BPKIconFontName size:iconSize.height];
    NSAssert(font, @"`BpkIcon` was not correctly registered.");

    if (font == nil) {
        font = [UIFont systemFontOfSize:iconSize.height];
        iconCodepoint = BPKIconFallbackGlyph;
    }

    [iconCodepoint drawInRect:CGRectMake(0, 0, iconSize.width, iconSize.height)
               withAttributes:@{
                   NSFontAttributeName: font,
                   NSForegroundColorAttributeName: color,
                   NSParagraphStyleAttributeName: self.paragraphStyle,
               }];
    icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self.imageCache setObject:icon forKey:cacheKey];

    return icon;
}

+ (NSString *)codepointForIcon:(NSString *)name size:(BPKIconSize)size {
    NSString *lookupKey = name;
    if (size == BPKIconSizeSmall) {
        lookupKey = [NSString stringWithFormat:@"%@%@", name, @"-sm"];
    }

    if (self.iconMapping) {
        NSAssert([self.iconMapping objectForKey:lookupKey],
                 @"Unknown icon `%@` does not correspond to a known icon. Please check that the icon exists at the "
                 @"size you are trying to use https://backpack.github.io/components/icon?platform=design",
                 name);
    }

    return [self.iconMapping objectForKey:lookupKey];
}

#pragma mark - Private

+ (NSCache<NSString *, UIImage *> *)imageCache {
    static NSCache<NSString *, UIImage *> *_imageCache;
    static dispatch_once_t dispatchOnceCacheToken;

    dispatch_once(&dispatchOnceCacheToken, ^{
      _imageCache = [[NSCache alloc] init];
    });

    return _imageCache;
}

+ (NSParagraphStyle *)paragraphStyle {
    static NSParagraphStyle *_paragraphStyle;
    static dispatch_once_t dispatchOnceParagraphStyleToken;

    dispatch_once(&dispatchOnceParagraphStyleToken, ^{
      NSMutableParagraphStyle *mutableStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
      mutableStyle.alignment = NSTextAlignmentCenter;

      _paragraphStyle = [mutableStyle copy];
    });

    return _paragraphStyle;
}

+ (nullable NSDictionary<NSString *, NSString *> *)iconMapping {
    static NSDictionary<NSString *, NSString *> *_iconMapping;
    static dispatch_once_t dispatchOnceiconMappingToken;

    dispatch_once(&dispatchOnceiconMappingToken, ^{
      NSBundle *bundle = [self iconBundle];
      if (bundle == nil) {
          _iconMapping = nil;
          return;
      }

      NSURL *url = [bundle URLForResource:@"iconMapping" withExtension:@"json"];
      NSAssert(url, @"`iconMapping.json` must be present in the bundle.");
      if (url == nil) {
          _iconMapping = nil;
          return;
      }

      NSData *data = [NSData dataWithContentsOfURL:url];
      NSAssert1(data, @"`iconMapping.json` at %@ could not be loaded from the bundle", [url description]);

      NSError *error = nil;
      ;
      NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
      NSAssert(!error, @"Expected `iconMapping.json` to be a valid JSON document, but got error %@", error);
      NSAssert([parsedData isKindOfClass:[NSDictionary class]], @"Expectd `iconMapping.json` to be a dictionary");
      if (error || parsedData == nil || ![parsedData isKindOfClass:[NSDictionary class]]) {
          _iconMapping = nil;
          return;
      }

      _iconMapping = parsedData;
    });

    return _iconMapping;
}

+ (NSBundle *)iconBundle {
    NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
    NSAssert(mainBundle, @"bundleForClass:[BPKIcon class] should return a valid bundle");

    NSURL *iconBundleURL = [[mainBundle resourceURL] URLByAppendingPathComponent:@"Icon.bundle"];
    NSBundle *iconBundle = [NSBundle bundleWithURL:iconBundleURL];
    NSAssert(iconBundle, @"The Backpack Icon bundle should exist at %@", iconBundleURL);

    return iconBundle;
}

+ (NSString *)cacheKeyForIconNamed:(NSString *)name withColor:(UIColor *)color size:(BPKIconSize)size {
    NSString *sizeName;

    switch (size) {
    case BPKIconSizeSmall:
        sizeName = @"sm";
        break;
    case BPKIconSizeLarge:
        sizeName = @"lg";
        break;
    case BPKIconSizeXLarge:
        sizeName = @"xl";
        break;
    default:
        NSAssert(NO, @"Unknown icon size");
        sizeName = @"unknown";
    }

    CGFloat const *components = CGColorGetComponents(color.CGColor);

    return [NSString stringWithFormat:@"%@%@%f%f%f%f", name, sizeName, components[0], components[1], components[2], components[3]];
}

+ (CGSize)concreteSizeForIconSize:(BPKIconSize)size {
    switch (size) {
    case BPKIconSizeSmall:
        return self.concreteSizeForSmallIcon;
        break;
    case BPKIconSizeLarge:
        return self.concreteSizeForLargeIcon;
        break;
    case BPKIconSizeXLarge:
        return self.concreteSizeForXlIcon;
        break;
    default:
        NSAssert(NO, @"Unsupported icon size");
        return self.concreteSizeForSmallIcon;
        break;
    }
}

+ (CGSize)concreteSizeForSmallIcon {
    return CGSizeMake(16, 16);
}

+ (CGSize)concreteSizeForLargeIcon {
    return CGSizeMake(24, 24);
}

+ (CGSize)concreteSizeForXlIcon {
    return CGSizeMake(40, 40);
}

+ (NSString *)stringForUnicodeCodepoint:(nullable NSString *)codepoint {
    if (self.iconMapping && codepoint) {
        NSAssert(codepoint.length <= 4, @"stringForUnicodeCodepoint: expects `codepoint` to be of length 4 at most");
        if (codepoint.length > 4) {
            return BPKIconFallbackGlyph;
        }

        uint32_t code = (uint32_t)strtoul(codepoint.UTF8String, 0, 16);

        uint32_t bytes = htonl(code);
        NSString *result = [[NSString alloc] initWithBytes:&bytes length:4 encoding:NSUTF32StringEncoding];

        return result;
    }

    return BPKIconFallbackGlyph;
}

+ (UIImage *)smallTemplateIconNamed:(BPKSmallIconName)name {
    return [self templateIconNamed:name size:BPKIconSizeSmall];
}

+ (UIImage *)largeTemplateIconNamed:(BPKLargeIconName)name {
    return [self templateIconNamed:name size:BPKIconSizeLarge];
}

+ (UIImage *)xlTemplateIconNamed:(BPKXlIconName)name {
    return [self templateIconNamed:name size:BPKIconSizeXLarge];
}

+ (UIImage *)smallIconNamed:(BPKSmallIconName)name color:(UIColor *)color {
    return [self iconNamed:name color:color size:BPKIconSizeSmall];
}

+ (UIImage *)largeIconNamed:(BPKLargeIconName)name color:(UIColor *)color {
    return [self iconNamed:name color:color size:BPKIconSizeLarge];
}

+ (UIImage *)xlIconNamed:(BPKXlIconName)name color:(UIColor *)color {
    return [self iconNamed:name color:color size:BPKIconSizeXLarge];
}

@end
NS_ASSUME_NONNULL_END
