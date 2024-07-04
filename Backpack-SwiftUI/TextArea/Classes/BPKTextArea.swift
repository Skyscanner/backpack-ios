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
import UIKit

public struct BPKTextArea: View {
    
    private enum TextEditorConstants {
        static let verticalPadding: BPKSpacing = .md
        static let horizontalPadding: CGFloat = 12
    }
    
    private enum PlaceholderConstants {
        static let verticalPadding: BPKSpacing = .base
        static let horizontalPadding: BPKSpacing = .base
    }
    
    private enum BorderConstants {
        static let cornerRadius: BPKCornerRadius = .xs
        static let lineWidth: CGFloat = 1
    }
    
    @Environment(\.colorScheme) var colorScheme
    @Binding private var value: String
    private let placeholder: String?
    private var accessibilityLabelText: String {
        if let placeholder = placeholder, value.isEmpty {
            return placeholder
        }
        return value
    }
    
    /// Creates a `BPKTextArea`.
    ///
    /// - Parameters:
    ///   - text: The text to display in the text field.
    ///   - placeholder: The placeholder text to display when the text field is empty.
    ///   - onValueChange: Callback
    public init(
        _ value: Binding<String>,
        placeholder: String? = nil
    ) {
        self._value = value
        self.placeholder = placeholder
        
        if #unavailable(iOS 16.0) {
            // Temp solution for BPKTextArea background colour in dark mode for iOS 15 or below
            UITextView.appearance().backgroundColor = BPKColor.surfaceDefaultColor.value
        }
    }
    
    private var threeLineHeight: CGFloat {
        let font = BPKFontStyle.bodyDefault
        return font.lineHeight * 3
    }
    
    private var frameHeight: CGFloat {
        threeLineHeight + (PlaceholderConstants.verticalPadding.value * 2)
    }
    
    @ViewBuilder
    var textEditorContent: some View {
        if #available(iOS 16.0, *) {
            TextEditor(text: $value)
                .font(style: .bodyDefault)
                .scrollContentBackground(.hidden)
        } else {
            TextEditor(text: $value)
                .font(style: .bodyDefault)
        }
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Text editor
            textEditorContent
                .foregroundColor(.textPrimaryColor)
                .padding(.vertical, TextEditorConstants.verticalPadding)
                .padding(.horizontal, TextEditorConstants.horizontalPadding)
            
            // Placeholder
            if let unwrappedPlaceholder = placeholder {
                BPKText(unwrappedPlaceholder, style: .bodyDefault)
                    .foregroundColor(.textSecondaryColor)
                    .allowsHitTesting(false)
                    .padding(.vertical, PlaceholderConstants.verticalPadding)
                    .padding(.horizontal, PlaceholderConstants.horizontalPadding)
                    .opacity(value.isEmpty ? 1 : 0)
            }
            
            // Border
            RoundedRectangle(cornerRadius: BorderConstants.cornerRadius)
                .strokeBorder(.lineColor, lineWidth: BorderConstants.lineWidth)
        }
        .background(.surfaceDefaultColor)
        .clipShape(
            RoundedRectangle(cornerRadius: BorderConstants.cornerRadius)
        )
        .frame(minHeight: frameHeight)
        .accessibilityLabel(accessibilityLabelText)
    }
    
}

fileprivate extension TextEditor {
    func font(style: BPKFontStyle) -> some View {
        self.font(style.font)
    }
}

struct BPKTextArea_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        BPKTextArea($text, placeholder: "Enter your text")
            .frame(height: 100)
            .padding()
    }
}
