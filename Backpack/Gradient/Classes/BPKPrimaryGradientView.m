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
#import "BPKPrimaryGradientView.h"

#import "BPKGradient.h"
#import "BPKGradientLayer.h"

#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKPrimaryGradientView ()
@property(readonly, nonatomic) BPKGradientLayer *gradientLayer;
@end

@implementation BPKPrimaryGradientView

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        _gradient = BPKGradient.primary;
        self.gradientLayer.gradient = _gradient;
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        _gradient = BPKGradient.primary;
        self.gradientLayer.gradient = _gradient;
    }

    return self;
}

+ (Class)layerClass {
    return [BPKGradientLayer class];
}

- (BPKGradientLayer *)gradientLayer {
    return (BPKGradientLayer *)self.layer;
}

- (void)setGradient:(BPKGradient *)gradient {
    BPKAssertMainThread();
    if (_gradient != gradient) {
        _gradient = gradient;

        [self configureGradientLayer];
    }
}

- (void)setDirectionOverride:(nullable NSNumber *)directionOverride {
    BPKAssertMainThread();
    if (_directionOverride != directionOverride) {
        _directionOverride = directionOverride;

        [self configureGradientLayer];
    }
}

#pragma mark - Private

- (void)configureGradientLayer {
    if (self.directionOverride != nil) {
        BPKGradient *newGradient =
            [self.gradient cloneWithNewDirection:(BPKGradientDirection)self.directionOverride.unsignedIntegerValue];
        self.gradientLayer.gradient = newGradient;
    } else {
        self.gradientLayer.gradient = self.gradient;
    }
}

@end
NS_ASSUME_NONNULL_END
