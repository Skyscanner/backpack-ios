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
