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

internal extension BPKSaveCardButton {
    
    struct Icons {
        let smallIcon: BPKSmallIconName
        let smallIconHighlighted: BPKSmallIconName
        let defaultIcon: BPKLargeIconName
        let defaultIconHighlighted: BPKLargeIconName
    }
    
    static let uncheckedIcons = Icons(
        smallIcon: .heartOutline,
        smallIconHighlighted: .heart,
        defaultIcon: .heartOutline,
        defaultIconHighlighted: .heart
    )
    
    static let checkedIcons = Icons(
        smallIcon: .heart,
        smallIconHighlighted: .heart,
        defaultIcon: .heart,
        defaultIconHighlighted: .heart
    )
    
    struct AppearanceSet {
        let normal: Colors
        let highlighted: Colors
    }
    
    struct Colors {
        let iconColor: UIColor
        let iconColorChecked: UIColor
    }
    
    static let defaultAppearanceSet = AppearanceSet(
        normal: Colors(
            iconColor: BPKColor.textPrimaryColor,
            iconColorChecked: BPKColor.coreAccentColor
        ),
        highlighted: Colors(
            iconColor: BPKColor.textPrimaryColor,
            iconColorChecked: BPKColor.coreAccentColor
        )
    )
    
    static let containedAppearanceSet = AppearanceSet(
        normal: Colors(
            iconColor: BPKColor.textPrimaryColor,
            iconColorChecked: BPKColor.coreAccentColor
        ),
        highlighted: Colors(
            iconColor: BPKColor.textPrimaryColor,
            iconColorChecked: BPKColor.coreAccentColor
        )
    )
    
    static let onDarkAppearanceSet = AppearanceSet(
        normal: Colors(
            iconColor: BPKColor.textOnDarkColor,
            iconColorChecked: BPKColor.textOnDarkColor
        ),
        highlighted: Colors(
            iconColor: BPKColor.textOnDarkColor,
            iconColorChecked: BPKColor.textOnDarkColor
        )
    )
    
    static func appearance(from style: BPKCardButtonStyle) -> AppearanceSet {
        switch style {
        case .`default`: return defaultAppearanceSet
        case .onDark: return onDarkAppearanceSet
        case .contained: return containedAppearanceSet
        }
    }
}
