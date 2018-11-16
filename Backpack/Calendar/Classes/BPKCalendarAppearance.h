//
//  BPKCalendarAppearance.h
//  Backpack
//
//  Created by Aron Szabados on 2018. 11. 16..
//

#import <FSCalendar/FSCalendar.h>
#import <Backpack/Font.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKCalendarAppearance : FSCalendarAppearance

@property BPKFontStyle headerTitleFontStyle;

+(instancetype)fromFSCalendarAppearance:(FSCalendarAppearance *)appearance;

@end

NS_ASSUME_NONNULL_END
