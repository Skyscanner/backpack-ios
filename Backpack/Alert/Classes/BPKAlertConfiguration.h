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
#import "BPKAlertButtonConfiguration.h"

@interface BPKAlertConfiguration : NSObject

@property (nonatomic) BPKColor *circleColor;
@property (nonatomic) NSString *titleText;
@property (nonatomic) NSString *descriptionText;
@property (nonatomic) NSString *doneButtonText;
@property (nonatomic) NSArray<BPKAlertButtonConfiguration *> *buttonConfigurations;
@property (nonatomic) BOOL hasShadow;
@property (nonatomic) BOOL hasDoneButton;
@property (nonatomic) BOOL faderIsDismissAction;
@property (nonatomic) BOOL isFullScreen;

- (instancetype)initWithCircleColor:(BPKColor *)circleColor
                          titleText:(NSString *)titleText
                    descriptionText:(NSString *)descriptionText
               buttonConfigurations:(NSArray<BPKAlertButtonConfiguration *> *)buttonConfigurations
                          hasShadow:(BOOL)hasShadow
                    hasDoneButton:(BOOL)hasDoneButton
                     doneButtonText:(NSString *)doneButtonText
                faderIsDismissAction:(BOOL)faderIsDismissAction
                        isFullScreen:(BOOL)isFullScreen;

+ (instancetype _Nonnull)normalConfigurationWithTitle:(NSString *)title
                                          description:(NSString *)description
                                    primaryButtonText:(NSString *)primaryButtonText
                                  secondaryButtonText:(NSString *)secondaryButtonText
                                 primaryActionHandler:(BPKAlertButtonActionHandler)primaryHandler
                               secondaryActionHandler:(BPKAlertButtonActionHandler)secondaryHandler;

+ (instancetype _Nonnull)errorConfigurationWithTitle:(NSString *)title
                                         description:(NSString *)description
                                   primaryButtonText:(NSString *)primaryButtonText
                                 secondaryButtonText:(NSString *)secondaryButtonText
                                primaryActionHandler:(BPKAlertButtonActionHandler)primaryHandler
                              secondaryActionHandler:(BPKAlertButtonActionHandler)secondaryHandler;

+ (instancetype _Nonnull)warningConfigurationWithTitle:(NSString *)title
                                           description:(NSString *)description
                                     primaryButtonText:(NSString *)primaryButtonText
                                   secondaryButtonText:(NSString *)secondaryButtonText
                                  primaryActionHandler:(BPKAlertButtonActionHandler)primaryHandler
                                secondaryActionHandler:(BPKAlertButtonActionHandler)secondaryHandler;

@end
