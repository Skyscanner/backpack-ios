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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FSCalendar.h"
#import "FSCalendarCalculator.h"
#import "FSCalendarCell.h"
#import "FSCalendarCollectionView.h"
#import "FSCalendarCollectionViewLayout.h"
#import "FSCalendarDelegationProxy.h"
#import "FSCalendarHeaderView.h"
#import "FSCalendarStickyHeader.h"
#import "FSCalendarTransitionCoordinator.h"

@interface FSCalendar (Dynamic)

@property(readonly, nonatomic) FSCalendarCollectionView *collectionView;
@property(readonly, nonatomic) FSCalendarCollectionViewLayout *collectionViewLayout;
@property(readonly, nonatomic) FSCalendarTransitionCoordinator *transitionCoordinator;
@property(readonly, nonatomic) FSCalendarCalculator *calculator;
@property(readonly, nonatomic) BOOL floatingMode;
@property(readonly, nonatomic) NSArray *visibleStickyHeaders;
@property(readonly, nonatomic) CGFloat preferredHeaderHeight;
@property(readonly, nonatomic) CGFloat preferredWeekdayHeight;

@property(readonly, nonatomic) NSCalendar *gregorian;
@property(readonly, nonatomic) NSDateFormatter *formatter;

@property(readonly, nonatomic) UIView *contentView;
@property(readonly, nonatomic) UIView *daysContainer;

@property(assign, nonatomic) BOOL needsAdjustingViewFrame;

- (void)adjustMonthPosition;
- (void)configureAppearance;

- (CGSize)sizeThatFits:(CGSize)size scope:(FSCalendarScope)scope;

@end

@interface FSCalendarAppearance (Dynamic)

@property(readwrite, nonatomic) FSCalendar *calendar;

@property(readonly, nonatomic) NSDictionary *backgroundColors;
@property(readonly, nonatomic) NSDictionary *titleColors;
@property(readonly, nonatomic) NSDictionary *subtitleColors;
@property(readonly, nonatomic) NSDictionary *borderColors;

@end

@interface FSCalendarWeekdayView (Dynamic)

@property(readwrite, nonatomic) FSCalendar *calendar;

@end

@interface FSCalendarCollectionViewLayout (Dynamic)

@property(readonly, nonatomic) CGSize estimatedItemSize;

@end

@interface FSCalendarDelegationProxy () <FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance>
@end
