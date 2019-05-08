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

#import "BPKFontMapping.h"
#import <Backpack/Color.h>
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKFontMapping ()

@end

@implementation BPKFontMapping

- (instancetype)initWithFamily:(NSString *)regular
                withBoldFamily:(NSString *)semibold
               withHeavyFamily:(NSString *)heavy {
    self = [super init];
    if (self) {
        _regular = regular;
        _semibold = semibold;
        _heavy = heavy;
        _base = regular;
    }
    return self;
}

- (NSString *)familyForWeight:(NSString *)weight {
    if ([weight isEqual:@"Regular"]) {
        return _regular;
    }
    if ([weight isEqual:@"Semibold"]) {
        return _semibold;
    }
    if ([weight isEqual:@"Heavy"]) {
        return _heavy;
    }
    NSAssert(NO, @"Weights are only provided for Regular, Semibold and Heavy");
    return _regular;
}

- (NSString *)baseFontFamily {
    return _base;
}

@end

NS_ASSUME_NONNULL_END
