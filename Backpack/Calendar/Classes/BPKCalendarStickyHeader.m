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

#import "BPKCalendarStickyHeader.h"

#import <Backpack/Button.h>
#import <Backpack/Calendar.h>
#import <Backpack/Font.h>
#import <Backpack/SimpleDate.h>

#import "BPKCalendarAppearance.h"

@interface FSCalendarStickyHeader (Private)

@property(weak, nonatomic) UIView *contentView;
@property(weak, nonatomic) UIView *bottomBorder;
@property(weak, nonatomic) FSCalendarWeekdayView *weekdayView;

@end

@interface BPKCalendarStickyHeader ()

@property(weak, nonatomic, readonly) BPKButton *selectMonthButton;

@end

@implementation BPKCalendarStickyHeader

CGFloat const BPKBaselineOffset = -5.0;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self.weekdayView removeFromSuperview];
        [self.bottomBorder removeFromSuperview];

        BPKButton *button = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStyleLink];
        [button setTitle:@"Select whole month"];
        [button addTarget:self action:@selector(didTapSelectMonth:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _selectMonthButton = button;
    }

    return self;
}

+ (NSDateFormatter *)formatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"MMMM, yyyy"];
      NSLocale *locale = [NSLocale currentLocale];
      [dateFormatter setLocale:locale];
    });
    return dateFormatter;
}

- (void)configureAppearance {
    [super configureAppearance];
    self.titleLabel.textAlignment = NSTextAlignmentNatural;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectZero;

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.selectMonthButton.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],

        [self.selectMonthButton.centerYAnchor constraintEqualToAnchor:self.titleLabel.lastBaselineAnchor constant:BPKBaselineOffset],
        [self.selectMonthButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
    ]];
}

- (void)setMonth:(NSDate *)month {
    [super setMonth:month];
    FSCalendarAppearance *appearance = self.calendar.appearance;
    NSAssert([appearance isKindOfClass:[BPKCalendarAppearance class]], @"Return value is not of type BPKCalendarAppearance as expected.");
    BPKFontStyle fontStyle = ((BPKCalendarAppearance *)appearance).headerTitleFontStyle;
    NSAttributedString *monthText = [BPKFont attributedStringWithFontStyle:fontStyle
                                                                   content:self.titleLabel.text
                                                                 textColor:appearance.headerTitleColor];
    self.titleLabel.attributedText = monthText;

    BPKCalendar *calendar = [self bpkCalendar];
    if (!calendar) {
        return;
    }

    self.selectMonthButton.hidden = !calendar.allowsWholeMonthSelection;
    BPKSimpleDate *simpleMonth = [BPKSimpleDate simpleDatesFromDates:@[month] forCalendar:calendar.gregorian].firstObject;
    self.selectMonthButton.enabled = [calendar isWholeMonthButtonEnabledForMonth:simpleMonth];
    [self.selectMonthButton setTitle:calendar.wholeMonthTitle];
    self.selectMonthButton.accessibilityLabel =
        [NSString stringWithFormat:@"%@ %@", calendar.wholeMonthTitle, [[BPKCalendarStickyHeader formatter] stringFromDate:month]];
}

#pragma mark - Actions

- (void)didTapSelectMonth:(BPKButton *)sender {
    BPKCalendar *calendar = [self bpkCalendar];
    if (!calendar) {
        return;
    }

    BPKSimpleDate *month = [[BPKSimpleDate alloc] initWithDate:self.month forCalendar:calendar.gregorian];
    [calendar selectWholeMonth:month];
}

#pragma mark - Helpers

- (BPKCalendar *_Nullable)bpkCalendar {
    if ([self.calendar.superview.superview isMemberOfClass:[BPKCalendar class]]) {
        return (BPKCalendar *)self.calendar.superview.superview;
    } else {
        return nil;
    }
}

@end
