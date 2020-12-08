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
#import "BPKHorizontalNavigationOption.h"

#import "BPKHorizontalNavigationItemDefault.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKHorizontalNavigationOption ()

@property(nonatomic) NSInteger tag;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong, nullable) BPKIconName iconName;
@property(nonatomic) BOOL showDot;

@end

@implementation BPKHorizontalNavigationOption

- (instancetype)initWithName:(NSString *)name {
    self = [super init];

    if (self) {
        self.name = name;
        self.tag = 0;
    }

    return self;
}

- (instancetype)initWithName:(NSString *)name iconName:(BPKIconName)iconName {
    self = [self initWithName:name iconName:iconName tag:0];

    return self;
}

- (instancetype)initWithName:(NSString *)name iconName:(BPKIconName)iconName tag:(NSInteger)tag {
    self = [self initWithName:name tag:tag iconName:iconName showNotificationDot:NO];

    return self;
}

- (instancetype)initWithName:(NSString *)name tag:(NSInteger)tag {
    self = [self initWithName:name tag:tag showNotificationDot:NO];

    return self;
}

- (instancetype)initWithName:(NSString *)name tag:(NSInteger)tag showNotificationDot:(BOOL)showDot {

    self = [self initWithName:name];
    self.tag = tag;
    self.showDot = showDot;

    return self;
}

- (instancetype)initWithName:(NSString *)name tag:(NSInteger)tag iconName:(BPKIconName)iconName showNotificationDot:(BOOL)showDot {

    self = [self initWithName:name tag:tag showNotificationDot:showDot];
    self.iconName = iconName;

    return self;
}

- (BOOL)hasIcon {
    return self.iconName != nil;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    return [self isEqualToOption:object];
}

- (BOOL)isEqualToOption:(BPKHorizontalNavigationOption *)other {
    return self.tag == other.tag && [self.name isEqualToString:other.name] && [(self.iconName ?: @"") isEqualToString:(other.iconName ?: @"")];
}

- (UIControl *)makeItem {
    return [[BPKHorizontalNavigationItemDefault alloc] initWithName:self.name iconName:self.iconName showNotificationDot:self.showDot];
}

@end

NS_ASSUME_NONNULL_END
