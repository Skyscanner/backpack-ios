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

#import <Backpack/Font.h>
#import <Backpack/Button.h>
#import <BackPack/Calendar.h>

#import "BPKCalendarAppearance.h"

@interface FSCalendarStickyHeader (Private)

@property(weak, nonatomic) UIView *contentView;
@property(weak, nonatomic) UIView *bottomBorder;
@property(weak, nonatomic) FSCalendarWeekdayView *weekdayView;
@property(weak, nonatomic) BPKButton *selectMonthButton;

@end

@implementation BPKCalendarStickyHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self.weekdayView removeFromSuperview];
        [self.bottomBorder removeFromSuperview];
        
        BPKButton *button = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStyleLink];
        [button setTitle:@"Select whole month"];
        [button addTarget:self action:@selector(didTapSelectMonth:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        self.selectMonthButton = button;
    }

    return self;
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
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.titleLabel.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor],
        
        [self.selectMonthButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.selectMonthButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]
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
    
    if ([self.calendar isMemberOfClass:[BPKCalendar class]]) {
        BPKCalendar * const calendar = (BPKCalendar *) self.calendar;
        self.selectMonthButton.hidden = !calendar.allowsWholeMonthSelection;
        [self.selectMonthButton setTitle: calendar.wholeMonthTitle];
    }
}

#pragma mark - Actions

- (void)didTapSelectMonth:(BPKButton *)sender {
    
}

@end
