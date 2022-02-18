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
#import "BPKButtonAppearanceSets.h"

#import <Backpack/Color.h>
#import <Backpack/DarkMode.h>
#import "UIColor+BPKButton.h"
NS_ASSUME_NONNULL_BEGIN

@implementation BPKButtonAppearanceSets

+(BPKButtonAppearanceSet *)primary {
    static dispatch_once_t onceToken;
    static BPKButtonAppearanceSet *_primarySet = nil;
    dispatch_once(&onceToken, ^{
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:BPKColor.monteverde gradientEndColor:BPKColor.monteverde foregroundColor:BPKColor.white];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.loadingBackgroundColor gradientEndColor:self.loadingBackgroundColor foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.disabledBackgroundColor gradientEndColor:self.disabledBackgroundColor foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.highlightedMonteverde gradientEndColor:self.highlightedMonteverde foregroundColor:self.highlightedWhite];

        _primarySet = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:regularAppearance loadingAppearance:loadingAppearance disabledAppearance:disabledAppearance highlightedAppearance:highlightedAppearance];
    });

    return _primarySet;
}

+(BPKButtonAppearanceSet *)featured {
    static dispatch_once_t onceToken;
    static BPKButtonAppearanceSet *_featuredSet = nil;
    dispatch_once(&onceToken, ^{
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:BPKColor.skyBlue gradientEndColor:BPKColor.skyBlue foregroundColor:BPKColor.white];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.loadingBackgroundColor gradientEndColor:self.loadingBackgroundColor foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.disabledBackgroundColor gradientEndColor:self.disabledBackgroundColor foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.highlightedSkyBlue gradientEndColor:self.highlightedSkyBlue foregroundColor:self.highlightedWhite];

        _featuredSet = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:regularAppearance loadingAppearance:loadingAppearance disabledAppearance:disabledAppearance highlightedAppearance:highlightedAppearance];
    });

    return _featuredSet;
}

+(BPKButtonAppearanceSet *)secondary {
    static dispatch_once_t onceToken;
    static BPKButtonAppearanceSet *_secondarySet = nil;
    dispatch_once(&onceToken, ^{
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:self.boxyBorderColor gradientStartColor:self.boxyBackgroundColor gradientEndColor:self.boxyBackgroundColor foregroundColor:BPKColor.primaryColor];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.loadingBackgroundColor gradientEndColor:self.loadingBackgroundColor foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.disabledBackgroundColor gradientEndColor:self.disabledBackgroundColor foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:self.secondaryBorderColorHighlighted gradientStartColor:self.boxyBackgroundColorHighlighted gradientEndColor:self.boxyBackgroundColorHighlighted foregroundColor:BPKColor.primaryColor];

        _secondarySet = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:regularAppearance loadingAppearance:loadingAppearance disabledAppearance:disabledAppearance highlightedAppearance:highlightedAppearance];
    });

    return _secondarySet;
}

+(BPKButtonAppearanceSet *)destructive {
    static dispatch_once_t onceToken;
    static BPKButtonAppearanceSet *_destructiveSet = nil;
    dispatch_once(&onceToken, ^{
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:self.boxyBorderColor gradientStartColor:self.boxyBackgroundColor gradientEndColor:self.boxyBackgroundColor foregroundColor:BPKColor.panjin];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.loadingBackgroundColor gradientEndColor:self.loadingBackgroundColor foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:self.disabledBackgroundColor gradientEndColor:self.disabledBackgroundColor foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:self.destructiveBorderColorHighlighted gradientStartColor:self.boxyBackgroundColorHighlighted gradientEndColor:self.boxyBackgroundColorHighlighted foregroundColor:BPKColor.panjin];

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
        BPKButtonAppearance *regularAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:BPKColor.clear gradientEndColor:BPKColor.clear foregroundColor:BPKColor.primaryColor];
        BPKButtonAppearance *loadingAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:BPKColor.clear gradientEndColor:BPKColor.clear foregroundColor:self.loadingContentColor];
        BPKButtonAppearance *disabledAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:BPKColor.clear gradientEndColor:BPKColor.clear foregroundColor:self.disabledContentColor];
        BPKButtonAppearance *highlightedAppearance = [[BPKButtonAppearance alloc] initWithBorderColor:nil gradientStartColor:BPKColor.clear gradientEndColor:BPKColor.clear foregroundColor:[UIColor reduceOpacityOfColor:BPKColor.primaryColor]];

        _linkSet = [[BPKButtonAppearanceSet alloc] initWithRegularAppearance:regularAppearance loadingAppearance:loadingAppearance disabledAppearance:disabledAppearance highlightedAppearance:highlightedAppearance];
    });

    return _linkSet;
}

+ (UIColor *)highlightedWhite {
    return [UIColor dimColor:BPKColor.white];
}

+ (UIColor *)highlightedOutlineBorder {
    return [BPKColor dynamicColorWithLightVariant:[UIColor reduceOpacityOfColor:BPKColor.white] darkVariant:BPKColor.white];
}

+ (UIColor *)highlightedOutlineBackground {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.clear darkVariant:BPKColor.blackTint02];
}

+ (UIColor *)highlightedSkyBlue {
    return [UIColor dimColor:BPKColor.skyBlue];
}

+ (UIColor *)highlightedMonteverde {
    return [UIColor dimColor:BPKColor.monteverde];
}

+ (UIColor *)loadingBackgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint06 darkVariant:BPKColor.blackTint02];
}

+ (UIColor *)loadingContentColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint02 darkVariant:BPKColor.blackTint06];
}

+ (UIColor *)disabledBackgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint06 darkVariant:BPKColor.blackTint02];
}

+ (UIColor *)disabledContentColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint04 darkVariant:BPKColor.blackTint06];
}

+ (UIColor *)boxyBackgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.blackTint02];
}

+ (UIColor *)boxyBackgroundColorHighlighted {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.blackTint01];
}

+ (UIColor *)boxyBorderColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint05 darkVariant:BPKColor.skyGrayTint02];
}

+ (UIColor *)secondaryBorderColorHighlighted {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.primaryColor darkVariant:BPKColor.skyGrayTint02];
}

+ (UIColor *)destructiveBorderColorHighlighted {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.panjin darkVariant:BPKColor.skyGrayTint02];
}

@end

NS_ASSUME_NONNULL_END
