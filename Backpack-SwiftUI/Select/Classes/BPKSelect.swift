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
    
    // The State we bind aginst cannot be optional, or the Picker selection changes are not observed
    // This hack allows the consumer to pass in nil, and we use this to display the placeholder.
    let integerRepresentingNil = -1
    @SwiftUI.State private var selectedIndex: Int

    private let options: [String]
    private let title: String
    private var state: State = .default
    private let onSelectionChange: (Int) -> Void
    
    func labelText(_ index: Int) -> String {
        
        // If nil is passed in by consumer we display the title
        guard index != integerRepresentingNil else {
            return title
        }

        // If an out of bounds integer is passed in by consumer we display the title
        return index < options.count ? options[index] : title
    }
    
    public init(
        placeholder: String,
        options: [String],
        selectedIndex: Int?,
        onSelectionChange: @escaping (Int) -> Void
    ) {
        self.options = options
        if let selectedIndexValue = selectedIndex {
            self.selectedIndex = selectedIndexValue
        } else {
            self.selectedIndex = integerRepresentingNil
        }
        self.title = placeholder
        self.onSelectionChange = onSelectionChange
    }
    
    public var body: some View {
        VStack {
            
            Picker(title, selection: $selectedIndex) {
                ForEach(0..<options.count, id:\.self) { index in
                    Text(options[index])
                }
            }
            .customPickerStyle(
                labelText: labelText(selectedIndex),
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
    static var goodChoices = ["Porridge", "Eggs", "Swift UI"]
    static var disabledChoices = ["This Picker is Disabled", "You must eat", "Porridge"]
    static var badChoices = ["Eat Metal", "Or Cement ", "Maybe some Java?"]
    
    static var disabled: BPKSelect {
    BPKSelect(
        placeholder: "Disabled",
        options: [],
        selectedIndex: 0) { index in print("index: \(index)") }
        .inputState(.disabled)
    }
    
    static var error: BPKSelect {
    BPKSelect(
        placeholder: "Error",
        options: badChoices,
        selectedIndex: 0) { index in print("index: \(index)") }
        .inputState(.error)
    }
    
    static var goodChoicesNoSelection: BPKSelect {
        BPKSelect(
            placeholder: "Breakfast Choices",
            options: goodChoices,
            selectedIndex: nil) { index in print("index: \(index)") }
    }
    
    static var goodChoicesIndexSelection: BPKSelect {
        BPKSelect(
            placeholder: "Breakfast Choices",
            options: goodChoices,
            selectedIndex: 1) { index in print("index: \(index)") }
    }
    
    static var goodChoicesOutOfBoundsSelection: BPKSelect {
        BPKSelect(
            placeholder: "Breakfast Choices",
            options: goodChoices,
            selectedIndex: 99) { index in print("index: \(index)") }
    }
    
    static var previews: some View {
        VStack {
            BPKText("No Selection")
            goodChoicesNoSelection
            
            BPKText("Index Selection")
            goodChoicesIndexSelection
            
            BPKText("Out Of Bounds Selection")
            goodChoicesOutOfBoundsSelection
            
            BPKText("Disabled")
            disabled
            
            BPKText("Error")
            error
        }
        .padding()
        .background(.canvasContrastColor)
        .outline(.surfaceHighlightColor, cornerRadius: .sm)
    }
}
