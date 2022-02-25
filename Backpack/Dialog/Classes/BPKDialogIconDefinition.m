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

#import "BPKDialogIconDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKDialogIconDefinition ()
@property(nonatomic, strong) UIColor *iconBackgroundColor;
@property(nonatomic, strong) UIImage *iconImage;
@end

@implementation BPKDialogIconDefinition

- (instancetype)initWithIcon:(UIImage *)iconImage iconBackgroundColor:(UIColor *)iconBackgroundColor {
    self = [super init];

    if (self) {
        self.iconImage = iconImage;
        self.iconBackgroundColor = iconBackgroundColor;
    }

    return self;
}

@end

NS_ASSUME_NONNULL_END
