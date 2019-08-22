/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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

NS_ASSUME_NONNULL_BEGIN

@class BPKGradient;
@class BPKFontMapping;
@protocol BPKThemeDefinition

@required
@property(nonatomic, readonly) Class themeContainerClass;
@property(nonatomic, readonly, strong) NSString *themeName;

@property(nonatomic, readonly, strong) UIColor *switchPrimaryColor;
@property(nonatomic, readonly, strong) UIColor *chipPrimaryColor;
@property(nonatomic, readonly, strong) UIColor *spinnerPrimaryColor;
@property(nullable, nonatomic, readonly, strong) BPKFontMapping *fontMapping;

@property(nonatomic, readonly, strong) UIColor *buttonLinkContentColor;
@property(nonatomic, readonly, strong) UIColor *buttonSecondaryContentColor;
@property(nonatomic, readonly, strong) UIColor *buttonSecondaryBackgroundColor;
@property(nonatomic, readonly, strong) UIColor *buttonSecondaryBorderColor;
@property(nonatomic, readonly, strong) UIColor *buttonDestructiveContentColor;
@property(nonatomic, readonly, strong) UIColor *buttonDestructiveBackgroundColor;
@property(nonatomic, readonly, strong) UIColor *buttonDestructiveBorderColor;
@property(nonatomic, readonly, strong) UIColor *buttonPrimaryContentColor;
@property(nonatomic, readonly, strong) UIColor *buttonPrimaryGradientStartColor;
@property(nonatomic, readonly, strong) UIColor *buttonPrimaryGradientEndColor;
@property(nonatomic, readonly, strong) UIColor *buttonFeaturedContentColor;
@property(nonatomic, readonly, strong) UIColor *buttonFeaturedGradientStartColor;
@property(nonatomic, readonly, strong) UIColor *buttonFeaturedGradientEndColor;

@property(nonatomic, readonly, strong) UIColor *gray50;
@property(nonatomic, readonly, strong) UIColor *gray100;
@property(nonatomic, readonly, strong) UIColor *gray300;
@property(nonatomic, readonly, strong) UIColor *gray500;
@property(nonatomic, readonly, strong) UIColor *gray700;
@property(nonatomic, readonly, strong) UIColor *gray900;

@property(nonatomic, readonly, strong) UIColor *systemRed;
@property(nonatomic, readonly, strong) UIColor *systemGreen;
/**
 * The corner radii for all button styles except link. If `nil` the default style of the button
 * is used.
 */
@property(nullable, nonatomic, readonly, strong) NSNumber *buttonCornerRadius;

@property(nonatomic, readonly, strong) UIColor *primaryColor;
@property(nonatomic, readonly, strong) BPKGradient *primaryGradient;

@property(nonatomic, readonly, strong) UIColor *calendarDateSelectedContentColor;
@property(nonatomic, readonly, strong) UIColor *calendarDateSelectedBackgroundColor;

@property(nullable, nonatomic, readonly, strong) UIColor *starFilledColor;

@property(nonatomic, readonly, strong) UIColor *horiontalNavigationSelectedColor;

@end

NS_ASSUME_NONNULL_END
