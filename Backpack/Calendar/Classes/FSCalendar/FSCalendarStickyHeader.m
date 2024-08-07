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

/*
 * Copyright (c) 2013-2016 FSCalendar (https://github.com/WenchaoD/FSCalendar)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "FSCalendarStickyHeader.h"
#import "FSCalendar.h"
#import "FSCalendarConstants.h"
#import "FSCalendarDynamicHeader.h"
#import "FSCalendarExtensions.h"
#import "FSCalendarWeekdayView.h"

@interface FSCalendarStickyHeader ()

@property(weak, nonatomic) UIView *contentView;
@property(weak, nonatomic) UIView *bottomBorder;
@property(weak, nonatomic) FSCalendarWeekdayView *weekdayView;

@end

@implementation FSCalendarStickyHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        UIView *view;
        UILabel *label;

        view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        self.contentView = view;

        label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [_contentView addSubview:label];
        self.titleLabel = label;

        view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = FSCalendarStandardLineColor;
        [_contentView addSubview:view];
        self.bottomBorder = view;

        FSCalendarWeekdayView *weekdayView = [[FSCalendarWeekdayView alloc] init];
        [self.contentView addSubview:weekdayView];
        self.weekdayView = weekdayView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _contentView.frame = self.bounds;

    CGFloat weekdayHeight = _calendar.preferredWeekdayHeight;
    CGFloat weekdayMargin = weekdayHeight * 0.1;
    CGFloat titleWidth = _contentView.fs_width;

    self.weekdayView.frame = CGRectMake(0, _contentView.fs_height - weekdayHeight - weekdayMargin, self.contentView.fs_width, weekdayHeight);

    CGFloat titleHeight = [@"1" sizeWithAttributes:@{NSFontAttributeName: self.calendar.appearance.headerTitleFont}].height * 1.5 + weekdayMargin * 3;

    _bottomBorder.frame = CGRectMake(0, _contentView.fs_height - weekdayHeight - weekdayMargin * 2, _contentView.fs_width, 1.0);

    CGPoint titleHeaderOffset = self.calendar.appearance.headerTitleOffset;
    _titleLabel.frame =
        CGRectMake(titleHeaderOffset.x, titleHeaderOffset.y + _bottomBorder.fs_bottom - titleHeight - weekdayMargin, titleWidth, titleHeight);
}

#pragma mark - Properties

- (void)setCalendar:(FSCalendar *)calendar {
    if (![_calendar isEqual:calendar]) {
        _calendar = calendar;
        _weekdayView.calendar = calendar;
        [self configureAppearance];
    }
}

#pragma mark - Private methods

- (void)configureAppearance {
    _titleLabel.font = self.calendar.appearance.headerTitleFont;
    _titleLabel.textColor = self.calendar.appearance.headerTitleColor;
    _titleLabel.textAlignment = self.calendar.appearance.headerTitleAlignment;
    _bottomBorder.backgroundColor = self.calendar.appearance.headerSeparatorColor;
    [self.weekdayView configureAppearance];
}

- (void)setMonth:(NSDate *)month {
    _month = month;
    _calendar.formatter.dateFormat = self.calendar.appearance.headerDateFormat;
    BOOL usesUpperCase = (self.calendar.appearance.caseOptions & 15) == FSCalendarCaseOptionsHeaderUsesUpperCase;
    BOOL usesCapitalized = (self.calendar.appearance.caseOptions & 15) == FSCalendarCaseOptionsHeaderUsesCapitalized;

    NSString *text = [_calendar.formatter stringFromDate:_month];
    if (usesUpperCase) {
        text = text.uppercaseString;
    } else if (usesCapitalized) {
        text = text.capitalizedString;
    }

    self.titleLabel.text = text;
}

@end
