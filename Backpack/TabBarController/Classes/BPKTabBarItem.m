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

#import "BPKTabBarItem.h"

#import <Backpack/DarkMode.h>

#import "BPKTabBarDotImageDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPKTabBarItem

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                          tag:(NSInteger)tag
           dotImageDefinition:(BPKTabBarDotImageDefinition *)dotImageDefinition {
    self = [self initWithTitle:title image:image tag:tag];

    if (self) {
        [self setup];
        self.originalImage = image;
        self.dotImageDefinition = dotImageDefinition;
    }

    return self;
}

- (instancetype _Nullable)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];

    if (self) {
        [self setup];
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *_Nullable)title image:(UIImage *_Nullable)image tag:(NSInteger)tag {
    self = [super initWithTitle:title image:image tag:tag];

    if (self) {
        [self setup];
        self.originalImage = image;
    }

    return self;
}

- (instancetype)initWithTabBarSystemItem:(UITabBarSystemItem)systemItem tag:(NSInteger)tag {
    self = [super initWithTabBarSystemItem:systemItem tag:tag];

    if (self) {
        [self setup];
    }

    return self;
}

- (void)setup {
    self.interfaceStyle = UIUserInterfaceStyleUnspecified;
    self.dotShown = false;
    self.selected = false;
}

- (void)updateImage {
    UIImageRenderingMode renderingMode = self.selected ? UIImageRenderingModeAlwaysTemplate : UIImageRenderingModeAlwaysOriginal;

    if (self.dotShown) {
        NSAssert(self.dotImageDefinition != nil,
                 @"A dot can only be added to a BPKTabBarItem if a dotImageDefinition is provided, but dotImageDefintion was nil");
        if (self.dotImageDefinition != nil) {
            if (self.interfaceStyle == UIUserInterfaceStyleDark) {
                self.image = [self.dotImageDefinition.darkImage imageWithRenderingMode:renderingMode];
            } else {
                self.image = [self.dotImageDefinition.lightImage imageWithRenderingMode:renderingMode];
            }
        }
    } else {
        self.image = [self.originalImage copy];
    }
}

- (void)setInterfaceStyle:(UIUserInterfaceStyle)interfaceStyle {
    if (_interfaceStyle != interfaceStyle) {
        _interfaceStyle = interfaceStyle;
        [self updateImage];
    }
}

- (void)setSelected:(BOOL)selected {
    if (_selected != selected) {
        _selected = selected;
        [self updateImage];
    }
}

- (void)addDot {
    self.dotShown = YES;
    [self updateImage];
}

- (void)removeDot {
    self.dotShown = NO;
    [self updateImage];
}

@end

NS_ASSUME_NONNULL_END
