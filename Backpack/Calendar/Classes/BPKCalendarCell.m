/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import <FSCalendar/FSCalendarDynamicHeader.h>
#import <FSCalendar/FSCalendarExtensions.h>

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Spacing.h>

#import "BPKCalendar.h"

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

    CGFloat padding = (CGRectGetWidth(self.bounds) - CGRectGetWidth(self.shapeLayer.bounds)) / 2.0 - 0.5;
    if (padding > CGRectGetWidth(self.shapeLayer.bounds) / 8.0) {
        padding = CGRectGetWidth(self.shapeLayer.bounds) / 8.0;
    }

    CGRect selectionRect = CGRectZero;
    CGRect bounds = self.selectionLayer.bounds;
    CGFloat height = self.shapeLayer.fs_height;
    CGFloat shapeLayerX = CGRectGetMinX(self.shapeLayer.frame);

    self.shapeLayer.hidden = NO;
    self.selectionLayer.hidden = NO;
    self.selectionLayer.frame = CGRectMake(0.0, CGRectGetMinY(self.shapeLayer.frame), CGRectGetWidth(self.bounds),
                                           CGRectGetHeight(self.shapeLayer.frame));
    UIColor *rangeColor = self.appearance.selectionColor;
    self.selectionLayer.fillColor = rangeColor.CGColor;

    self.samedayLayer.hidden = YES;
    self.samedayLayer.frame =
        CGRectMake(CGRectGetMinX(self.shapeLayer.frame) - padding, CGRectGetMinY(self.selectionLayer.frame),
                   CGRectGetWidth(self.shapeLayer.frame), CGRectGetHeight(self.selectionLayer.frame));
    self.samedayLayer.fillColor = [UIColor clearColor].CGColor;
    self.samedayLayer.strokeColor = self.appearance.selectionColor.CGColor;
    UIBezierPath *sameDayPath = [UIBezierPath bezierPathWithRoundedRect:self.samedayLayer.bounds
                                                      byRoundingCorners:UIRectCornerAllCorners
                                                            cornerRadii:self.shapeLayer.frame.size];
    [sameDayPath setLineWidth:3.0];

    BOOL isRTL = [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.semanticContentAttribute];
    self.samedayLayer.path = sameDayPath.CGPath;

    UIRectCorner corners = 0;
    CGSize cornerRadii = CGSizeZero;

    switch (self.rowType) {
    case RowTypeStart:
        if (!isRTL) {
            corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
        } else {
            corners = UIRectCornerTopRight | UIRectCornerBottomRight;
        }
        cornerRadii = CGSizeMake(height / 2.0, height / 2.0);
        break;

    case RowTypeEnd:
        if (!isRTL) {
            corners = UIRectCornerTopRight | UIRectCornerBottomRight;
        } else {
            corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
        }
        cornerRadii = CGSizeMake(height / 2.0, height / 2.0);
        break;

    case RowTypeBoth:
        corners = UIRectCornerAllCorners;
        cornerRadii = CGSizeMake(height / 2.0, height / 2.0);

    default:
        break;
    }

    switch (self.selectionType) {
    case SelectionTypeMiddle:
        self.shapeLayer.hidden = !self.dateIsToday;
        selectionRect = CGRectMake(0, 0, bounds.size.width, height);
        break;

    case SelectionTypeTrailingBorder:
        if (!isRTL) {
            corners |= UIRectCornerTopRight | UIRectCornerBottomRight;
            selectionRect = CGRectMake(0, 0, bounds.size.width - shapeLayerX, height);
        } else {
            corners |= UIRectCornerTopLeft | UIRectCornerBottomLeft;
            selectionRect = CGRectMake(shapeLayerX, 0, bounds.size.width - shapeLayerX, height);
        }
        cornerRadii = CGSizeMake(height / 2.0, height / 2.0);
        break;

    case SelectionTypeLeadingBorder:
        if (!isRTL) {
            corners |= UIRectCornerTopLeft | UIRectCornerBottomLeft;
            selectionRect = CGRectMake(shapeLayerX, 0, bounds.size.width - shapeLayerX, height);
        } else {
            corners |= UIRectCornerTopRight | UIRectCornerBottomRight;
            selectionRect = CGRectMake(0, 0, bounds.size.width - shapeLayerX, height);
        }
        cornerRadii = CGSizeMake(height / 2.0, height / 2.0);
        break;

    case SelectionTypeSameDay:
        self.samedayLayer.hidden = NO;
        self.selectionLayer.hidden = YES;
        self.shapeLayer.frame =
            CGRectMake(self.shapeLayer.frame.origin.x + padding, self.shapeLayer.frame.origin.y,
                       CGRectGetWidth(self.shapeLayer.frame), CGRectGetHeight(self.shapeLayer.frame));
        break;

    default:
        self.selectionLayer.hidden = YES;
        break;
    }

    self.selectionLayer.path =
        [UIBezierPath bezierPathWithRoundedRect:selectionRect byRoundingCorners:corners cornerRadii:cornerRadii].CGPath;
    [self configureAppearance];
}

- (void)configureAppearance {
    [super configureAppearance];

    UIColor *selectedColor =
        self.preferredTitleSelectionColor ?: self.appearance.titleColors[@(FSCalendarCellStateSelected)];
    UIColor *color =
        self.preferredTitleDefaultColor ?: [self colorForCurrentStateInDictionary:self.appearance.titleColors];

    if (self.titleLabel.text) {
        switch (self.selectionType) {
        case SelectionTypeSingle:
        case SelectionTypeLeadingBorder:
        case SelectionTypeTrailingBorder:
        case SelectionTypeSameDay:
            self.titleLabel.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextSmEmphasized
                                                                            content:self.titleLabel.text
                                                                          textColor:selectedColor];
            break;

        case SelectionTypeMiddle:
            self.titleLabel.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextSm
                                                                            content:self.titleLabel.text
                                                                          textColor:selectedColor];
            break;

        default:
            self.titleLabel.attributedText = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextSm
                                                                            content:self.titleLabel.text
                                                                          textColor:color];
            break;
        }
    }
}

- (void)setAccessibilityLabel:(NSString *)accessibilityLabel {
    self.titleLabel.accessibilityLabel = accessibilityLabel;
}

- (void)setAccessibilityTraits:(UIAccessibilityTraits)accessibilityTraits {
    self.titleLabel.accessibilityTraits = accessibilityTraits;
}

- (UIAccessibilityTraits)accessibilityTraits {
    return self.titleLabel.accessibilityTraits;
}

- (void)setSelectionType:(SelectionType)selectionType {
    if (_selectionType != selectionType) {
        _selectionType = selectionType;
        [self setNeedsLayout];
    }
}

@end
