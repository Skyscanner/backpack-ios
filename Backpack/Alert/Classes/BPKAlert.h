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
#import <Backpack/Color.h>
#import <Backpack/Button.h>
#import "BPKAlertView.h"

typedef void (^BPKAlertActionItemHandler)(void);

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, BPKAlertStyle) {
    BPKAlertStyleError,
    BPKAlertStyleWarning,
    BPKAlertStyleNormal
};

/**
 * `BPKAlert` is a...
 */
@interface BPKAlert: NSObject<BPKAlertViewDelegate>

@property (nonatomic, getter=isFaderDismissingAlert) BOOL faderDismissingAlert;

-(void)setTitle:(NSString *)titleString;
-(void)setDescription:(NSString *)descriptionString;
-(void)setPrimaryButtonStyle:(BPKButtonStyle)style;
-(void)setSecondaryButtonStyle:(BPKButtonStyle)style;


- (void)alertWithTitle:(NSString * _Nonnull)title
           description:(NSString * _Nonnull)description
                 style:(BPKAlertStyle)style
  primaryActionHandler:(_Nullable BPKAlertActionItemHandler)primaryActionHandler
    primaryButtonTitle:(NSString *_Nonnull)primaryButtonTitle
secondaryActionHandler:(_Nullable BPKAlertActionItemHandler)secondaryActionHandler
  secondaryButtonTitle:(NSString *_Nonnull)secondaryButtonTitle
         hasDropShadow:(BOOL)isDropShadowEnabled
        doneButtonText:(NSString * _Nonnull)doneButtonText
                onView:(UIView * _Nonnull)baseView;

@end

NS_ASSUME_NONNULL_END
