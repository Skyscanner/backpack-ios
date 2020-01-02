// clang-format off
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import "BPKShadow.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKShadow()
@property(nonatomic, strong) UIColor *color;
@property(nonatomic) CGSize offset;
@property(nonatomic) CGFloat opacity;
@property(nonatomic) CGFloat radius;

- (instancetype)initWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;
@end

@implementation BPKShadow

- (instancetype)initWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
  self = [super init];

  if (self) {
    self.color = color;
    self.offset = offset;
    self.opacity = opacity;
    self.radius = radius;
  }

  return self;
}

- (void)applyToLayer:(CALayer *)layer {
    layer.shadowColor = self.color.CGColor;
    layer.shadowOffset = self.offset;
    layer.shadowRadius = self.radius;
    layer.shadowOpacity = self.opacity;
}


+ (instancetype)shadowLg {
    static dispatch_once_t shadowLgOnceToken;
    static BPKShadow *shadowLg;

    dispatch_once(&shadowLgOnceToken, ^{
        UIColor *color = [UIColor colorWithRed:0.067 green:0.071 blue:0.212 alpha:1];
        shadowLg = [[BPKShadow alloc] initWithColor:color
                                               offset:CGSizeMake(0, 4)
                                              opacity:0.15
                                               radius:16];

    });

    return shadowLg;
}

+ (instancetype)shadowSm {
    static dispatch_once_t shadowSmOnceToken;
    static BPKShadow *shadowSm;

    dispatch_once(&shadowSmOnceToken, ^{
        UIColor *color = [UIColor colorWithRed:0.067 green:0.071 blue:0.212 alpha:1];
        shadowSm = [[BPKShadow alloc] initWithColor:color
                                               offset:CGSizeMake(0, 1)
                                              opacity:0.15
                                               radius:3];

    });

    return shadowSm;
}

@end
NS_ASSUME_NONNULL_END
// clang-format on
