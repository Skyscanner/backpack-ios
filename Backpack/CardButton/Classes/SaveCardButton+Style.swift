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
        let smallIconSelected: BPKSmallIconName
        let defaultIcon: BPKLargeIconName
        let defaultIconHighlighted: BPKLargeIconName
        let defaultIconSelected: BPKLargeIconName
    }

    static let iconSet = Icons(
        smallIcon: .heartOutline,
        smallIconHighlighted: .heart,
        smallIconSelected: .heart,
        defaultIcon: .heartOutline,
        defaultIconHighlighted: .heart,
        defaultIconSelected: .heart
    )

    struct ColorSet {
        let normal: UIColor
        let highlighted: UIColor
        let selected: UIColor
    }

    static let defaultColorSet = ColorSet(
        normal: BPKColor.textPrimaryColor,
        highlighted: BPKColor.textPrimaryColor,
        selected: BPKColor.coreAccentColor
    )

    static let containedColorSet = ColorSet(
        normal: BPKColor.textPrimaryColor,
        highlighted: BPKColor.textPrimaryColor,
        selected: BPKColor.coreAccentColor
    )

    static let onDarkColorSet = ColorSet(
        normal: BPKColor.textOnDarkColor,
        highlighted: BPKColor.textOnDarkColor,
        selected: BPKColor.textOnDarkColor
    )

    static func colorSet(from style: BPKCardButtonStyle) -> ColorSet {
        switch style {
        case .`default`: return defaultColorSet
        case .onDark: return onDarkColorSet
        case .contained: return containedColorSet
        }
    }
}
