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

/// BPKSpinner against the stock SwiftUI circular ProgressView, the stock one tinted with the same
/// semantic token and sized with controlSize.
enum SpinnerComparison: NativeComparison {
    case small
    case large
    case extraLarge
    case onDark

    var label: String {
        switch self {
        case .small: return "Spinner, small"
        case .large: return "Spinner, large"
        case .extraLarge: return "Spinner, extra large"
        case .onDark: return "Spinner on a dark surface"
        }
    }

    var difference: String {
        switch self {
        case .small, .large, .extraLarge:
            return "Same colour from Text / Primary. Backpack draws 12 fading capsules at a fixed size "
                + "(\(Int(bpkSize.width.value))pt); the stock spinner is the platform indicator "
                + "at the nearest controlSize."
        case .onDark:
            return "Same colour from Text / On dark on Core / Primary. Backpack draws 12 fading capsules; "
                + "the stock spinner is the platform indicator."
        }
    }

    private var bpkSize: BPKSpinner.Size {
        switch self {
        case .small, .onDark: return .sm
        case .large: return .lg
        case .extraLarge: return .xl
        }
    }

    private var controlSize: ControlSize {
        switch self {
        case .small, .onDark: return .small
        case .large: return .regular
        case .extraLarge: return .large
        }
    }

    private var bpkStyle: BPKSpinner.Style {
        self == .onDark ? .onDarkSurface : .textPrimary
    }

    private var figmaName: String {
        self == .onDark ? "Text / On dark" : "Text / Primary"
    }

    var bpkSwatches: [Swatch] {
        [.token("Fill", figmaName, bpkStyle.foregroundColor)]
    }

    var nativeSwatches: [Swatch] {
        [.token("Fill", figmaName, bpkStyle.foregroundColor)]
    }

    var columns: [ComparisonColumns] {
        [
            ComparisonColumns {
                surface { BPKSpinner(bpkSize, style: bpkStyle) }
            } native: {
                surface {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(controlSize)
                        .tint(Color(bpkStyle.foregroundColor))
                }
            }
        ]
    }

    /// The on-dark pair sits on Core / Primary; the others on the canvas.
    @ViewBuilder
    private func surface<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        if self == .onDark {
            content()
                .padding(.md)
                .background(BPKColor.corePrimaryColor)
        } else {
            content()
        }
    }
}
