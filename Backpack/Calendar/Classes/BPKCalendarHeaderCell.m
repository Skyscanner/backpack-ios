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

#import "BPKCalendarHeaderCell.h"
#import "BPKCalendarAppearance.h"

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Spacing.h>

@implementation BPKCalendarHeaderCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    FSCalendarAppearance *appearance = self.header.calendar.appearance;
    NSAssert([appearance isKindOfClass:[BPKCalendarAppearance class]],
             @"Return value is not of type BPKCalendarAppearance as expected.");
    BPKFontStyle fontStyle = ((BPKCalendarAppearance *)appearance).headerTitleFontStyle;
    NSAttributedString *monthText = [BPKFont attributedStringWithFontStyle:fontStyle
                                                                   content:self.titleLabel.text
                                                                 textColor:appearance.headerTitleColor
                                                               fontMapping:nil];
    self.titleLabel.attributedText = monthText;
}

@end
