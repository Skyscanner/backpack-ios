//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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
@testable import Backpack_SwiftUI

/// BPKPanel against the stock SwiftUI GroupBox, the stock one filled with Surface / Default through
/// backgroundStyle. GroupBox has no border and a fixed radius, so those stay with the platform.
enum PanelComparison: NativeComparison {
    case padded
    case flush

    private static let copy = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        + "Sed sit amet sagittis tellus, quis pharetra massa."

    var label: String {
        switch self {
        case .padded: return "Panel"
        case .flush: return "Panel without padding"
        }
    }

    var difference: String {
        switch self {
        case .padded:
            return "Same fill from Surface / Default. Backpack adds a 1pt Line border and the md corner radius; "
                + "GroupBox has no border and keeps the platform radius and padding."
        case .flush:
            return "Backpack can drop its padding so content runs to the border. "
                + "GroupBox always pads its content from the platform."
        }
    }

    var bpkSwatches: [Swatch] {
        [
            .token("Fill", "Surface / Default", .surfaceDefaultColor),
            .token("Border", "Line", .lineColor),
            .token("Text", "Text / Primary", .textPrimaryColor)
        ]
    }

    var nativeSwatches: [Swatch] {
        [
            .token("Fill", "Surface / Default", .surfaceDefaultColor),
            .platform("Border", note: "none"),
            .token("Text", "Text / Primary", .textPrimaryColor)
        ]
    }

    var columns: [ComparisonColumns] {
        [
            ComparisonColumns {
                BPKPanel(padding: self == .padded) {
                    BPKText(Self.copy)
                        .lineLimit(nil)
                }
            } native: {
                GroupBox {
                    Text(Self.copy)
                        .font(BPKFontStyle.bodyDefault.font)
                        .foregroundColor(BPKColor.textPrimaryColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .backgroundStyle(Color(BPKColor.surfaceDefaultColor))
            }
        ]
    }
}
