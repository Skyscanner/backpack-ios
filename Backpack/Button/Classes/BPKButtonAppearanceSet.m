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

#import "BPKButtonAppearance.h"
#import "BPKButtonAppearanceSet.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPKButtonAppearanceSet : NSObject

- (instancetype)initWithRegularAppearance:(BPKButtonAppearance *)regularAppearance loadingAppearance:(BPKButtonAppearance *)loadingAppearance  disabledAppearance:(BPKButtonAppearance *)disabledAppearance highlightedAppearance:(BPKButtonAppearance *)highlightedAppearance {
    self = [super init];

    if (self) {
        _regularAppearance = regularAppearance;
        _loadingAppearance = loadingAppearance;
        _disabledAppearance = disabledAppearance;
        _highlightedAppearance = highlightedAppearance;
    }

    return self;
}

- (instancetype)clone {
    return [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:[self.regularAppearance clone] loadingAppearance:[self.loadingAppearance clone] disabledAppearance:[self.disabledAppearance clone] highlightedAppearance:[self.highlightedAppearance clone]];
}

@end

NS_ASSUME_NONNULL_END
