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

#import "BPKSwitch.h"
#import <Backpack/Color.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKSwitch()

@end

@implementation BPKSwitch

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.tintColor = BPKColor.gray100;
    
    self.onTintColor = self.dancing ? [UIColor orangeColor] : BPKColor.blue500;
    if(self.dancing){
        self.tintColor = [UIColor orangeColor];
    }
    [self setNeedsDisplay];
}

- (void) setDancing:(BOOL)dancing {
    _dancing = dancing;
    [self setup];
}

@end

NS_ASSUME_NONNULL_END
