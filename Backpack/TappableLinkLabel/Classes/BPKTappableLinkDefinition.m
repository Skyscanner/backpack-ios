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
#import "BPKTappableLinkDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPKTappableLinkDefinition

- (instancetype)initWithURL:(NSURL *)url range:(NSRange)range {
    self = [super init];

    if (self) {
        _url = url;
        _range = range;
    }

    return self;
}

- (instancetype)initWithTransitInformation:(NSDictionary *)components range:(NSRange)range {
    self = [super init];

    if (self) {
        _components = components;
        _range = range;
    }

    return self;
}

- (Boolean)hasURLDefinition {
    return self.url != nil;
}

- (Boolean)hasTransitInformationDefinition {
    return self.components != nil;
}

@end

NS_ASSUME_NONNULL_END
