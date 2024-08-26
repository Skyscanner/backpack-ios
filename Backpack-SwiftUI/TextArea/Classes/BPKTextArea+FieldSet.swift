//
//  BPKTextField+FieldSet.swift
//  Backpack-SwiftUI
//
//  Created by Alaa Amin on 22/08/2024.
//

import SwiftUI

extension BPKTextArea: BPKFieldSetStatusHandling {
    public func inputState(_ state: BPKFieldSet<BPKTextArea>.State) -> BPKTextArea {
        switch state {
        case .default:
            return inputState(BPKTextArea.State.default)
        case .error:
            return inputState(BPKTextArea.State.error)
        }
    }
}

#Preview {
    BPKFieldSet(label: "Label", description: "Description") {
        BPKTextArea(.constant(""), placeholder: "Enter text")
    }
    .inputState(.error(message: "Error Message"))
    .frame(height: 150)
    .padding()
}
