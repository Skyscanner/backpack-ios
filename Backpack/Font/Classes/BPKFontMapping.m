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

@implementation BPKFontMapping

- (instancetype)initWithFamily:(NSString *)family
               regularFontFace:(NSString *)regularFontFace
              semiboldFontFace:(NSString *)semiboldFontFace
                 heavyFontFace:(NSString *)heavyFontFace {
    self = [super init];
    if (self) {
        _family = [family copy];
        _regularFontFace = [regularFontFace copy];
        _semiboldFontFace = [semiboldFontFace copy];
        _heavyFontFace = [heavyFontFace copy];
    }
    return self;
}

- (NSString *)familyForWeight:(UIFontWeight)weight {
    if (abs(weight - UIFontWeightRegular) < 0.01) {
        return _regularFontFace;
    } else if (abs(weight - UIFontWeightSemibold) < 0.01) {
        return _semiboldFontFace;
    } else if (abs(weight - UIFontWeightHeavy) < 0.01) {
        return _heavyFontFace;
    }

    NSAssert(NO, @"Font faces are only provided for regular, semibold and heavy");

    return _regularFontFace;
}

@end

NS_ASSUME_NONNULL_END
