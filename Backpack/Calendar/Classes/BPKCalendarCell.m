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
#import <FSCalendar/FSCalendarExtensions.h>
#import <Backpack/Color.h>

@implementation BPKCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAShapeLayer *selectionLayer = [[CAShapeLayer alloc] init];
        selectionLayer.actions = @{@"hidden":[NSNull null]};
        [self.contentView.layer insertSublayer:selectionLayer below:self.shapeLayer];
        self.selectionLayer = selectionLayer;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect selectionRect = CGRectZero;
    CGRect bounds = self.selectionLayer.bounds;
    CGFloat centerX = bounds.size.width / 2.0;
    CGFloat height = self.shapeLayer.fs_height;
    
    self.shapeLayer.hidden = NO;
    self.selectionLayer.frame = self.bounds;
    UIColor *rangeColor = [self.appearance.selectionColor colorWithAlphaComponent:0.7];
    self.selectionLayer.fillColor = rangeColor.CGColor;
    
    if (self.selectionType == SelectionTypeMiddle) {
        self.shapeLayer.hidden = !self.dateIsToday;
        selectionRect = CGRectMake(0, 0, bounds.size.width, height);
    } else if (self.selectionType == SelectionTypeLeftBorder) {
        selectionRect = CGRectMake(centerX, 0, centerX, height);
    } else if (self.selectionType == SelectionTypeRightBorder) {
        selectionRect = CGRectMake(0, 0, centerX, height);
    }
    
    self.selectionLayer.path = [UIBezierPath bezierPathWithRect:selectionRect].CGPath;
}

- (void)setSelectionType:(SelectionType)selectionType
{
    if (_selectionType != selectionType) {
        _selectionType = selectionType;
        [self setNeedsLayout];
    }
}

@end
