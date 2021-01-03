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

#import "BPKCalendarYearPill.h"

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Shadow.h>
#import <Backpack/Spacing.h>

#import "BPKCalendar.h"

@interface BPKCalendarYearPill ()

@property(nonatomic) UILabel *label;

@end

@implementation BPKCalendarYearPill

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.numberOfLines = 1;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [BPKColor dynamicColorWithLightVariant:BPKColor.skyGray darkVariant:BPKColor.white];

        [[BPKShadow shadowLg] applyToLayer:self.layer];
        [self addSubview:self.label];
        [NSLayoutConstraint activateConstraints:@[
            [self.label.topAnchor constraintEqualToAnchor:self.topAnchor constant:BPKSpacingSm],
            [self.label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:BPKSpacingBase],
            [self.label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-BPKSpacingBase],
            [self.label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-BPKSpacingSm],
        ]];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = CGRectGetHeight(self.frame) / 2.0;
}

- (void)updateYearAppearance {
    if (self.year != nil) {
        self.label.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextXsEmphasized
                                                                   content:[self.year stringValue]
                                                                 textColor:[BPKColor dynamicColorWithLightVariant:BPKColor.white
                                                                                                      darkVariant:BPKColor.skyGray]];
        [self.label sizeToFit];
    }
}

- (void)setYear:(nonnull NSNumber *)year {
    _year = year;

    [self updateYearAppearance];
}

@end
