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

    private static let onDarkAppearance = AppearanceSet(
        normal: Colors(
            background: BPKColor.chipOnDarkNormalBackgroundColor,
            content: BPKColor.textOnDarkColor),
        selected: Colors(
            background: BPKColor.chipOnDarkOnBackgroundColor,
            content: BPKColor.textPrimaryColor),
        disabled: Colors(
            background: BPKColor.chipDisabledBackgroundColor,
            content: BPKColor.textDisabledColor
        )
    )

    private static let defaultAppearance = AppearanceSet(
        normal: Colors(
            background: BPKColor.chipDefaultNormalBackgroundColor,
            content: BPKColor.textPrimaryColor
        ),
        selected: Colors(
            background: BPKColor.chipDefaultOnBackgroundColor,
            content: BPKColor.textOnDarkColor
        ),
        disabled: Colors(
            background: BPKColor.chipDisabledBackgroundColor,
            content: BPKColor.textDisabledColor
        )
    )

    static func appearance(fromStyle style: BPKChipStyle) -> AppearanceSet {
        switch style {
        case .`default`: return defaultAppearance
        case .onDark: return onDarkAppearance
        }
    }
}
