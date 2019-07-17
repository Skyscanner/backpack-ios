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

#import "BPKHorizontalNavigationItem.h"
#import "BPKHorizontalNavigationOption.h"
#import "BPKTextDefinition.h"
#import <Backpack/Color.h>
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKHorizontalNavigationItem

- (instancetype)initWithDefinition:(BPKHorizontalNavigationOption *)definition {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithDefinition:definition];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithDefinition:nil];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithDefinition:nil];
    }

    return self;
}

- (void)setActive:(Boolean *)active {
    if (_active != active) {
        _active = active;

        [self updateStyle];
    }
}

#pragma mark - Private

- (void)updateStyle {
    if (self.active) {
        self.accessibilityTraits = UIAccessibilityTraitButton | UIAccessibilityTraitSelected;
        if (self.selectedColor != nil) {
            self.linkContentColor = self.selectedColor;
        } else {
            self.linkContentColor = BPKColor.blue500;
        }
    } else {
        self.accessibilityTraits = UIAccessibilityTraitButton;
        self.linkContentColor = BPKColor.gray300;
    }
}

- (void)setSelectedColor:(UIColor *_Nullable)selectedColor {
    if (_selectedColor != selectedColor) {
        _selectedColor = selectedColor;

        [self updateStyle];
    }
}

- (void)setupWithDefinition:(BPKHorizontalNavigationOption *_Nullable)definition {
    self.style = BPKButtonStyleLink;
    _definition = definition;

    self.title = definition.name;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self updateStyle];
}

@end
NS_ASSUME_NONNULL_END
