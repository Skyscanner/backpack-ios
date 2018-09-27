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

@class BPKAlertButtonAction;
@class BPKAlertFaderAction;
@class BPKAlertDoneButtonConfiguration;

NS_SWIFT_NAME(AlertConfiguration) @interface BPKAlertConfiguration : NSObject

@property (nonatomic) UIColor *circleColor;
@property (nonatomic) UIImage *iconImage;
@property (nonatomic) NSString *titleText;
@property (nonatomic) NSString *descriptionText;
@property (nonatomic) NSArray<BPKAlertButtonAction *> *buttonConfigurations;
@property (nonatomic) BPKAlertDoneButtonConfiguration *doneButtonConfiguration;
@property (nonatomic) BPKAlertFaderAction *faderConfiguration;
@property (nonatomic) BOOL hasShadow;
@property (nonatomic) BOOL isFullScreen;

- (instancetype _Nonnull)init __attribute__((unavailable("use initWithCircleColor: instead")));
- (instancetype _Nonnull)initWithCircleColor:(UIColor *)circleColor
                                        icon:(UIImage *)iconImage
                                   titleText:(NSString *)titleText
                             descriptionText:(NSString *)descriptionText
                        buttonConfigurations:(NSArray<BPKAlertButtonAction *> *)buttonConfigurations
                                   hasShadow:(BOOL)hasShadow
                     doneButtonConfiguration:(BPKAlertDoneButtonConfiguration *)doneButtonConfiguration
                          faderConfiguration:(BPKAlertFaderAction *)faderConfiguration
                                isFullScreen:(BOOL)isFullScreen;

@end
