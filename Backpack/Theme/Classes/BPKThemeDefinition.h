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
@protocol BPKThemeDefinition

@required
@property(nonatomic, readonly) Class themeContainerClass;
@property(nonatomic, readonly, strong) NSString *themeName;

@property(nullable, nonatomic, readonly, strong) UIColor *switchPrimaryColor;
@property(nullable, nonatomic, readonly, strong) UIColor *chipPrimaryColor;
@property(nullable, nonatomic, readonly, strong) UIColor *spinnerPrimaryColor;

@property(nullable, nonatomic, readonly, strong) UIColor *buttonLinkContentColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonSecondaryContentColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonSecondaryBackgroundColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonSecondaryBorderColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonDestructiveContentColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonDestructiveBackgroundColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonDestructiveBorderColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonPrimaryContentColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonPrimaryGradientStartColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonPrimaryGradientEndColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonFeaturedContentColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonFeaturedGradientStartColor;
@property(nullable, nonatomic, readonly, strong) UIColor *buttonFeaturedGradientEndColor;

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
@property(nullable, nonatomic, readonly, strong) BPKGradient *primaryGradient;

@property(nullable, nonatomic, readonly, strong) UIColor *linkPrimaryColor;

@property(nullable, nonatomic, readonly, strong) UIColor *progressBarPrimaryColor;

@property(nullable, nonatomic, readonly, strong) UIColor *calendarDateSelectedContentColor;
@property(nullable, nonatomic, readonly, strong) UIColor *calendarDateSelectedBackgroundColor;

@property(nullable, nonatomic, readonly, strong) UIColor *starFilledColor;

@property(nullable, nonatomic, readonly, strong) UIColor *horiontalNavigationSelectedColor;

@property(nullable, nonatomic, readonly, strong) UIColor *ratingLowColor;
@property(nullable, nonatomic, readonly, strong) UIColor *ratingMediumColor;
@property(nullable, nonatomic, readonly, strong) UIColor *ratingHighColor;

@end

NS_ASSUME_NONNULL_END
