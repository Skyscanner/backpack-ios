/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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
#import "BPKXlIconView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPKXlIconView

- (instancetype)initWithIconName:(nullable BPKXlIconName)iconName {
    return [super initWithIconName:iconName size:BPKIconSizeXLarge];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        super.size = BPKIconSizeXLarge;
#pragma GCC diagnostic pop
    }
    return self;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-implementations"
- (void)setSize:(BPKIconSize)size {
    NSAssert(NO, @"Cannot set size on BPKXlIconView. Use BPKSmallIconView or BPKLargeIconView for other sizes.");
    [super setSize:size];
}
#pragma GCC diagnostic pop

@end

NS_ASSUME_NONNULL_END
