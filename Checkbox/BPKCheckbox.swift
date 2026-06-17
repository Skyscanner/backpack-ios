//
//  SwiftUIView.swift
//  Backpack-SwiftUI
//
//  Created by Kynan Song on 16/06/2026.
//

import SwiftUI

public enum CheckboxState: Equatable {
    case regular
    case error
    case intermediate
}

public struct BPKCheckbox: View {
    @State private var isOn: Bool = false
    
    let text: String
    let textColor: BPKColor
    let selected: Bool
    let onTap: () -> Void
    let state: CheckboxState
    
    private var disabled = false
    
    public init(
        _ text: String,
        textColor: BPKColor = .textPrimaryColor,
        selected: Bool = false,
        onTap: @escaping () -> Void,
        state: CheckboxState = .regular
    ) {
        self.text = text
        self.textColor = textColor
        self.selected = selected
        self.isOn = selected
        self.onTap = onTap
        self.state = state
    }
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            Text(text)
                .foregroundColor(Color(textColor))
        }
        .toggleStyle(BPKCheckboxToggleStyle(
            selected: selected,
            disabled: disabled,
            state: state))
        .disabled(disabled)
    }
    
    public func disabled(_ disabled: Bool) -> BPKCheckbox {
        var checkBox = self
        checkBox.disabled = disabled
        return checkBox
    }
}

struct BPKCheckboxToggleStyle: ToggleStyle {
    let selected: Bool
    let disabled: Bool
    let state: CheckboxState
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(Color(outlineColor(configuration.isOn)),
                        lineWidth: configuration.isOn ? 0 : 6)
                .background(configuration.isOn ? .surfaceHeroColor : .clear)
                .frame(width: 20, height: 20)
                .cornerRadius(5.0)
                .overlay {
                    if configuration.isOn {
                        setCheckIcon()
                            .foregroundColor(.white)
                    }
                }
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
    
    private func setCheckIcon() -> BPKIconView {
        switch state {
        case .regular:
            return BPKIconView(.tick, size: .small)
        case .error:
            return BPKIconView(.baggageCross, size: .small)
        case .intermediate:
            return BPKIconView(.minus, size: .small)
        }
    }
    
    private func outlineColor(_ isPressed: Bool) -> BPKColor {

        if disabled {
            return .lineColor
        }
        switch state {
        case .regular, .intermediate:
            return .textSecondaryColor
        case .error:
            return .textErrorColor
        }
    }
}

#Preview {
    HStack {
        VStack(alignment: .leading, spacing: 10) {
            BPKCheckbox("Regular", selected: true, onTap: {}, state: .regular)
            BPKCheckbox("Unchecked", onTap: {}, state: .regular)
            BPKCheckbox("Error", onTap: {}, state: .error)
            BPKCheckbox("Intermediate", selected: true, onTap: {}, state: .intermediate)
            BPKCheckbox("Disabled", onTap: {}, state: .regular).disabled(true)
        }
        
        VStack(alignment: .leading, spacing: 10) {
            BPKCheckbox("Regular",
                        textColor: .textOnDarkColor,
                        selected: true,
                        onTap: {},
                        state: .regular)
            BPKCheckbox("Unchecked",
                        textColor: .textOnDarkColor,
                        onTap: {},
                        state: .regular)
            BPKCheckbox("Error",
                        textColor: .textOnDarkColor,
                        onTap: {},
                        state: .error)
            BPKCheckbox("Intermediate",
                        textColor: .textOnDarkColor,
                        selected: true,
                        onTap: {},
                        state: .intermediate)
            BPKCheckbox("Disabled",
                        textColor: .textOnDarkColor,
                        onTap: {},
                        state: .regular).disabled(true)
        }
        .padding()
        .background(Color(.surfaceContrastColor))
    }

}
