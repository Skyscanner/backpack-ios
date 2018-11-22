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

#import "BPKCalendarYearPill.h"

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Spacing.h>

@implementation BPKCalendarYearPill

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextXsEmphasized content:@"" textColor:[BPKColor white]];
        self.textAlignment = NSTextAlignmentCenter;
        self.layer.cornerRadius = BPKSpacingLg/2.0;
        self.layer.backgroundColor = [BPKColor gray900].CGColor;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0, 4.0);
        self.layer.shadowOpacity = 0.15;
        self.layer.shadowRadius = 10.0;
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.widthAnchor constraintEqualToConstant:BPKSpacingXl*2.0],
                                                  [self.heightAnchor constraintEqualToConstant:BPKSpacingLg]
                                                  ]];
    }
    return self;
}

- (void)setYear:(nonnull NSNumber *)year {
    _year = year;
    self.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextXsEmphasized
                                                         content:[year stringValue]
                                                       textColor:[BPKColor white]];
}

@end
