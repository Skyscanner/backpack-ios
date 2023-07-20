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
    let labelText: String
    let textColor: BPKColor
    
    func body(content: Content) -> some View {
        Menu {
            content
        } label: {
            HStack {
                BPKText(labelText)
                    .foregroundColor(textColor)
                Spacer()
                Image(systemName: "triangle.fill")
                    .resizable()
                    .foregroundColor(textColor)
                    .frame(width: 8, height: 5)
                    .rotationEffect(.degrees(180))
            }
            .frame(height: .lg)
        }
        .padding(.md)
    }
}

extension View {
    func customPickerStyle(labelText: String,
                           textColor: BPKColor) -> some View {
        self.modifier(
            CustomPickerStyle(
                labelText: labelText,
                textColor: textColor
            )
        )
    }
}

public struct BPKSelect: View {
    
    @SwiftUI.State private var selectedIndex: Int

    private let options: [String]
    private let title: String
    private var state: State = .default
    private let onSelectionChange: (Int) -> Void
    
    private var indexIdentifiableOptions: [IdentifiableString] {
        options.enumerated().map { (index, element) in
            IdentifiableString(string: element, id: index)
        }
    }
    
    public init(
        placeholder: String,
        options: [String],
        selectedIndex: Int,
        onSelectionChange: @escaping (Int) -> Void
    ) {
        self.options = options
        self.selectedIndex = selectedIndex
        self.title = placeholder
        self.onSelectionChange = onSelectionChange
    }
    
    public var body: some View {
        VStack {
            
            Picker(title, selection: $selectedIndex) {
                ForEach(indexIdentifiableOptions) { t in
                    Text(t.string)
                }
            }
            .customPickerStyle(
                labelText: selectedIndex < options.count ? options[selectedIndex] : "",
                textColor: state.textColor
            )
            .background(.surfaceDefaultColor)
            .clipShape(RoundedRectangle(cornerRadius: .sm))
            .disabled(state.isDisabled)
            .outline(state.borderColor, cornerRadius: .sm)
            .onChange(of: selectedIndex) { tag in
                onSelectionChange(tag)
            }
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
                options: [
                    "Porridge",
                    "Eggs",
                    "Swift UI"
                ],
                selectedIndex: 99) { _ in }
            BPKSelect(
                placeholder: "Empty List",
                options: [],
                selectedIndex: 99) { _ in }
            BPKSelect(
                placeholder: "Disabled Choices",
                options: [
                    "This Picker is Disabled",
                    "You must eat",
                    "Porridge"
                ],
                selectedIndex: 99) { _ in }
                .inputState(.disabled)
            BPKSelect(
                placeholder: "Bad Choices",
                options: [
                    "Eat Metal",
                    "Or Cement ",
                    "Maybe some Java?"
                ],
                selectedIndex: 99) { _ in }.inputState(.error)
            BPKSelect(
                placeholder: "Out Of Bounds",
                options: [
                    "Selected Index Fail"
                ],
                selectedIndex: 99) { _ in }.inputState(.error)
        }
        .padding()
        .background(.canvasContrastColor)
        .outline(.surfaceHighlightColor, cornerRadius: .sm)
    }
}

extension BPKSelect {
    private struct IdentifiableString: Identifiable {
        let string: String
        let id: Int
    }
}
