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

- (instancetype _Nonnull)initWithCircleColor:(UIColor *)circleColor
                                        icon:(UIImage *)iconImage
                                   titleText:(NSString *)titleText
                             descriptionText:(NSString *)descriptionText
                        buttonConfigurations:(NSArray<BPKAlertButtonConfiguration *> *)buttonConfigurations
                                   hasShadow:(BOOL)hasShadow
                     doneButtonConfiguration:(BPKAlertDoneButtonConfiguration *)doneButtonConfiguration
                          faderConfiguration:(BPKAlertFaderConfiguration *)faderConfiguration
                                isFullScreen:(BOOL)isFullScreen {
    self = [super init];
    if (self) {
        _circleColor = circleColor;
        _iconImage = iconImage;
        _titleText = titleText;
        _descriptionText = descriptionText;
        _buttonConfigurations = buttonConfigurations;
        _hasShadow = hasShadow;
        _faderConfiguration = faderConfiguration;
        _doneButtonConfiguration = doneButtonConfiguration;
        _isFullScreen = isFullScreen;
    }
    return self;
}

@end
