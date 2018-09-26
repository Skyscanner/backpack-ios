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

#import "BPKAlertButtonConfiguration.h"

@implementation BPKAlertButtonConfiguration

- (instancetype _Nonnull)initWithButtonStyle:(BPKButtonStyle)style title:(NSString *)title actionHandler:(BPKAlertButtonActionHandler)handler {
    self = [super init];
    if (self) {
        _style = style;
        _title = title;
        _handler = handler;
    }
    return self;
}

+ (instancetype _Nonnull)configurationWithStyle:(BPKButtonStyle)style title:(NSString *)title actionHandler:(BPKAlertButtonActionHandler)handler {
    return [[self alloc] initWithButtonStyle:style title:title actionHandler:handler];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    BPKAlertButtonConfiguration *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy->_style = _style;
        copy->_title = _title;
        copy->_handler = _handler;
    }

    return copy;
}

@end
