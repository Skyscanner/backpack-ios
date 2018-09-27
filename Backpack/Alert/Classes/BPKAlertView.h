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

#import <UIKit/UIKit.h>
#import "BPKAlertButtonAction.h"

@class BPKShadow;

NS_ASSUME_NONNULL_BEGIN
@protocol BPKAlertViewDelegate <NSObject>

- (void)closeAlertWithHandler:(BPKAlertButtonActionHandler)handler;
- (void)dismissAlertWithFaderTap;

@end

@interface BPKAlertView : UIView<UIGestureRecognizerDelegate>

@property (nonatomic, weak) id<BPKAlertViewDelegate> delegate;

- (void)setShadow:(NSShadow *)shadow __attribute__((unavailable("setShadow: not available, use setBackpackShadow: instead")));
@property (nonatomic) BPKShadow *backpackShadow;

-(void)setHeadColor:(UIColor * _Nullable)color;
-(void)setTitle:(NSString *)titleString;
-(void)setDescription:(NSString *)descriptionString;
-(void)setButtonActions:(NSArray<BPKAlertButtonAction *> *)buttonActions;
-(void)setIcon:(UIImage *)iconImage;

@end
NS_ASSUME_NONNULL_END
