//
//  FSCalendarWeekdayView.h
//  FSCalendar
//
//  Created by dingwenchao on 03/11/2016.
//  Copyright © 2016 dingwenchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FSCalendar;

@interface FSCalendarWeekdayView : UIView

/**
 An array of UILabel objects displaying the weekday symbols.
 */
@property(readonly, nonatomic) NSArray<UILabel *> *weekdayLabels;

- (void)configureAppearance;

@end

NS_ASSUME_NONNULL_END
