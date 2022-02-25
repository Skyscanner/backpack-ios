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
#import "BPKGradientView.h"

#import <Backpack/Common.h>

#import "BPKGradientLayer.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKGradientView ()
@property(readonly, nonatomic) BPKGradientLayer *gradientLayer;
@end

@implementation BPKGradientView
@dynamic gradient;
@dynamic gradientLayer;

- (instancetype)initWithGradient:(BPKGradient *)gradient {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.gradient = gradient;
    }

    return self;
}

+ (Class)layerClass {
    return [BPKGradientLayer class];
}

- (BPKGradientLayer *)gradientLayer {
    return (BPKGradientLayer *)self.layer;
}

- (void)setGradient:(BPKGradient *_Nullable)gradient {
    BPKAssertMainThread();
    self.gradientLayer.gradient = gradient;
}

- (nullable BPKGradient *)gradient {
    return self.gradientLayer.gradient;
}

@end
NS_ASSUME_NONNULL_END
