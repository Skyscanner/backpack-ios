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
