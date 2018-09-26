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

#import "BPKAlertConfiguration.h"

@implementation BPKAlertConfiguration

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(NO, @"Please call the custom init or the static methods");
    }
    return self;
}

- (instancetype _Nonnull)initWithCircleColor:(UIColor *)circleColor
                          titleText:(NSString *)titleText
                    descriptionText:(NSString *)descriptionText
               buttonConfigurations:(NSArray<BPKAlertButtonConfiguration *> *)buttonConfigurations
                          hasShadow:(BOOL)hasShadow
                      hasDoneButton:(BOOL)hasDoneButton
                     doneButtonText:(NSString *)doneButtonText
               faderIsDismissAction:(BOOL)faderIsDismissAction
                       isFullScreen:(BOOL)isFullScreen {
    self = [super init];
    if (self) {
        _circleColor = circleColor;
        _titleText = titleText;
        _descriptionText = descriptionText;
        _buttonConfigurations = buttonConfigurations;
        _hasShadow = hasShadow;
        _hasDoneButton = hasDoneButton;
        _doneButtonText = doneButtonText;
        _faderIsDismissAction = faderIsDismissAction;
        _isFullScreen = isFullScreen;
    }
    return self;
}

+ (instancetype _Nonnull)normalConfigurationWithTitle:(NSString *)title
                                          description:(NSString *)description
                                    primaryButtonText:(NSString *)primaryButtonText
                                  secondaryButtonText:(NSString *)secondaryButtonText
                                 primaryActionHandler:(BPKAlertButtonActionHandler)primaryHandler
                               secondaryActionHandler:(BPKAlertButtonActionHandler)secondaryHandler {
    BPKAlertButtonConfiguration *primaryConfig = [BPKAlertButtonConfiguration configurationWithStyle:BPKButtonStylePrimary
                                                                                               title:primaryButtonText
                                                                                       actionHandler:primaryHandler];
    
    BPKAlertButtonConfiguration *secondaryConfig = [BPKAlertButtonConfiguration configurationWithStyle:BPKButtonStyleSecondary
                                                                                                 title:secondaryButtonText
                                                                                         actionHandler:secondaryHandler];
    
    BPKAlertConfiguration *config = [[BPKAlertConfiguration alloc] initWithCircleColor:[BPKColor green500]
                                                                             titleText:title
                                                                       descriptionText:description
                                                                  buttonConfigurations:@[primaryConfig, secondaryConfig]
                                                                             hasShadow:YES
                                                                         hasDoneButton:NO
                                                                        doneButtonText:@""
                                                                  faderIsDismissAction:YES
                                                                          isFullScreen:NO];
    
    return config;
}

+ (instancetype _Nonnull)errorConfigurationWithTitle:(NSString *)title
                                         description:(NSString *)description
                                   primaryButtonText:(NSString *)primaryButtonText
                                 secondaryButtonText:(NSString *)secondaryButtonText
                                primaryActionHandler:(BPKAlertButtonActionHandler)primaryHandler
                              secondaryActionHandler:(BPKAlertButtonActionHandler)secondaryHandler {
    BPKAlertButtonConfiguration *primaryConfig = [BPKAlertButtonConfiguration configurationWithStyle:BPKButtonStyleDestructive
                                                                                               title:primaryButtonText
                                                                                       actionHandler:primaryHandler];
    
    BPKAlertButtonConfiguration *secondaryConfig = [BPKAlertButtonConfiguration configurationWithStyle:BPKButtonStyleSecondary
                                                                                                 title:secondaryButtonText
                                                                                         actionHandler:secondaryHandler];
    
    BPKAlertConfiguration *config = [[BPKAlertConfiguration alloc] initWithCircleColor:[BPKColor red500]
                                                                             titleText:title
                                                                       descriptionText:description
                                                                  buttonConfigurations:@[primaryConfig, secondaryConfig]
                                                                             hasShadow:YES
                                                                         hasDoneButton:NO
                                                                        doneButtonText:@""
                                                                  faderIsDismissAction:YES
                                                                          isFullScreen:NO];
    return config;
}

+ (instancetype _Nonnull)warningConfigurationWithTitle:(NSString *)title
                                         description:(NSString *)description
                                   primaryButtonText:(NSString *)primaryButtonText
                                 secondaryButtonText:(NSString *)secondaryButtonText
                                primaryActionHandler:(BPKAlertButtonActionHandler)primaryHandler
                              secondaryActionHandler:(BPKAlertButtonActionHandler)secondaryHandler {
    BPKAlertButtonConfiguration *primaryConfig = [BPKAlertButtonConfiguration
                                                  configurationWithStyle:BPKButtonStyleFeatured
                                                  title:primaryButtonText
                                                  actionHandler:primaryHandler];
    
    BPKAlertButtonConfiguration *secondaryConfig = [BPKAlertButtonConfiguration configurationWithStyle:BPKButtonStyleSecondary
                                                                                                 title:secondaryButtonText
                                                                                         actionHandler:secondaryHandler];
    
    BPKAlertConfiguration *config = [[BPKAlertConfiguration alloc] initWithCircleColor:[BPKColor red500]
                                                                             titleText:title
                                                                       descriptionText:description
                                                                  buttonConfigurations:@[primaryConfig, secondaryConfig]
                                                                             hasShadow:YES
                                                                         hasDoneButton:NO
                                                                        doneButtonText:@""
                                                                  faderIsDismissAction:YES
                                                                          isFullScreen:NO];
    return config;
}

@end
