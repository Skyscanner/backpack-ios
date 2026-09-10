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

/// BPKProgressBar against the stock SwiftUI linear ProgressView, the stock one tinted with Core / Accent.
enum ProgressBarComparison: NativeComparison {
    case small
    case large
    case stepped

    var label: String {
        switch self {
        case .small: return "Progress bar, small"
        case .large: return "Progress bar, large"
        case .stepped: return "Progress bar, stepped"
        }
    }

    var difference: String {
        switch self {
        case .small, .large:
            return "Same fill from Core / Accent. Backpack draws a Surface / Highlight track at its own height "
                + "(\(Int(size.height.value))pt); the stock bar keeps the platform track and 4pt height."
        case .stepped:
            return "Same fill from Core / Accent. Backpack adds Surface / Default step dividers; "
                + "the stock bar has no steps."
        }
    }

    private var size: BPKProgressBar.Size {
        self == .small ? .small : .large
    }

    var bpkSwatches: [Swatch] {
        var swatches: [Swatch] = [
            .token("Track", "Surface / Highlight", .surfaceHighlightColor),
            .token("Fill", "Core / Accent", .coreAccentColor)
        ]
        if self == .stepped {
            swatches.append(.token("Divider", "Surface / Default", .surfaceDefaultColor))
        }
        return swatches
    }

    var nativeSwatches: [Swatch] {
        [
            .platform("Track"),
            .token("Fill", "Core / Accent", .coreAccentColor)
        ]
    }

    var columns: [ComparisonColumns] {
        let value: Float = self == .stepped ? 2 : 1.5
        return [
            ComparisonColumns {
                BPKProgressBar(max: 3, stepped: self == .stepped, size: size, value: value)
            } native: {
                ProgressView(value: value, total: 3)
                    .progressViewStyle(.linear)
                    .tint(Color(BPKColor.coreAccentColor))
            }
        ]
    }
}
