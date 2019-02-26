/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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
#import "BPKIconView.h"

#import "BPKColor.h"
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKIconView()
@property(nonatomic, assign) BPKIconSize size;

- (void)setUp;
@end

@implementation BPKIconView

- (instancetype)initWithIconName:(nullable BPKIconName)iconName size:(BPKIconSize)size {
    BPKAssertMainThread();
    CGSize displaySize = [BPKIcon concreteSizeForIconSize:size];

    self = [super initWithFrame:CGRectMake(0, 0, displaySize.width, displaySize.height)];

    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.size = size;
        _iconName = [iconName copy];
        [self setUp];
    }

    return self;
}

- (void)setUp {
    if (self.iconName) {
        super.image = [BPKIcon templateIconNamed:self.iconName size:self.size];
    }
    self.tintColor = BPKColor.gray900;
}

- (void)setIconName:(nullable BPKIconName)iconName {
    BPKAssertMainThread();
    if (![iconName isEqualToString:_iconName]) {
        _iconName = [iconName copy];

        if (iconName) {
            super.image = [BPKIcon templateIconNamed:iconName size:self.size];
        } else {
            super.image = nil;
        }
    }
}

- (CGSize)intrinsicContentSize {
    return [BPKIcon concreteSizeForIconSize:self.size];
}

@end

NS_ASSUME_NONNULL_END
