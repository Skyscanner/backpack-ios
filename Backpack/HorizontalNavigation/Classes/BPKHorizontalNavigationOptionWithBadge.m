/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2020 Skyscanner Ltd. All rights reserved.
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

#import "BPKHorizontalNavigationOptionWithBadge.h"
#import "BPKHorizontalNavigationItemWithBadge.h"

#import <Backpack/BPKBadge.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKHorizontalNavigationOptionWithBadge()
@property(nonatomic, assign) NSInteger tag;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *badgeMessage;
@end

@implementation BPKHorizontalNavigationOptionWithBadge

- (instancetype)initWithTitle:(NSString *)title badgeMessage:(NSString *)badgeMessage tag:(NSInteger)tag {
    self = [super init];

    if (self) {
        self.title = title;
        self.tag = tag;
        self.badgeMessage = badgeMessage;
    }

    return self;
}

- (nonnull UIControl<BPKHorizontalNavigationItem> *)makeItem {
    return [[BPKHorizontalNavigationItemWithBadge alloc] initWithTitle:self.title badgeMessage:self.badgeMessage];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    return [self isEqualToOption:(BPKHorizontalNavigationOptionWithBadge *)object];
}

- (BOOL)isEqualToOption:(BPKHorizontalNavigationOptionWithBadge *)option {
    return [self.title isEqual:option.title] && self.tag == option.tag && [self.badgeMessage isEqual:option.badgeMessage];
}

@end
NS_ASSUME_NONNULL_END
