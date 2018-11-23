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

#import "BPKCalendarCell.h"
#import <FSCalendar/FSCalendarDynamicHeader.h>
#import <FSCalendar/FSCalendarExtensions.h>
#import <Backpack/Color.h>
#import <Backpack/Font.h>

@interface BPKCalendarCell ()

@property (weak, nonatomic) CAShapeLayer *selectionLayer;

@end

@implementation BPKCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        CAShapeLayer *selectionLayer = [[CAShapeLayer alloc] init];
        selectionLayer.actions = @{@"hidden":[NSNull null]};
        [self.contentView.layer insertSublayer:selectionLayer below:self.shapeLayer];
        self.selectionLayer = selectionLayer;
    }

    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect selectionRect = CGRectZero;
    CGRect bounds = self.selectionLayer.bounds;
    CGFloat height = self.shapeLayer.fs_height;
    CGFloat shapeLayerX = self.shapeLayer.frame.origin.x;
    
    self.shapeLayer.hidden = NO;
    self.selectionLayer.hidden = NO;
    self.selectionLayer.frame = self.bounds;
    UIColor *rangeColor = [self.appearance.selectionColor colorWithAlphaComponent:0.5];
    self.selectionLayer.fillColor = rangeColor.CGColor;
    
    UIRectCorner corners = 0;
    CGSize cornerRadii = CGSizeZero;
    
    switch (self.rowType) {
        case RowTypeStart:
            corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
            cornerRadii = CGSizeMake(height/2.0, height/2.0);
            break;
            
        case RowTypeEnd:
            corners = UIRectCornerTopRight | UIRectCornerBottomRight;
            cornerRadii = CGSizeMake(height/2.0, height/2.0);
            break;
            
        case RowTypeBoth:
            corners = UIRectCornerAllCorners;
            cornerRadii = CGSizeMake(height/2.0, height/2.0);
            
        default:
            break;
    }
    
    switch (self.selectionType) {
        case SelectionTypeMiddle:
            self.shapeLayer.hidden = !self.dateIsToday;
            selectionRect = CGRectMake(0, 0, bounds.size.width, height);
            break;
        
        case SelectionTypeRightBorder:
            selectionRect = CGRectMake(0, 0, bounds.size.width - shapeLayerX, height);
            corners |= UIRectCornerTopRight | UIRectCornerBottomRight;
            cornerRadii = CGSizeMake(height/2.0, height/2.0);
            break;
            
        case SelectionTypeLeftBorder:
            selectionRect = CGRectMake(shapeLayerX, 0, bounds.size.width - shapeLayerX, height);
            corners |= UIRectCornerTopLeft | UIRectCornerBottomLeft;
            cornerRadii = CGSizeMake(height/2.0, height/2.0);
            break;
            
        default:
            self.selectionLayer.hidden = YES;
            break;
    }
    
    self.selectionLayer.path = [UIBezierPath bezierPathWithRoundedRect:selectionRect
                                                     byRoundingCorners:corners
                                                           cornerRadii:cornerRadii].CGPath;
    [self configureAppearance];
}

-(void)configureAppearance {
    [super configureAppearance];

    UIColor *selectedColor = self.preferredTitleSelectionColor ?: self.appearance.titleColors[@(FSCalendarCellStateSelected)];
    UIColor *color = self.preferredTitleDefaultColor ?: [self colorForCurrentStateInDictionary:self.appearance.titleColors];
    
    if (self.titleLabel.text) {
        switch (self.selectionType) {
            case SelectionTypeSingle:
            case SelectionTypeLeftBorder:
            case SelectionTypeRightBorder:
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

- (void)setSelectionType:(SelectionType)selectionType {
    if (_selectionType != selectionType) {
        _selectionType = selectionType;
        [self setNeedsLayout];
    }
}

@end
