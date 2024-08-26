//
//  BPKTextField+FieldSet.swift
//  Backpack-SwiftUI
//
//  Created by Alaa Amin on 22/08/2024.
//

import SwiftUI

extension BPKTextField: BPKFieldSetStatusHandling {
    public func inputState(_ state: BPKFieldSet<BPKTextField>.State) -> BPKTextField {
        switch state {
        case .default:
            return inputState(BPKTextField.State.default)
        case .error:
            return inputState(BPKTextField.State.error)
        }
    }
}

#Preview {
    BPKFieldSet(label: "Label", description: "Description") {
        BPKTextField(placeholder: "Enter text", .constant(""))
    }
    .inputState(.error(message: "Error Message"))
    .padding()
}
