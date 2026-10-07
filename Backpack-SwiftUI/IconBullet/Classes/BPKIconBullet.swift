/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2026 Skyscanner Ltd
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

import SwiftUI
import Backpack_Common

public struct BPKIconBullet: View {
    private let icon: BPKIcon
    private var style: BPKIconBullet.Style = .loyalty
    private var size: BPKIconBullet.Size = .small
    
    @ScaledMetric private var scaledSmallDimension: CGFloat = 8
    @ScaledMetric private var scaledMediumDimension: CGFloat = 16
    @ScaledMetric private var scaledLargeDimension: CGFloat = 24

    public init(icon: BPKIcon) {
        self.icon = icon
    }

    /// The size of the icon's content box, i.e. the icon's rendered
    /// (visible) size, before the surrounding padding is applied.
    ///
    /// Together with `size.padding`, this determines the total circle
    /// diameter: `.small` => 8 + 2x4 = 16pt, `.medium` => 16 + 2x8 = 32pt,
    /// `.large` => 24 + 2x8 = 40pt, matching the design spec.
    private var dimension: CGFloat {
        let smallDimension: CGFloat = 8
        let mediumDimension: CGFloat = 16
        let largeDimension: CGFloat = 24

        switch size {
        case .small:
            return BPKFont.enableDynamicType ? scaledSmallDimension : smallDimension
        case .medium:
            return BPKFont.enableDynamicType ? scaledMediumDimension : mediumDimension
        case .large:
            return BPKFont.enableDynamicType ? scaledLargeDimension : largeDimension
        }
    }

    public var body: some View {
        HStack {
            BPKIconView(icon, size: size.iconSize)
                .foregroundColor(style.iconColor)
                .scaleEffect(size.iconScale)
        }
        .frame(width: dimension, height: dimension)
        .padding(size.padding)
        .background(style.backgroundColor)
        .clipShape(.circle)
    }
    
    /// Sets the style of the icon bullet
    ///
    /// - Parameter style: The `BPKIconBullet.Style` to change the appearance
    ///   view.
    ///
    /// - Returns: A BPKIconBullet that uses the style you supply.
    public func iconBulletStyle(_ style: BPKIconBullet.Style) -> BPKIconBullet {
        var result = self
        result.style = style
        return result
    }
    
    /// Sets the size of the icon bullet
    ///
    /// - Parameter size: The `BPKIconBullet.Size` to change the size of the
    ///   view.
    ///
    /// - Returns: A BPKIconBullet that uses the size you supply.
    public func iconBulletSize(_ size: BPKIconBullet.Size) -> BPKIconBullet {
        var result = self
        result.size = size
        return result
    }
}
