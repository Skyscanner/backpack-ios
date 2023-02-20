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

import SwiftUI

public struct BPKRating: View {

    private let accessibilityLabel: String
    private let value: Float
    private let ratingScale: Scale
    private let size: Size
    private let subtitle: String?
    private let showScale: Bool
    @ViewBuilder private var titleViewBuilder: () -> AnyView

    public var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: BPKSpacing.md.value) {
            HStack(alignment: .lastTextBaseline, spacing: .zero) {
                BPKText(
                    ratingScale.displayedValue(from: value),
                    style: size.fontStyle.ratingValueLabelFontStyle
                ).foregroundColor(.textPrimaryColor)
                if showScale {
                    BPKText(
                        ratingScale.displayedScale(),
                        style: size.fontStyle.ratingScaleLabelFontStyle
                    ).foregroundColor(.textSecondaryColor)
                }
            }
            if size == .large {
                VStack(alignment: .leading, spacing: .zero) {
                    titleViewBuilder()
                    subtitleView()
                }
            } else if size == .default {
                HStack(alignment: .center, spacing: BPKSpacing.md.value) {
                    titleViewBuilder()
                    subtitleView()
                }
            }
        }.accessibilityLabel(accessibilityLabel)
    }

    public init(
        accessibilityLabel: String,
        value: Float,
        ratingScale: Scale = .zeroToFive,
        size: Size = .default,
        subtitle: String? = nil,
        showScale: Bool = true,
        @ViewBuilder titleViewBuilder: @escaping () -> AnyView
    ) {
        self.accessibilityLabel = accessibilityLabel
        self.value = value
        self.ratingScale = ratingScale
        self.size = size
        self.subtitle = subtitle
        self.showScale = showScale
        self.titleViewBuilder = titleViewBuilder
    }

    public init(
        accessibilityLabel: String,
        title: String,
        value: Float,
        ratingScale: Scale = .zeroToFive,
        size: Size = .default,
        subtitle: String? = nil,
        showScale: Bool = true
    ) {
        self.accessibilityLabel = accessibilityLabel
        self.value = value
        self.ratingScale = ratingScale
        self.size = size
        self.subtitle = subtitle
        self.showScale = showScale

        self.titleViewBuilder = {
            AnyView(
                BPKText(title, style: size.fontStyle.titleLabelFontStyle)
                    .foregroundColor(.textPrimaryColor)
            )
        }
    }

    private func subtitleView() -> BPKText? {
        guard let subtitle = subtitle else {
            return nil

        }
        return BPKText(
            subtitle,
            style: size.fontStyle.subtitleLabelFontStyle
        ).foregroundColor(.textSecondaryColor)
    }
}

struct BPKRating_Previews: PreviewProvider {
    static var previews: some View {
        BPKRating(
            accessibilityLabel: "Rated Excellent, 4.5 out of 5, Based on 1,532 reviews",
            title: "Excellent",
            value: 4.5,
            size: .large,
            subtitle: "1,532 reviews"
        )
    }
}
