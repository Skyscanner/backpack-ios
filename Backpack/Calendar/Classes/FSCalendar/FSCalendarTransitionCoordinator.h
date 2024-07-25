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

#import "FSCalendar.h"
#import "FSCalendarCollectionView.h"
#import "FSCalendarCollectionViewLayout.h"

typedef NS_ENUM(NSUInteger, FSCalendarTransitionState) {
    FSCalendarTransitionStateIdle,
    FSCalendarTransitionStateChanging,
    FSCalendarTransitionStateFinishing,
};

@interface FSCalendarTransitionCoordinator : NSObject <UIGestureRecognizerDelegate>

@property(assign, nonatomic) FSCalendarTransitionState state;

@property(assign, nonatomic) CGSize cachedMonthSize;

@property(readonly, nonatomic) FSCalendarScope representingScope;

- (instancetype)initWithCalendar:(FSCalendar *)calendar;

- (void)performScopeTransitionFromScope:(FSCalendarScope)fromScope toScope:(FSCalendarScope)toScope animated:(BOOL)animated;
- (void)performBoundingRectTransitionFromMonth:(NSDate *)fromMonth toMonth:(NSDate *)toMonth duration:(CGFloat)duration;
- (CGRect)boundingRectForScope:(FSCalendarScope)scope page:(NSDate *)page;

- (void)handleScopeGesture:(id)sender;

@end

@interface FSCalendarTransitionAttributes : NSObject

@property(assign, nonatomic) CGRect sourceBounds;
@property(assign, nonatomic) CGRect targetBounds;
@property(strong, nonatomic) NSDate *sourcePage;
@property(strong, nonatomic) NSDate *targetPage;
@property(assign, nonatomic) NSInteger focusedRow;
@property(strong, nonatomic) NSDate *focusedDate;
@property(assign, nonatomic) FSCalendarScope targetScope;

- (void)revert;

@end
