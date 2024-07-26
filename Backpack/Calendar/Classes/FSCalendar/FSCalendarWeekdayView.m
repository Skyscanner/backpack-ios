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

#import "FSCalendarWeekdayView.h"
#import "FSCalendar.h"
#import "FSCalendarDynamicHeader.h"
#import "FSCalendarExtensions.h"

@interface FSCalendarWeekdayView ()

@property(strong, nonatomic) NSPointerArray *weekdayPointers;
@property(weak, nonatomic) UIView *contentView;
@property(weak, nonatomic) FSCalendar *calendar;

- (void)commonInit;

@end

@implementation FSCalendarWeekdayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:contentView];
    _contentView = contentView;

    _weekdayPointers = [NSPointerArray weakObjectsPointerArray];
    for (int i = 0; i < 7; i++) {
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:weekdayLabel];
        [_weekdayPointers addPointer:(__bridge void *_Nullable)(weekdayLabel)];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.contentView.frame = self.bounds;

    // Position Calculation
    NSInteger count = self.weekdayPointers.count;
    size_t size = sizeof(CGFloat) * count;
    CGFloat *widths = malloc(size);
    CGFloat contentWidth = self.contentView.fs_width;
    FSCalendarSliceCake(contentWidth, count, widths);

    BOOL opposite = NO;
    if (@available(iOS 9.0, *)) {
        UIUserInterfaceLayoutDirection direction =
            [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.calendar.semanticContentAttribute];
        opposite = (direction == UIUserInterfaceLayoutDirectionRightToLeft);
    }
    CGFloat x = 0;
    for (NSInteger i = 0; i < count; i++) {
        CGFloat width = widths[i];
        NSInteger labelIndex = opposite ? count - 1 - i : i;
        UILabel *label = [self.weekdayPointers pointerAtIndex:labelIndex];
        label.frame = CGRectMake(x, 0, width, self.contentView.fs_height);
        x = CGRectGetMaxX(label.frame);
    }
    free(widths);
}

- (void)setCalendar:(FSCalendar *)calendar {
    _calendar = calendar;
    [self configureAppearance];
}

- (NSArray<UILabel *> *)weekdayLabels {
    return self.weekdayPointers.allObjects;
}

- (void)configureAppearance {
    BOOL useVeryShortWeekdaySymbols = (self.calendar.appearance.caseOptions & (15 << 4)) == FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    NSArray *weekdaySymbols = useVeryShortWeekdaySymbols ? self.calendar.gregorian.veryShortStandaloneWeekdaySymbols
                                                         : self.calendar.gregorian.shortStandaloneWeekdaySymbols;
    BOOL useDefaultWeekdayCase = (self.calendar.appearance.caseOptions & (15 << 4)) == FSCalendarCaseOptionsWeekdayUsesDefaultCase;

    for (NSInteger i = 0; i < self.weekdayPointers.count; i++) {
        NSInteger index = (i + self.calendar.firstWeekday - 1) % 7;
        UILabel *label = [self.weekdayPointers pointerAtIndex:i];
        label.font = self.calendar.appearance.weekdayFont;
        label.textColor = self.calendar.appearance.weekdayTextColor;
        label.text = useDefaultWeekdayCase ? weekdaySymbols[index] : [weekdaySymbols[index] uppercaseString];
    }
}

@end
