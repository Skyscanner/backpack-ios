/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

/*
 * Note that in some places we are having to resolve the correct UIColors from dynamic values ourselves to ensure
 * that we support overriding UIViewController interface styles. if we allow UIKit to resolve them for us,
 * it may do so wrongly.
 * This is because UIKit only sets the UIView's trait collection on a handful of lifecycle methods, and we
 * are using dynamic colours outside of these. If we do not manually resolve colours using self.traitCollection,
 * then UIKit will fall back to using [UITraitCollection currentTraitCollection] which does not reflect the override.
 */

#import "BPKButtonAppearance.h"
#import "BPKButtonAppearanceSet.h"
#import "UIColor+BPKButton.h"

#import <Backpack/Color.h>
#import <Backpack/DarkMode.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKButtonAppearanceSetss

+(BPKButtonAppearanceSet *)primary {
    static dispatch_once_t onceToken;
    static BPKButtonAppearanceSet *_primarySet = nil;
    dispatch_once(&onceToken, ^{
        UIColor *regularBackground = BPKColor.monteverde;
        UIColor *pressedBackground = [UIColor colorWithRed:0.000 green:0.416 blue:0.38 alpha:1];
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:regularBackground gradientEndColor:regularBackground foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black]];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.loadingBackgroundColor gradientEndColor:self.loadingBackgroundColor foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.disabledBackgroundColor gradientEndColor:self.disabledBackgroundColor foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:pressedBackground gradientEndColor:pressedBackground foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black]];

        _primarySet = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:regularAppearance loadingAppearance:loadingAppearance disabledAppearance:disabledAppearance highlightedAppearance:highlightedAppearance];
    });

    return _primarySet;
}

+(BPKButtonAppearanceSet *)featured {
    static dispatch_once_t onceToken;
    static BPKButtonAppearanceSet *_featuredSet = nil;
    dispatch_once(&onceToken, ^{
        UIColor *regularBackground = [BPKColor dynamicColorWithLightVariant:BPKColor.skyBlue darkVariant:BPKColor.skyBlueTint01];
        UIColor *pressedBackground = BPKColor.skyBlueShade01;
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:regularBackground gradientEndColor:regularBackground foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black]];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.loadingBackgroundColor gradientEndColor:self.loadingBackgroundColor foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.disabledBackgroundColor gradientEndColor:self.disabledBackgroundColor foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:pressedBackground gradientEndColor:pressedBackground foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black]];

        _featuredSet = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:regularAppearance loadingAppearance:loadingAppearance disabledAppearance:disabledAppearance highlightedAppearance:highlightedAppearance];
    });

    return _featuredSet;
}

+(BPKButtonAppearanceSet *)secondary {
    static dispatch_once_t onceToken;
    static BPKButtonAppearanceSet *_secondarySet = nil;
    dispatch_once(&onceToken, ^{
        UIColor *regularBackground = self.boxyBackgroundColor;
        UIColor *pressedBackground = self.boxyBackgroundColorHighlighted;
        UIColor *foreground = [BPKColor dynamicColorWithLightVariant:BPKColor.skyBlueShade01 darkVariant:BPKColor.skyBlueTint01];
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:regularBackground gradientEndColor:regularBackground foregroundColor:foreground];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.loadingBackgroundColor gradientEndColor:self.loadingBackgroundColor foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.disabledBackgroundColor gradientEndColor:self.disabledBackgroundColor foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:pressedBackground gradientEndColor:pressedBackground foregroundColor:foreground];

        _secondarySet = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:regularAppearance loadingAppearance:loadingAppearance disabledAppearance:disabledAppearance highlightedAppearance:highlightedAppearance];
    });

    return _secondarySet;
}

+(BPKButtonAppearanceSet *)destructive {
    static dispatch_once_t onceToken;
    static BPKButtonAppearanceSet *_destructiveSet = nil;
    dispatch_once(&onceToken, ^{
        UIColor *regularBackground = self.boxyBackgroundColor;
        UIColor *pressedBackground = [BPKColor dynamicColorWithLightVariant:[UIColor colorWithRed:0.699 green:0.182 blue:0.269 alpha:1]
                                                                darkVariant:[UIColor colorWithRed:0.972 green:0.361 blue:0.465 alpha:1]
        ];
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:regularBackground gradientEndColor:regularBackground foregroundColor:pressedBackground];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.loadingBackgroundColor gradientEndColor:self.loadingBackgroundColor foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.disabledBackgroundColor gradientEndColor:self.disabledBackgroundColor foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:pressedBackground gradientEndColor:pressedBackground foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.black]];

        _destructiveSet = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:regularAppearance loadingAppearance:loadingAppearance disabledAppearance:disabledAppearance highlightedAppearance:highlightedAppearance];
    });

    return _destructiveSet;
}

+(BPKButtonAppearanceSet *)outline {
    static dispatch_once_t onceToken;
    static BPKButtonAppearanceSet *_outlineSet = nil;
    dispatch_once(&onceToken, ^{
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:BPKColor.white gradientStartColor:BPKColor.clear gradientEndColor:BPKColor.clear foregroundColor:BPKColor.white];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.loadingBackgroundColor gradientEndColor:self.loadingBackgroundColor foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.disabledBackgroundColor gradientEndColor:self.disabledBackgroundColor foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:self.highlightedOutlineBorder gradientStartColor:self.highlightedOutlineBackground gradientEndColor:self.highlightedOutlineBackground foregroundColor:BPKColor.white];

        _outlineSet = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:regularAppearance loadingAppearance:loadingAppearance disabledAppearance:disabledAppearance highlightedAppearance:highlightedAppearance];
    });

    return _outlineSet;
}

+(BPKButtonAppearanceSet *)link {
    static dispatch_once_t onceToken;
    static BPKButtonAppearanceSet *_linkSet = nil;
    dispatch_once(&onceToken, ^{
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:BPKColor.clear gradientEndColor:BPKColor.clear foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.skyBlue darkVariant:BPKColor.skyBlueTint01]];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:BPKColor.clear gradientEndColor:BPKColor.clear foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:BPKColor.clear gradientEndColor:BPKColor.clear foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:BPKColor.clear gradientEndColor:BPKColor.clear foregroundColor:[BPKColor dynamicColorWithLightVariant:BPKColor.skyBlueShade01 darkVariant:BPKColor.skyBlue]];

        _linkSet = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:regularAppearance loadingAppearance:loadingAppearance disabledAppearance:disabledAppearance highlightedAppearance:highlightedAppearance];
    });

    return _linkSet;
}

+ (UIColor *)highlightedOutlineBorder {
    return [BPKColor dynamicColorWithLightVariant:[UIColor reduceOpacityOfColor:BPKColor.white] darkVariant:BPKColor.white];
}

+ (UIColor *)highlightedOutlineBackground {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.clear darkVariant:BPKColor.blackTint02];
}

+ (UIColor *)loadingBackgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint06 darkVariant:BPKColor.blackTint01];
}

+ (UIColor *)loadingContentColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint04 darkVariant:BPKColor.blackTint03];
}

+ (UIColor *)disabledBackgroundColor {
    return [self loadingBackgroundColor];
}

+ (UIColor *)disabledContentColor {
    return [self loadingContentColor];
}

+ (UIColor *)boxyBackgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint06 darkVariant:BPKColor.blackTint02];
}

+ (UIColor *)boxyBackgroundColorHighlighted {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint05 darkVariant:BPKColor.blackTint01];
}

@end

NS_ASSUME_NONNULL_END
