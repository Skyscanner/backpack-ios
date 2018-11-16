//
//  BPKCalendarStickyHeader.m
//  Backpack
//
//  Created by Aron Szabados on 2018. 11. 16..
//

#import "BPKCalendarStickyHeader.h"
#import "BPKCalendarAppearance.h"
#import <Backpack/Font.h>

@interface FSCalendarStickyHeader (Private)

@property (weak  , nonatomic) UIView  *contentView;
@property (weak  , nonatomic) UIView  *bottomBorder;
@property (weak  , nonatomic) FSCalendarWeekdayView *weekdayView;

@end

@implementation BPKCalendarStickyHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.weekdayView removeFromSuperview];
        [self.bottomBorder removeFromSuperview];
    }
    return self;
}

- (void)configureAppearance {
    [super configureAppearance];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}

- (void)setMonth:(NSDate *)month {
    [super setMonth:month];
    BPKFontStyle fontStyle = ((BPKCalendarAppearance *)self.calendar.appearance).headerTitleFontStyle;
    NSAttributedString *monthText = [BPKFont attributedStringWithFontStyle:fontStyle content:self.titleLabel.text];
    self.titleLabel.attributedText = monthText;
}

@end
