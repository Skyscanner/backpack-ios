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

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FSCalendarExtensions)

@property(nonatomic) CGFloat fs_width;
@property(nonatomic) CGFloat fs_height;

@property(nonatomic) CGFloat fs_top;
@property(nonatomic) CGFloat fs_left;
@property(nonatomic) CGFloat fs_bottom;
@property(nonatomic) CGFloat fs_right;

@end

@interface CALayer (FSCalendarExtensions)

@property(nonatomic) CGFloat fs_width;
@property(nonatomic) CGFloat fs_height;

@property(nonatomic) CGFloat fs_top;
@property(nonatomic) CGFloat fs_left;
@property(nonatomic) CGFloat fs_bottom;
@property(nonatomic) CGFloat fs_right;

@end

@interface NSCalendar (FSCalendarExtensions)

- (nullable NSDate *)fs_firstDayOfMonth:(NSDate *)month;
- (nullable NSDate *)fs_lastDayOfMonth:(NSDate *)month;
- (nullable NSDate *)fs_firstDayOfWeek:(NSDate *)week;
- (nullable NSDate *)fs_lastDayOfWeek:(NSDate *)week;
- (nullable NSDate *)fs_middleDayOfWeek:(NSDate *)week;
- (NSInteger)fs_numberOfDaysInMonth:(NSDate *)month;

@end

@interface NSMapTable (FSCalendarExtensions)

- (void)setObject:(nullable id)obj forKeyedSubscript:(id<NSCopying>)key;
- (id)objectForKeyedSubscript:(id<NSCopying>)key;

@end

@interface NSCache (FSCalendarExtensions)

- (void)setObject:(nullable id)obj forKeyedSubscript:(id<NSCopying>)key;
- (id)objectForKeyedSubscript:(id<NSCopying>)key;

@end

@interface NSObject (FSCalendarExtensions)

#define IVAR_DEF(SET, GET, TYPE)                                                                                                                     \
    -(void)fs_set##SET##Variable : (TYPE)value forKey : (NSString *)key;                                                                             \
    -(TYPE)fs_##GET##VariableForKey : (NSString *)key;
IVAR_DEF(Bool, bool, BOOL)
IVAR_DEF(Float, float, CGFloat)
IVAR_DEF(Integer, integer, NSInteger)
IVAR_DEF(UnsignedInteger, unsignedInteger, NSUInteger)
#undef IVAR_DEF

- (void)fs_setVariable:(id)variable forKey:(NSString *)key;
- (id)fs_variableForKey:(NSString *)key;

- (nullable id)fs_performSelector:(SEL)selector withObjects:(nullable id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;

@end

NS_ASSUME_NONNULL_END
