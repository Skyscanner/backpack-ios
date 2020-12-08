//
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

#import "BPKHorizontalNavigationOptionWithBackground.h"

#import "Backpack_Native-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKHorizontalNavigationOptionWithBackground ()
@property(nonatomic, assign) NSInteger tag;
@property(nonatomic, copy) NSString *title;
@end

@implementation BPKHorizontalNavigationOptionWithBackground

- (instancetype)initWithTitle:(NSString *)title tag:(NSInteger)tag {
    self = [super init];

    if (self) {
        self.title = title;
        self.tag = tag;
    }

    return self;
}

- (UIControl<BPKHorizontalNavigationItem> *)makeItem {
    return [[BPKHorizontalNavigationItemWithBackground alloc] initWithTitle:self.title];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    return [self isEqualToOption:(BPKHorizontalNavigationOptionWithBackground *)object];
}

- (BOOL)isEqualToOption:(BPKHorizontalNavigationOptionWithBackground *)option {
    return [self.title isEqual:option.title] && self.tag == option.tag;
}

@end

NS_ASSUME_NONNULL_END
