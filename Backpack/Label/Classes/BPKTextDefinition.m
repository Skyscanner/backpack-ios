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
#import "BPKTextDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPKTextDefinition

- (instancetype)initWithText:(NSString *)text fontStyle:(BPKFontStyle)fontStyle {
    self = [super init];

    if(self) {
        _text = text;
        _fontStyle = fontStyle;
    }

    return self;
}

- (NSArray<BPKTextDefinition *> *)splitAtIndex:(int) index {
    NSMutableArray<BPKTextDefinition *> *result = [[NSMutableArray alloc] init];

    [result addObject:[[BPKTextDefinition alloc] initWithText: [self.text substringToIndex:index] fontStyle:self.fontStyle]];
    [result addObject:[[BPKTextDefinition alloc] initWithText: [self.text substringFromIndex:index] fontStyle:self.fontStyle]];

    return result;
}

@end

NS_ASSUME_NONNULL_END
