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

/// BPKSlider (single value) against the stock SwiftUI Slider, the stock one tinted with Core / Accent.
enum SliderComparison: NativeComparison {
    case start
    case middle
    case end

    var label: String {
        switch self {
        case .start: return "Slider at the start"
        case .middle: return "Slider at the middle"
        case .end: return "Slider at the end"
        }
    }

    private var value: Float {
        switch self {
        case .start: return 0
        case .middle: return 50
        case .end: return 100
        }
    }

    var difference: String {
        "Same fill and thumb colour from Core / Accent. Backpack draws a Line track and a Core / Accent thumb "
            + "with a shadow; the stock slider keeps its own track and white thumb."
    }

    var bpkSwatches: [Swatch] {
        [
            .token("Track", "Line", .lineColor),
            .token("Fill", "Core / Accent", .coreAccentColor),
            .token("Thumb", "Core / Accent", .coreAccentColor)
        ]
    }

    var nativeSwatches: [Swatch] {
        [
            .platform("Track"),
            .token("Fill", "Core / Accent", .coreAccentColor),
            .platform("Thumb", note: "white")
        ]
    }

    var columns: [ComparisonColumns] {
        [
            ComparisonColumns {
                BPKSlider(value: .constant(value), sliderBounds: 0...100)
            } native: {
                Slider(value: .constant(value), in: 0...100)
                    .tint(Color(BPKColor.coreAccentColor))
            }
        ]
    }
}
