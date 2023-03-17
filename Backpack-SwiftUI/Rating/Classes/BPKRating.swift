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
import Backpack_Common

public struct BPKRating<Content: View>: View {

    private let value: Float
    private let ratingScale: BPKRatingScale
    private let size: Size
    private let subtitle: String?
    private let showScale: Bool
    @ViewBuilder private var titleViewBuilder: () -> Content

    public var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: BPKSpacing.md.value) {
            HStack(alignment: .lastTextBaseline, spacing: .zero) {
                BPKText(
                    ratingScale.displayedValue(from: value),
                    style: size.fontStyle.ratingValueLabelFontStyle
                ).layoutPriority(4)
                if showScale {
                    BPKText(
                        ratingScale.displayedScale(),
                        style: size.fontStyle.ratingScaleLabelFontStyle
                    ).foregroundColor(.textSecondaryColor)
                        .layoutPriority(3)
                }
            }
            if size == .large {
                VStack(alignment: .leading, spacing: .zero) {
                    titleViewBuilder().layoutPriority(2)
                    subtitleView.layoutPriority(1)
                }
            } else if size == .default {
                HStack(alignment: .center, spacing: BPKSpacing.md.value) {
                    titleViewBuilder().layoutPriority(2)
                    subtitleView.layoutPriority(1)
                }
            }
        }
        .accessibilityElement()
    }

    public init(
        value: Float,
        ratingScale: BPKRatingScale = .zeroToFive,
        size: Size = .default,
        subtitle: String? = nil,
        showScale: Bool = true,
        @ViewBuilder titleViewBuilder: @escaping () -> Content
    ) {
        self.value = value
        self.ratingScale = ratingScale
        self.size = size
        self.subtitle = subtitle
        self.showScale = showScale
        self.titleViewBuilder = titleViewBuilder
    }


    @ViewBuilder
    private var subtitleView: some View {
        if let subtitle = subtitle {
            BPKText(
                subtitle,
                style: size.fontStyle.subtitleLabelFontStyle
            )
            .foregroundColor(.textSecondaryColor)
        } else {
            EmptyView()
        }
    }
}
extension BPKRating where Content == BPKText {
    public init(
        title: String,
        value: Float,
        ratingScale: BPKRatingScale = .zeroToFive,
        size: Size = .default,
        subtitle: String? = nil,
        showScale: Bool = true
    ) {
        self.value = value
        self.ratingScale = ratingScale
        self.size = size
        self.subtitle = subtitle
        self.showScale = showScale

        self.titleViewBuilder = {
            BPKText(title, style: size.fontStyle.titleLabelFontStyle)
        }
    }

}

struct BPKRating_Previews: PreviewProvider {
    static var previews: some View {
        BPKRating(
            title: "Excellent",
            value: 4.5,
            size: .large,
            subtitle: "1,532 reviews"
        )
    }
}
