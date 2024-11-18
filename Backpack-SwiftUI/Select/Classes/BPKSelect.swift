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
    let pickerState: BPKSelect.State

    func body(content: Content) -> some View {
        Menu {
            content
        } label: {
            HStack {
                BPKText(labelText)
                    .foregroundColor(pickerState.textColor)
                Spacer(minLength: .sm)
                BPKIconView(.arrowDown)
                    .foregroundColor(pickerState.textColor)
            }
        }
        .padding(.horizontal, .base)
        .frame(minHeight: 48)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .md))
        .disabled(pickerState.isDisabled)
        .outline(pickerState.borderColor, cornerRadius: .md)
    }
}

extension View {
    func bpkPickerStyle(_ pickerStlye: CustomPickerStyle) -> some View {
        self.modifier(pickerStlye)
    }
}

public struct BPKSelect: View {
    @Environment(\.bpkFieldSetState) var fieldSetState
    @Binding private var selectedIndex: Int?

    private let options: [String]
    private let placeholder: String
    private var state: State = .default
    private var resolvedState: State {
        switch fieldSetState {
        case .default:
            return .default
        case .error:
            return .error
        default:
            return state
        }
    }
    
    var labelText: String {
        // If nil or invalid value is passed in by consumer we display the placeholder
        guard let selectedIndex, options.indices.contains(selectedIndex) else {
            return placeholder
        }
        return options[selectedIndex]
    }
    
    public init(
        placeholder: String,
        options: [String],
        selectedIndex: Binding<Int?>
    ) {
        self.placeholder = placeholder
        self.options = options
        _selectedIndex = selectedIndex
    }
    
    public var body: some View {
        Picker(placeholder, selection: $selectedIndex) {
            ForEach(0..<options.count, id: \.self) { index in
                Text(options[index])
                    .tag(Optional(index))
            }
        }
        .bpkPickerStyle(
            CustomPickerStyle(
                labelText: labelText,
                pickerState: resolvedState
            )
        )
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
        selectedIndex: .constant(0))
        .inputState(.disabled)
    }
    
    static var error: BPKSelect {
    BPKSelect(
        placeholder: "Error",
        options: badChoices,
        selectedIndex: .constant(0))
        .inputState(.error)
    }
    
    static var goodChoicesNoSelection: BPKSelect {
        BPKSelect(
            placeholder: "Breakfast Choices",
            options: goodChoices,
            selectedIndex: .constant(nil))
    }
    
    static var goodChoicesIndexSelection: BPKSelect {
        BPKSelect(
            placeholder: "Breakfast Choices",
            options: goodChoices,
            selectedIndex: .constant(1))
    }
    
    static var goodChoicesOutOfBoundsSelection: BPKSelect {
        BPKSelect(
            placeholder: "Breakfast Choices",
            options: goodChoices,
            selectedIndex: .constant(99))
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
