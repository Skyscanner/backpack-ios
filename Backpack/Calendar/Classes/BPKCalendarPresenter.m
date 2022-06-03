//
//  BPKCalendarPresenter.m
//  Backpack
//
//  Created by Gerardo Garrido on 2/6/22.
//

#import "BPKCalendarPresenter.h"

#import <Foundation/Foundation.h>
#import <Backpack/SimpleDate.h>

@interface BPKCalendarPresenter ()

@property (nonatomic, strong, readonly) NSCalendar *calendar;
@property (nonatomic, strong, readonly) BPKSimpleDate *minDate;

@end

@implementation BPKCalendarPresenter

- initWithCalendar:(NSCalendar *)calendar minDate:(BPKSimpleDate *)minDate {
    self = [super init];
    
    if (self) {
        _calendar = calendar;
        _minDate = minDate;
    }
    
    return self;
}

- (NSDate *)day:(NSInteger)day fromMonth:(NSDate *)month {
    NSDateComponents *comp = [self.calendar components:
                              NSCalendarUnitYear |
                              NSCalendarUnitMonth |
                              NSCalendarUnitDay fromDate:month];
    
    [comp setDay:day];
    
    return [self.calendar dateFromComponents:comp];
}

- (NSDate *)firstValidDayOfMonth:(NSDate *)month {
    NSDate *minDate = [self.minDate dateForCalendar:self.calendar];
    NSDate *firstDay = [self day:1 fromMonth:month];
    
    return [firstDay compare:minDate] == NSOrderedDescending ? firstDay : minDate;
}

- (NSDate *)lastDayOfMonth:(NSDate *)month {
    NSInteger lastDay = [self numberOfDaysInMonth:month];
    
    return [self day:lastDay fromMonth:month];
}

- (NSInteger)numberOfDaysInMonth:(NSDate *)month {
    NSRange daysOfMonth = [self.calendar rangeOfUnit:NSCalendarUnitDay
                                               inUnit:NSCalendarUnitMonth
                                              forDate:month];
    return daysOfMonth.length;
}

- (NSArray<NSDate *> *)dateListFrom:(NSDate *)firstDay to:(NSDate *)lastDay {
    NSMutableArray<NSDate *> *dateList = [NSMutableArray new];
    
    NSDate *day = firstDay;
    while ([day compare:lastDay] != NSOrderedDescending) {
        [dateList addObject:day];
        day = [self.calendar dateByAddingUnit:NSCalendarUnitDay
                                        value:1
                                       toDate:day
                                      options:0];
    }
    
    return dateList;
}

- (NSArray<BPKSimpleDate *> *)dateListForMonth:(NSDate *)month {
    NSDate *firstDay = [self firstValidDayOfMonth:month];
    NSDate *lastDay = [self lastDayOfMonth:month];
    
    NSArray<NSDate *> *dateList = [self dateListFrom:firstDay to:lastDay];
    return [BPKSimpleDate simpleDatesFromDates:dateList forCalendar:self.calendar];
}

@end
