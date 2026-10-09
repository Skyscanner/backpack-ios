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

/// BPKFieldSet around a BPKTextField against the closest stock composition: a Text label, a TextField
/// in the rounded border style and a Text footer in a VStack. LabeledContent puts the label beside the
/// field, not above it, so it is not the match; a Form section footer needs a Form.
enum FieldSetComparison: NativeComparison {
    case labelled
    case error
    case unlabelled

    private static let errorMessage = "Enter a valid value"

    var label: String {
        switch self {
        case .labelled: return "Field set with label and description"
        case .error: return "Field set in error"
        case .unlabelled: return "Field set with description only"
        }
    }

    var difference: String {
        switch self {
        case .labelled:
            return "Same label, description and text colours from Backpack tokens. Backpack borders the field "
                + "with Line at the sm radius; the stock rounded border field keeps the platform border."
        case .error:
            return "Backpack turns the label and message Text / Error and the field border Status / Danger spot "
                + "with an icon. The stock field has no error state; only the message colour can match."
        case .unlabelled:
            return "Same description colour from Text / Secondary. Backpack borders the field with Line; "
                + "the stock rounded border field keeps the platform border."
        }
    }

    private var fieldSetState: BPKFieldSetState {
        self == .error ? .error(message: Self.errorMessage) : .default
    }

    private var hasLabel: Bool {
        self != .unlabelled
    }

    var bpkSwatches: [Swatch] {
        var swatches: [Swatch] = []
        if hasLabel {
            swatches.append(.token("Label", labelFigmaName, fieldSetState.labelColor))
        }
        swatches.append(.token("Description", "Text / Secondary", fieldSetState.descriptionColor))
        swatches.append(.token("Text", "Text / Primary", .textPrimaryColor))
        if self == .error {
            swatches.append(.token("Field border", "Status / Danger spot", .statusDangerSpotColor))
            swatches.append(.token("Error", "Text / Error", .textErrorColor))
        } else {
            swatches.append(.token("Field border", "Line", .lineColor))
        }
        return swatches
    }

    var nativeSwatches: [Swatch] {
        var swatches: [Swatch] = []
        if hasLabel {
            swatches.append(.token("Label", labelFigmaName, fieldSetState.labelColor))
        }
        swatches.append(.token("Description", "Text / Secondary", .textSecondaryColor))
        swatches.append(.token("Text", "Text / Primary", .textPrimaryColor))
        swatches.append(.platform("Field border"))
        if self == .error {
            swatches.append(.token("Error", "Text / Error", .textErrorColor))
        }
        return swatches
    }

    private var labelFigmaName: String {
        self == .error ? "Text / Error" : "Text / Primary"
    }

    var columns: [ComparisonColumns] {
        [
            ComparisonColumns {
                BPKFieldSet(label: hasLabel ? "Label" : nil, description: "Description") {
                    BPKTextField(placeholder: "Enter text", .constant(""))
                }
                .inputState(fieldSetState)
            } native: {
                nativeFieldSet
            }
        ]
    }

    private var nativeFieldSet: some View {
        VStack(alignment: .leading, spacing: .sm) {
            if hasLabel {
                Text("Label")
                    .font(BPKFontStyle.label2.font)
                    .foregroundColor(fieldSetState.labelColor)
            }
            TextField("Enter text", text: .constant(""))
                .textFieldStyle(.roundedBorder)
                .font(BPKFontStyle.bodyDefault.font)
                .foregroundColor(BPKColor.textPrimaryColor)
                .padding(.bottom, .sm)
            Text("Description")
                .font(BPKFontStyle.caption.font)
                .foregroundColor(BPKColor.textSecondaryColor)
            if self == .error {
                Text(Self.errorMessage)
                    .font(BPKFontStyle.caption.font)
                    .foregroundColor(BPKColor.textErrorColor)
                    .padding(.top, .sm)
            }
        }
    }
}
