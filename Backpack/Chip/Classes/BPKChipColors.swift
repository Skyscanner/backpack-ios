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

struct BPKChipAppearanceSets {
    struct AppearanceSet {
        let normal: Colors
        let selected: Colors
        let disabled: Colors
    }
    
    struct Colors {
        let background: UIColor
        let content: UIColor
    }

    @available(*, deprecated, message: "will be removed when filled are removed")
    static let filledAppearance = AppearanceSet(
        normal: Colors(
            background: BPKColor.dynamicColor(
                withLightVariant: BPKColor.skyGrayTint06,
                darkVariant: BPKColor.blackTint03
            ),
            content: BPKColor.textPrimaryColor
        ),
        selected: Colors(
            background: BPKColor.primaryColor,
            content: BPKColor.dynamicColor(
                withLightVariant: BPKColor.white,
                darkVariant: BPKColor.black
            )
        ),
        disabled: Colors(
            background: BPKColor.dynamicColor(
                withLightVariant: BPKColor.skyGrayTint06,
                darkVariant: BPKColor.blackTint03
            ),
            content: BPKColor.dynamicColor(
                withLightVariant: BPKColor.skyGrayTint04,
                darkVariant: BPKColor.blackTint06
            )
        )
    )

    @available(*, deprecated, message: "will be removed when outline are removed")
    private static let outlineAppearance = AppearanceSet(
        normal: Colors(
            background: BPKColor.dynamicColor(
                withLightVariant: BPKColor.white,
                darkVariant: BPKColor.blackTint03
            ),
            content: BPKColor.textPrimaryColor
        ),
        selected: Colors(
            background: BPKColor.primaryColor,
            content: BPKColor.dynamicColor(
                withLightVariant: BPKColor.white,
                darkVariant: BPKColor.black
            )
        ),
        disabled: Colors(
            background: BPKColor.clear,
            content: BPKColor.dynamicColor(
                withLightVariant: BPKColor.skyGrayTint04,
                darkVariant: BPKColor.blackTint06
            )
        )
    )

    private static let onDarkAppearance = AppearanceSet(
        normal: Colors(
            background: BPKColor.dynamicColor(
                withLightVariant: BPKColor.white,
                darkVariant: BPKColor.backgroundElevation03DarkColor
            ),
            content: BPKColor.textPrimaryColor),
        selected: Colors(
            background: BPKColor.primaryColor,
            content: BPKColor.dynamicColor(
                withLightVariant: BPKColor.white,
                darkVariant: BPKColor.black
            )),
        disabled: Colors(
            background: BPKColor.dynamicColor(
                withLightVariant: BPKColor.skyGrayTint06,
                darkVariant: BPKColor.blackTint03
            ),
            content: BPKColor.dynamicColor(
                withLightVariant: BPKColor.skyGrayTint04,
                darkVariant: BPKColor.blackTint06
            )
        )
    )

    private static let defaultAppearance = AppearanceSet(
        normal: Colors(
            background: BPKColor.dynamicColor(
                withLightVariant: BPKColor.skyGrayTint06,
                darkVariant: BPKColor.blackTint03
            ),
            content: BPKColor.textPrimaryColor
        ),
        selected: Colors(
            background: BPKColor.primaryColor,
            content: BPKColor.dynamicColor(
                withLightVariant: BPKColor.white,
                darkVariant: BPKColor.black
            )
        ),
        disabled: Colors(
            background: BPKColor.dynamicColor(
                withLightVariant: BPKColor.skyGrayTint06,
                darkVariant: BPKColor.blackTint03
            ),
            content: BPKColor.dynamicColor(
                withLightVariant: BPKColor.skyGrayTint04,
                darkVariant: BPKColor.blackTint06
            )
        )
    )

    static func appearance(fromStyle style: BPKChipStyle) -> AppearanceSet {
        switch style {
        case .`default`: return defaultAppearance
        case .onDark: return onDarkAppearance
        case .filled: return filledAppearance
        case .outline: return outlineAppearance
        }
    }
}
