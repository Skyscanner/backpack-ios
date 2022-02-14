/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

#import "BPKCalendarCell.h"

#import "BPKCalendarCellSpacing.h"

#import <FSCalendar/FSCalendarDynamicHeader.h>
#import <FSCalendar/FSCalendarExtensions.h>

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Spacing.h>

const CGFloat BPKCalendarCellSameDayXOffset = 3.75;

@interface BPKCalendarCell ()

@property(weak, nonatomic) CAShapeLayer *selectionLayer;
@property(weak, nonatomic) CAShapeLayer *samedayLayer;

@end

@implementation BPKCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        CAShapeLayer *selectionLayer = [[CAShapeLayer alloc] init];
        CAShapeLayer *samedayLayer = [[CAShapeLayer alloc] init];
        selectionLayer.actions = @{@"hidden": [NSNull null]};
        samedayLayer.actions = @{@"hidden": [NSNull null]};
        [self.contentView.layer insertSublayer:samedayLayer below:self.shapeLayer];
        [self.contentView.layer insertSublayer:selectionLayer below:samedayLayer];
        self.selectionLayer = selectionLayer;
        self.samedayLayer = samedayLayer;
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat paddingX = (CGRectGetWidth(self.bounds) - BPKCalendarCellSpacing.cellCircleHeight) / 2.0;
    CGFloat paddingInnerCircle = 6;

    self.shapeLayer.hidden = NO;
    self.selectionLayer.hidden = NO;
    self.selectionLayer.frame = CGRectMake(0.0, 0, BPKCalendarCellSpacing.cellCircleHeight, BPKCalendarCellSpacing.cellCircleHeight);

    self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.titleLabel.frame), BPKCalendarCellSpacing.cellTitleHeight);

    CGRect selectionRect = CGRectZero;
    CGRect bounds = self.bounds;
    CGFloat height = BPKCalendarCellSpacing.cellCircleHeight;

    self.samedayLayer.hidden = YES;
    self.samedayLayer.frame = CGRectMake(paddingX, 0, BPKCalendarCellSpacing.cellCircleHeight, BPKCalendarCellSpacing.cellCircleHeight);
    UIBezierPath *sameDayPath = [UIBezierPath bezierPathWithRoundedRect:self.samedayLayer.bounds
                                                      byRoundingCorners:UIRectCornerAllCorners
                                                            cornerRadii:self.shapeLayer.frame.size];
    [sameDayPath setLineWidth:3.0];

    BOOL isRTL = [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.semanticContentAttribute];
    self.samedayLayer.path = sameDayPath.CGPath;

    UIRectCorner corners = 0;
    CGSize cornerRadii = CGSizeZero;

    self.shapeLayer.frame = CGRectMake(paddingX, 0, BPKCalendarCellSpacing.cellCircleHeight, BPKCalendarCellSpacing.cellCircleHeight);

    // We use the screen width to ensure the overflowLength is always long enough
    //even when we need to draw it from the first cell on a row to the edge of the opposite screen.
    CGFloat overflowLength = [[UIScreen mainScreen] bounds].size.width;
    CGFloat underflow = 0;
    CGFloat overflow = 0;

    switch (self.rowType) {
        case RowTypeStart:
            if (self.selectionType != SelectionTypeLeadingBorder) {
                underflow = overflowLength;
            }
            break;
        case RowTypeEnd:
            if (self.selectionType != SelectionTypeTrailingBorder) {
                overflow = overflowLength;
            }
            break;
        case RowTypeBoth:
            if (self.selectionType != SelectionTypeLeadingBorder) {
                underflow = overflowLength;
            }
            if (self.selectionType != SelectionTypeTrailingBorder) {
                overflow = overflowLength;
            }
            break;
        default:
            break;
    }

    CGFloat overunderflow = overflow + underflow;
    if (underflow + overflow > 0.001) {
        self.clipsToBounds = NO;
    }

    switch (self.selectionType) {
    case SelectionTypeMiddle:
        self.shapeLayer.hidden = !self.dateIsToday;
            if(!isRTL) {
                selectionRect = CGRectMake(0 - underflow, 0, CGRectGetWidth(bounds) + overunderflow, height);
            }else {
                selectionRect = CGRectMake(0 - overflow, 0, CGRectGetWidth(bounds) + overunderflow, height);
            }
        break;

    case SelectionTypeTrailingBorder:
        if (!isRTL) {
            corners |= UIRectCornerTopRight | UIRectCornerBottomRight;
            selectionRect = CGRectMake(0 - underflow, 0, CGRectGetWidth(bounds) - paddingX + overunderflow, height);
        } else {
            corners |= UIRectCornerTopLeft | UIRectCornerBottomLeft;
            selectionRect = CGRectMake(paddingX - overflow, 0, CGRectGetWidth(bounds) - paddingX + overunderflow, height);
        }
        cornerRadii = CGSizeMake(height / 2.0, height / 2.0);
        break;

    case SelectionTypeLeadingBorder:
        if (!isRTL) {
            corners |= UIRectCornerTopLeft | UIRectCornerBottomLeft;
            selectionRect = CGRectMake(paddingX - underflow, 0, CGRectGetWidth(bounds) - paddingX + overunderflow, height);
        } else {
            corners |= UIRectCornerTopRight | UIRectCornerBottomRight;
            selectionRect = CGRectMake(0 - overflow, 0, CGRectGetWidth(bounds) - paddingX + overunderflow, height);
        }
        cornerRadii = CGSizeMake(height / 2.0, height / 2.0);
        break;

    case SelectionTypeSameDay:
        self.samedayLayer.hidden = NO;
        self.selectionLayer.hidden = YES;
        self.shapeLayer.frame = CGRectMake(paddingX + paddingInnerCircle / 2, paddingInnerCircle / 2, BPKCalendarCellSpacing.cellCircleHeight - paddingInnerCircle, BPKCalendarCellSpacing.cellCircleHeight - paddingInnerCircle);
        break;

    default:
        self.selectionLayer.hidden = YES;
        break;
    }

    self.selectionLayer.path = [UIBezierPath bezierPathWithRoundedRect:selectionRect byRoundingCorners:corners cornerRadii:cornerRadii].CGPath;
    [self configureAppearance];
}

- (void)configureAppearance {
    [super configureAppearance];

    UIColor *rangeColor = [BPKColor blend:self.appearance.selectionColor with:BPKColor.backgroundAlternativeSecondaryColor weight:0.3];
    UIColor *selectedColor = self.preferredTitleSelectionColor ?: self.appearance.titleColors[@(FSCalendarCellStateSelected)];
    UIColor *color = self.preferredTitleDefaultColor ?: [self colorForCurrentStateInDictionary:self.appearance.titleColors];

    self.selectionLayer.fillColor = rangeColor.CGColor;
    self.samedayLayer.fillColor = BPKColor.clear.CGColor;
    self.samedayLayer.strokeColor = self.appearance.selectionColor.CGColor;
    self.layer.borderColor = BPKColor.panjin.CGColor;
    self.titleLabel.layer.borderColor = BPKColor.panjin.CGColor;
    UIColor *rangeTitleColor = [self colorForCurrentStateInDictionary:self.appearance.titleColors];

    if (self.titleLabel.text) {
        switch (self.selectionType) {
        case SelectionTypeSingle:
        case SelectionTypeLeadingBorder:
        case SelectionTypeTrailingBorder:
        case SelectionTypeSameDay:
            self.titleLabel.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextHeading5
                                                                            content:self.titleLabel.text
                                                                          textColor:selectedColor];
            break;
        case SelectionTypeMiddle:
            self.titleLabel.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextHeading5
                                                                            content:self.titleLabel.text
                                                                          textColor:rangeTitleColor];
            break;

        default:
            self.titleLabel.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextHeading5
                                                                            content:self.titleLabel.text
                                                                          textColor:color];
            break;
        }
    }
}

- (void)setSelectionType:(SelectionType)selectionType {
    if (_selectionType != selectionType) {
        _selectionType = selectionType;
        [self setNeedsLayout];
    }
}

- (void)configureWithData:(id)data {
    NSAssert(false, @"BPKCalendarCell configureWithData: should be overridden. The base class method should never be called.");
}

- (NSString *)formattedDate:(NSDate *)date formatter:(NSDateFormatter *)formatter {
    return [formatter stringFromDate:date];
}

- (NSString *)defaultAccessibilityLabelForDate:(NSDate *)date formatter:(NSDateFormatter *)formatter {
    return [self formattedDate:date formatter:formatter];
}

@end
