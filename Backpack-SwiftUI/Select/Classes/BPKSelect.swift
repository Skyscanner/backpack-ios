/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

struct CustomPickerStyle: ViewModifier {
    var labelText: String
    var width: CGFloat
    var textColor: BPKColor
    
    func body(content: Content) -> some View {
        Menu {
            content
        } label: {
            HStack {
                if let labelText = labelText {
                    BPKText(
                        labelText
                    )
                    .foregroundColor(textColor)
                    
                    Spacer()
                   
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .foregroundColor(.textPrimaryColor)
                        .frame(width: 8, height: 5)
                        .rotationEffect(.degrees(180))
                }
            }
            .frame(height: .lg)
        }
        .padding(.md)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .sm))
        .frame(maxWidth: width, alignment: .leading)
    }
}

extension View {
    func customPickerStyle(labelText: String,
                           width: CGFloat,
                           textColor: BPKColor) -> some View {
        self.modifier(
            CustomPickerStyle(
                labelText: labelText,
                width: width,
                textColor: textColor
            )
        )
    }
}

public struct BPKSelect: View {
    
    @SwiftUI.State private var selection: String
    private let options: [String]
    private let title: String
    private var state: State = .default
    
    public init(
        placeholder: String,
        options: [String]
    ) {
        self.options = options
        if let selectedText = options.first {
            self.selection = selectedText
        } else {
            self.selection = ""
        }
        self.title = placeholder
    }
    
    public var body: some View {
        VStack {
            
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { t in
                    Text(t)
                }
            }
            .disabled(state.isDisabled)
            .customPickerStyle(
                labelText: selection,
                width: .infinity,
                textColor: state.textColor
            )
            .outline(state.borderColor, cornerRadius: .sm)
        }
    }
    
    public func inputState(_ state: State) -> BPKSelect {
        var result = self
        result.state = state
        return result
    }
}

struct BPKSelect_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKText("Breakfast Choices", style: .heading1)
            BPKSelect(
                placeholder: "Breakfast Choices",
                options: ["Porridge",
                          "Eggs",
                          "Swift UI"]
            )
            BPKSelect(
                placeholder: "Empty List",
                options: []
            )
            BPKSelect(
                placeholder: "Disabled Choices",
                options: ["This Picker is Disabled",
                          "You must eat",
                          "Porridge"]
            ).inputState(.disabled)
            BPKSelect(
                placeholder: "Bad Choices",
                options: ["Eat Metal",
                          "Or Cement ",
                          "Maybe some Java?"]
            ).inputState(.error)
        }
        .padding()
        .background(.canvasContrastColor)
        .outline(.surfaceHighlightColor, cornerRadius: .sm)
    }
}
