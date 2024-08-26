//
//  BPKTextField+FieldSet.swift
//  Backpack-SwiftUI
//
//  Created by Alaa Amin on 22/08/2024.
//

import SwiftUI

extension BPKSelect: BPKFieldSetStatusHandling {
    public func inputState(_ state: BPKFieldSet<BPKSelect>.State) -> BPKSelect {
        switch state {
        case .default:
            return inputState(BPKSelect.State.default)
        case .error:
            return inputState(BPKSelect.State.error)
        }
    }
}

#Preview {
    BPKFieldSet(label: "Label", description: "Description") {
        BPKSelect(
            placeholder: "Breakfast Choices",
            options: ["Porridge", "Eggs", "Swift UI"],
            selectedIndex: .constant(1)
        )
    }
    .inputState(.error(message: "Error Message"))
    .padding()
}
