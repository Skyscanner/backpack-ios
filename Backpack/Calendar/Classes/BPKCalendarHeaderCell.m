//
//  BPKCalendarHeaderCellCollectionViewCell.m
//  Backpack
//
//  Created by Aron Szabados on 2018. 11. 16..
//

#import "BPKCalendarHeaderCell.h"
#import "BPKCalendarAppearance.h"

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Spacing.h>

@implementation BPKCalendarHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    BPKFontStyle fontStyle = ((BPKCalendarAppearance *)self.header.calendar.appearance).headerTitleFontStyle;
    NSAttributedString *monthText = [BPKFont attributedStringWithFontStyle:fontStyle content:self.titleLabel.text];
    self.titleLabel.attributedText = monthText;
}

@end
