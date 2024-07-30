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

//
//  FSCalendarHeader.h
//  Pods
//
//  Created by Wenchao Ding on 29/1/15.
//
//

#import <UIKit/UIKit.h>

@class FSCalendar, FSCalendarAppearance, FSCalendarHeaderLayout, FSCalendarCollectionView;

@interface FSCalendarHeaderView : UIView

@property(weak, nonatomic) FSCalendarCollectionView *collectionView;
@property(weak, nonatomic) FSCalendarHeaderLayout *collectionViewLayout;
@property(weak, nonatomic) FSCalendar *calendar;

@property(assign, nonatomic) UICollectionViewScrollDirection scrollDirection;
@property(assign, nonatomic) BOOL scrollEnabled;

- (void)setScrollOffset:(CGFloat)scrollOffset;
- (void)setScrollOffset:(CGFloat)scrollOffset animated:(BOOL)animated;
- (void)reloadData;
- (void)configureAppearance;

@end

@interface FSCalendarHeaderCell : UICollectionViewCell

@property(weak, nonatomic) UILabel *titleLabel;
@property(weak, nonatomic) FSCalendarHeaderView *header;

@end

@interface FSCalendarHeaderLayout : UICollectionViewFlowLayout

@end

@interface FSCalendarHeaderTouchDeliver : UIView

@property(weak, nonatomic) FSCalendar *calendar;
@property(weak, nonatomic) FSCalendarHeaderView *header;

@end
