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
#import "BPKIcon.h"

#import <Backpack_Common/Backpack_Common-Swift.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKIcon ()
@property(class, nonatomic, readonly) NSCache<NSString *, UIImage *> *imageCache;

+ (NSString *)cacheKeyForIconNamed:(NSString *)name withColor:(UIColor *)color size:(BPKIconSize)size;
@end

@implementation BPKIcon
@dynamic imageCache;

+ (UIImage *)templateIconNamed:(NSString *)name size:(BPKIconSize)size {
    UIImage *image = [self iconNamed:name color:UIColor.blackColor size:size];

    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

+ (NSString *)iconName:(NSString *)name forSize:(BPKIconSize)size {
    if (size == BPKIconSizeSmall) {
        return [NSString stringWithFormat:@"%@%@", name, @"-sm"];
    } else if (size == BPKIconSizeLarge) {
        return [NSString stringWithFormat:@"%@%@", name, @"-lg"];
    }
    return nil;
}

+ (UIImage *)iconNamed:(NSString *)name color:(UIColor *)color size:(BPKIconSize)size {
    NSString *cacheKey = [self cacheKeyForIconNamed:name withColor:color size:size];
    UIImage *icon = [self.imageCache objectForKey:cacheKey];

    if (icon) {
        return icon;
    }

    NSString *iconName = [BPKIcon iconName:name forSize:size];
    NSBundle *iconsBundle = BPKCommonBundle.iconsBundle;
    icon = [UIImage imageNamed:iconName inBundle:iconsBundle withConfiguration:nil];
    if (icon == nil) {
        // To avoid nil checking everywhere in this file
        // Fallback to empty UIImage if we try to use an icon that does not exist
        icon = [UIImage new];
    }
    icon = [icon imageWithTintColor: color];
    CGSize iconSize = [self concreteSizeForIconSize:size];
    UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
    UIImage *placeholder = [UIImage new];
    CGRect iconRect = CGRectMake(0.0, 0.0, iconSize.width, iconSize.height);
    [placeholder drawInRect:iconRect];
    [icon drawInRect:iconRect];
    icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self.imageCache setObject:icon forKey:cacheKey];

    return icon;
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

+ (UIImage *)smallTemplateIconNamed:(BPKSmallIconName)name {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return [self templateIconNamed:name size:BPKIconSizeSmall];
#pragma GCC diagnostic pop
}

+ (UIImage *)largeTemplateIconNamed:(BPKLargeIconName)name {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return [self templateIconNamed:name size:BPKIconSizeLarge];
#pragma GCC diagnostic pop
}

+ (UIImage *)xlTemplateIconNamed:(BPKXlIconName)name {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return [self templateIconNamed:name size:BPKIconSizeXLarge];
#pragma GCC diagnostic pop
}

+ (UIImage *)smallIconNamed:(BPKSmallIconName)name color:(UIColor *)color {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return [self iconNamed:name color:color size:BPKIconSizeSmall];
#pragma GCC diagnostic pop
}

+ (UIImage *)largeIconNamed:(BPKLargeIconName)name color:(UIColor *)color {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return [self iconNamed:name color:color size:BPKIconSizeLarge];
#pragma GCC diagnostic pop
}

+ (UIImage *)xlIconNamed:(BPKXlIconName)name color:(UIColor *)color {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return [self iconNamed:name color:color size:BPKIconSizeXLarge];
#pragma GCC diagnostic pop
}

@end
NS_ASSUME_NONNULL_END
