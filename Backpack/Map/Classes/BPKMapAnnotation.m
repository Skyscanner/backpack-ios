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

#import "BPKMapAnnotation.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPKMapAnnotation

- (instancetype)init {
    self = [super init];

    if (self) {
        [self setup];
    }

    return self;
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super initWithCoordinate:coordinate];

    if (self) {
        [self setup];
    }

    return self;
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *_Nullable)title subtitle:(NSString *_Nullable)subtitle {
    self = [super initWithCoordinate:coordinate title:title subtitle:subtitle];

    if (self) {
        [self setup];
    }

    return self;
}

-(void)setup {
    self.enabled = true;
}

@end
NS_ASSUME_NONNULL_END
