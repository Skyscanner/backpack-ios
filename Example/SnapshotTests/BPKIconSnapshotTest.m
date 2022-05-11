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

#import <Backpack/Color.h>
#import <Backpack/Icon.h>
#import <Backpack/Spacing.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import "BPKIconsTestsUtils.h"

typedef UIImageView* (^BPKIconMakeSmallIcon)(BPKSmallIconName);
typedef UIImageView* (^BPKIconMakeLargeIcon)(BPKLargeIconName);
typedef UIImageView* (^BPKIconGenericMakeIcon)(id);


@interface BPKIconSnapshotTest : FBSnapshotTestCase

@end

@implementation BPKIconSnapshotTest

- (void)setUp {
    [super setUp];

    self.recordMode = NO;
}

- (void)testSmallIcon {
    UIImage *icon = [BPKIcon smallIconNamed:@"flight" color:[BPKColor skyBlue]];
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
    view.image = icon;

    FBSnapshotVerifyView(view, nil)
}

- (void)testLargeIcon {
    UIImage *icon = [BPKIcon largeIconNamed:@"hotels" color:[BPKColor skyBlue]];
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
    view.image = icon;

    FBSnapshotVerifyView(view, nil)
}

- (void)testAllSmallIcons {
    NSArray<BPKSmallIconName> *allSmallIcons = [[self class] allSmallIconNames];

    UIView *view = [[self class] generateSmallIconGridWithIcons:allSmallIcons makeIconView:^UIImageView *(BPKSmallIconName name) {
        UIImage *icon = [BPKIcon smallTemplateIconNamed:name];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
        imageView.image = icon;

        return imageView;
    }];

    FBSnapshotVerifyView(view, nil);
}

- (void)testAllLargeIcons {
    NSArray<BPKLargeIconName> *allLargeIcons = [[self class] allLargeIconNames];

    UIView *view = [[self class] generateLargeIconGridWithIcons:allLargeIcons makeIconView:^UIImageView *(BPKLargeIconName name) {
        UIImage *icon = [BPKIcon largeTemplateIconNamed:name];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
        imageView.image = icon;

        return imageView;
    }];

    FBSnapshotVerifyView(view, nil);
}

+ (NSArray<BPKSmallIconName> *)allSmallIconNames {
    NSArray *allIcons = [BPKIconsTestsUtils getAllIcons];
    NSMutableArray *result = [NSMutableArray new];

    for (NSString *icon in allIcons) {
        if ([icon hasSuffix:@"-sm"]) {
            BPKSmallIconName name = [icon substringToIndex:icon.length - 3];
            [result addObject:name];
        }
    }

    return [result copy];
}

+ (NSArray<BPKLargeIconName> *)allLargeIconNames {
    NSArray *allIcons = [BPKIconsTestsUtils getAllIcons];
    NSMutableArray *result = [NSMutableArray new];

    for (NSString *icon in allIcons) {
        if (![icon hasSuffix:@"-sm"]) {
            [result addObject:(BPKLargeIconName) icon];
        }
    }

    return [result copy];
}

+ (UIView *)generateSmallIconGridWithIcons:(NSArray<BPKSmallIconName> *)icons makeIconView:(BPKIconMakeSmallIcon)makeSmallIcon {
    return [self generateIconGridWithIcons:icons
                              makeIconView:makeSmallIcon
                                  iconSize:BPKIcon.concreteSizeForSmallIcon];
}

+ (UIView *)generateLargeIconGridWithIcons:(NSArray<BPKLargeIconName> *)icons makeIconView:(BPKIconMakeLargeIcon)makeLargeIcon {
    return [self generateIconGridWithIcons:icons
                              makeIconView:makeLargeIcon
                                  iconSize:BPKIcon.concreteSizeForLargeIcon];
}

+ (UIView *)generateIconGridWithIcons:(NSArray<id> *)icons makeIconView:(BPKIconGenericMakeIcon)makeIcon iconSize:(CGSize)iconSize {
    NSUInteger iconsPerRow = 10;
    CGFloat numberOfRows = ceil((CGFloat)icons.count / (CGFloat)iconsPerRow);
    CGFloat width = iconsPerRow * iconSize.width + (iconsPerRow - 1) * BPKSpacingMd + BPKSpacingMd * 2;
    CGFloat height = numberOfRows * iconSize.height + (numberOfRows - 1) * BPKSpacingMd + BPKSpacingMd * 2;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];

    for (NSUInteger i = 0; i < icons.count; i++) {
        id icon = icons[i];
        NSUInteger row = i / iconsPerRow;
        NSUInteger col = i % iconsPerRow;

        UIImageView *imageView = makeIcon(icon);
        imageView.tintColor = BPKColor.black;

        CGFloat x = BPKSpacingMd + col * (iconSize.width + BPKSpacingMd);
        CGFloat y = BPKSpacingMd + row * (iconSize.height + BPKSpacingMd);
        imageView.frame = CGRectMake(x, y, iconSize.width, iconSize.height);
        [view addSubview:imageView];
    }

    return view;
}

@end
