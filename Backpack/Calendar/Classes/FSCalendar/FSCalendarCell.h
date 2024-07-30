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

#import <UIKit/UIKit.h>

@class FSCalendar, FSCalendarAppearance, FSCalendarEventIndicator;

typedef NS_ENUM(NSUInteger, FSCalendarMonthPosition);

@interface FSCalendarCell : UICollectionViewCell

#pragma mark - Public properties

/**
 The day text label of the cell
 */
@property(weak, nonatomic) UILabel *titleLabel;

/**
 The subtitle label of the cell
 */
@property(weak, nonatomic) UILabel *subtitleLabel;

/**
 The shape layer of the cell
 */
@property(weak, nonatomic) CAShapeLayer *shapeLayer;

/**
 The imageView below shape layer of the cell
 */
@property(weak, nonatomic) UIImageView *imageView;

/**
 The collection of event dots of the cell
 */
@property(weak, nonatomic) FSCalendarEventIndicator *eventIndicator;

/**
 A boolean value indicates that whether the cell is "placeholder". Default is NO.
 */
@property(assign, nonatomic, getter=isPlaceholder) BOOL placeholder;

#pragma mark - Private properties

@property(weak, nonatomic) FSCalendar *calendar;
@property(weak, nonatomic) FSCalendarAppearance *appearance;

@property(strong, nonatomic) NSString *subtitle;
@property(strong, nonatomic) UIImage *image;
@property(assign, nonatomic) FSCalendarMonthPosition monthPosition;

@property(assign, nonatomic) NSInteger numberOfEvents;
@property(assign, nonatomic) BOOL dateIsToday;
@property(assign, nonatomic) BOOL weekend;

@property(strong, nonatomic) UIColor *preferredFillDefaultColor;
@property(strong, nonatomic) UIColor *preferredFillSelectionColor;
@property(strong, nonatomic) UIColor *preferredTitleDefaultColor;
@property(strong, nonatomic) UIColor *preferredTitleSelectionColor;
@property(strong, nonatomic) UIColor *preferredSubtitleDefaultColor;
@property(strong, nonatomic) UIColor *preferredSubtitleSelectionColor;
@property(strong, nonatomic) UIColor *preferredBorderDefaultColor;
@property(strong, nonatomic) UIColor *preferredBorderSelectionColor;
@property(assign, nonatomic) CGPoint preferredTitleOffset;
@property(assign, nonatomic) CGPoint preferredSubtitleOffset;
@property(assign, nonatomic) CGPoint preferredImageOffset;
@property(assign, nonatomic) CGPoint preferredEventOffset;

@property(strong, nonatomic) NSArray<UIColor *> *preferredEventDefaultColors;
@property(strong, nonatomic) NSArray<UIColor *> *preferredEventSelectionColors;
@property(assign, nonatomic) CGFloat preferredBorderRadius;

// Add subviews to self.contentView and set up constraints
- (instancetype)initWithFrame:(CGRect)frame NS_REQUIRES_SUPER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_REQUIRES_SUPER;

// For DIY overridden
- (void)layoutSubviews NS_REQUIRES_SUPER;      // Configure frames of subviews
- (void)configureAppearance NS_REQUIRES_SUPER; // Configure appearance for cell

- (UIColor *)colorForCurrentStateInDictionary:(NSDictionary *)dictionary;
- (void)performSelecting;

@end

@interface FSCalendarEventIndicator : UIView

@property(assign, nonatomic) NSInteger numberOfEvents;
@property(strong, nonatomic) id color;

@end

@interface FSCalendarBlankCell : UICollectionViewCell

- (void)configureAppearance;

@end
