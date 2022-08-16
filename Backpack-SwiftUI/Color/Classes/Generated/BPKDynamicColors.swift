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

import UIKit

public func dynamicColor(lightVariant: UIColor, darkVariant: UIColor) -> UIColor {
    UIColor { $0.userInterfaceStyle == .dark ? darkVariant : lightVariant }
}

/// Backpack Dynamic Colors
public extension BPKColor {
    func darkVariant(_ darkVariant: BPKColor) -> BPKColor {
        BPKColor(value: dynamicColor(lightVariant: value, darkVariant: darkVariant.value))
    }

    /// The `backgroundAlternativeColor` dynamic color from the Backpack palette.
    static let backgroundAlternativeColor = skyGrayTint07.darkVariant(black)

    /// The `backgroundAlternativeSecondaryColor` dynamic color from the Backpack palette.
    static let backgroundAlternativeSecondaryColor = white.darkVariant(blackTint01)

    /// The `backgroundColor` dynamic color from the Backpack palette.
    static let backgroundColor = white.darkVariant(black)

    /// The `backgroundElevation01Color` dynamic color from the Backpack palette.
    static let backgroundElevation01Color = white.darkVariant(blackTint01)

    /// The `backgroundElevation02Color` dynamic color from the Backpack palette.
    static let backgroundElevation02Color = white.darkVariant(blackTint02)

    /// The `backgroundElevation03Color` dynamic color from the Backpack palette.
    static let backgroundElevation03Color = white.darkVariant(blackTint03)

    /// The `backgroundSecondaryColor` dynamic color from the Backpack palette.
    static let backgroundSecondaryColor = skyGrayTint07.darkVariant(blackTint01)

    /// The `backgroundTertiaryColor` dynamic color from the Backpack palette.
    static let backgroundTertiaryColor = white.darkVariant(blackTint02)

    /// The `canvasContrastColor` dynamic color from the Backpack palette.
    static let canvasContrastColor = grey10.darkVariant(nightGrey20)

    /// The `canvasColor` dynamic color from the Backpack palette.
    static let canvasColor = white.darkVariant(nightGrey10)

    /// The `coreAccentColor` dynamic color from the Backpack palette.
    static let coreAccentColor = skyBlue.darkVariant(nightBlue)

    /// The `coreEcoColor` dynamic color from the Backpack palette.
    static let coreEcoColor = ecoGreen.darkVariant(ecoGreen)

    /// The `corePrimaryColor` dynamic color from the Backpack palette.
    static let corePrimaryColor = darkSky.darkVariant(nightSky)

    /// The `lineColor` dynamic color from the Backpack palette.
    static let lineColor = skyGrayTint05.darkVariant(nightGrey30)

    /// The `primaryColor` dynamic color from the Backpack palette.
    static let primaryColor = skyBlue.darkVariant(skyBlueTint01)

    /// The `scrimColor` dynamic color from the Backpack palette.
    static let scrimColor = blackAlpha70.darkVariant(blackAlpha70)

    /// The `statusDangerFillColor` dynamic color from the Backpack palette.
    static let statusDangerFillColor = pinkMuted.darkVariant(nightPink)

    /// The `statusDangerSpotColor` dynamic color from the Backpack palette.
    static let statusDangerSpotColor = berry.darkVariant(nightBerry)

    /// The `statusSuccessFillColor` dynamic color from the Backpack palette.
    static let statusSuccessFillColor = greenMuted.darkVariant(nightGreenFill)

    /// The `statusSuccessSpotColor` dynamic color from the Backpack palette.
    static let statusSuccessSpotColor = greenSpot.darkVariant(nightGreenSpot)

    /// The `statusWarningFillColor` dynamic color from the Backpack palette.
    static let statusWarningFillColor = yellowMuted.darkVariant(nightYellowFill)

    /// The `statusWarningSpotColor` dynamic color from the Backpack palette.
    static let statusWarningSpotColor = amberSpot.darkVariant(nightYellowSpot)

    /// The `surfaceContrastColor` dynamic color from the Backpack palette.
    static let surfaceContrastColor = darkSky.darkVariant(nightGrey20)

    /// The `surfaceDefaultColor` dynamic color from the Backpack palette.
    static let surfaceDefaultColor = white.darkVariant(nightGrey20)

    /// The `surfaceElevatedColor` dynamic color from the Backpack palette.
    static let surfaceElevatedColor = white.darkVariant(nightGrey25)

    /// The `surfaceHighlightColor` dynamic color from the Backpack palette.
    static let surfaceHighlightColor = grey20.darkVariant(nightGrey25)

    /// The `textDisabledColor` dynamic color from the Backpack palette.
    static let textDisabledColor = blackAlpha20.darkVariant(whiteAlpha20)

    /// The `textErrorColor` dynamic color from the Backpack palette.
    static let textErrorColor = berry.darkVariant(nightBerry)

    /// The `textLinkColor` dynamic color from the Backpack palette.
    static let textLinkColor = skyBlue.darkVariant(nightBlue)

    /// The `textPrimaryColor` dynamic color from the Backpack palette.
    static let textPrimaryColor = skyGray.darkVariant(white)

    /// The `textPrimaryOnContrastColor` dynamic color from the Backpack palette.
    static let textPrimaryOnContrastColor = white.darkVariant(white)

    /// The `textQuaternaryColor` dynamic color from the Backpack palette.
    static let textQuaternaryColor = skyGrayTint03.darkVariant(blackTint06)

    /// The `textSecondaryColor` dynamic color from the Backpack palette.
    static let textSecondaryColor = skyGrayTint02.darkVariant(skyGrayTint04)

    /// The `textSecondaryOnContrastColor` dynamic color from the Backpack palette.
    static let textSecondaryOnContrastColor = whiteAlpha80.darkVariant(nightGrey40)

    /// The `textTertiaryColor` dynamic color from the Backpack palette.
    static let textTertiaryColor = skyGrayTint03.darkVariant(blackTint06)
}
