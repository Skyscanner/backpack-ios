//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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
import Backpack_SwiftUI

struct RatingExampleView: View {
    enum TitleType {
        case stringLabel
        case image
    }

    let titleType: TitleType

    private let sizes = [BPKRating.Size.default, BPKRating.Size.large]
    private let subtitles = ["1,532 reviews", nil]

    var body: some View {
        VStack(alignment: .leading, spacing: BPKSpacing.sm.value) {
            ForEach(sizes, id: \.self) { size in
                ForEach(subtitles, id: \.self) { subtitle in
                    createRating(
                        scale: .zeroToFive,
                        size: size,
                        subtitle: subtitle,
                        showScale: true
                    )
                    createRating(
                        scale: .zeroToTen,
                        size: size,
                        subtitle: subtitle,
                        showScale: true
                    )
                    createRating(
                        scale: .zeroToFive,
                        size: size,
                        subtitle: subtitle,
                        showScale: false
                    )
                }
            }
        }
    }
    private func createRating(
        value: Float = 4.5,
        scale: Backpack_SwiftUI.BPKRating.Scale,
        size: Backpack_SwiftUI.BPKRating.Size,
        subtitle: String?,
        showScale: Bool
    ) -> Backpack_SwiftUI.BPKRating {
        let title = titleType == .stringLabel ? "Excellent" : nil
        let accessibilityLabel = accessibilityLabel(
            value: value,
            title: title,
            scale: scale,
            subtitle: subtitle
        )

        switch titleType {
        case .stringLabel:
            return BPKRating(
                accessibilityLabel: accessibilityLabel,
                title: title ?? "",
                value: value,
                ratingScale: scale,
                size: size,
                subtitle: subtitle,
                showScale: showScale
            )
        case .image:
            return BPKRating(
                accessibilityLabel: accessibilityLabel,
                value: value,
                ratingScale: scale,
                size: size,
                subtitle: subtitle,
                showScale: showScale
            ) {
                AnyView(
                    Image("backpack-logo-horizontal")
                        .resizable()
                        .frame(width: 110, height: 24)
                        .aspectRatio(contentMode: .fit)
                )
            }
        }
    }

    private func accessibilityLabel(
        value: Float,
        title: String? = nil,
        scale: Backpack_SwiftUI.BPKRating.Scale,
        subtitle: String?
    ) -> String {
        var accessibilityLabel = ""

        if let title = title {
            accessibilityLabel += "Rated \(title), "
        }

        let scaleString: String
        switch scale {
        case .zeroToTen:
            scaleString = "10"
        case .zeroToFive:
            scaleString = "5"
        }
        accessibilityLabel += "\(value) out of \(scaleString). "

        if let subtitle = subtitle {
            accessibilityLabel += "Based on \(subtitle)"
        }

        return accessibilityLabel
    }
}

struct RatingExampleView_Previews: PreviewProvider {
    static var previews: some View {
        RatingExampleView(titleType: .stringLabel)
    }
}
