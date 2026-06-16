//
//  SwiftUIView.swift
//  Backpack-SwiftUI
//
//  Created by Kynan Song on 16/06/2026.
//

import SwiftUI

public struct BPKCheckbox: View {
    @State private var isOn: Bool = false
    
    enum CheckboxState: Equatable {
        case regular
        case error
        case intermediate
        case disabled
    }
    
    public var label: String
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            Text(label)
        }
        .toggleStyle(BPKCheckboxToggleStyle())
    }
}

struct BPKCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: configuration.isOn ? 0 : 4)
                .background(configuration.isOn ? .surfaceHeroColor : .surfaceDefaultColor)
                .frame(width: 20, height: 20)
                .cornerRadius(5.0)
                .overlay {
                    if configuration.isOn {
                        BPKIconView(.tick, size: .small)
                            .foregroundColor(.white)
                    }
                }
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

#Preview {
    VStack {
        BPKCheckbox(label: "Test String")
    }
}
