/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

public struct BPKNudger: View {

    @State private var canIncrement = true
    @State private var canDecrement = true
    @Binding private var value: Int

    private var minValue: Int
    private var maxValue: Int
    private var step: Int
    
    /// Creates a `BPKNudger`.
    /// - Parameters:
    ///   - value: The value of the `BPKNudger`.
    ///     Must be between `min` and `max`.
    ///     If changed, the value will be clamped to be between `min` and `max`.
    ///   - min: The minimum value of the `BPKNudger`.
    ///     Must be less than `max`.
    ///   - max: The maximum value of the `BPKNudger`.
    ///     Must be greater than `min`.
    ///   - step: The step value of the `BPKNudger`.
    ///     Defaults to `1`.
    public init(value: Binding<Int>, min: Int, max: Int, step: Int = 1) {
        minValue = min
        maxValue = max
        self.step = step
        self._value = value
    }

    public var body: some View {
        HStack(spacing: .md) {
            BPKButton(icon: .minus, accessibilityLabel: "", enabled: $canDecrement, action: decrement)
                .buttonStyle(.secondary)
            BPKText("\(value)", style: .heading5)
                .frame(minWidth: minWidth)
            BPKButton(icon: .plus, accessibilityLabel: "", enabled: $canIncrement, action: increment)
                .buttonStyle(.secondary)
        }
        .accessibilityElement()
        .accessibilityValue(Text(String(value)))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment: increment()
            case .decrement: decrement()
            @unknown default: break
            }
        }
        .onAppear {
            if value < minValue || value > maxValue {
                value = max(min(value, maxValue), minValue)
            }
            updateButtonStates()
        }
        .onChange(of: value, perform: { _ in
            updateButtonStates()
        })
    }

    private var minWidth: CGFloat {
        // Reserve space for 2 digits. 9 is one of the widest digits
        // in Relative so 99 is one of the widest two digit numbers possible
        let width = "99".size(withAttributes: [NSAttributedString.Key.font: BPKFontStyle.heading5.font]).width

        // Round the value up to the nearest value that aligns to our spacing grid:
        return ceil(width / BPKSpacing.md.value) * BPKSpacing.md.value
    }
    
    private func updateButtonStates() {
        canIncrement = value < maxValue
        canDecrement = value > minValue
    }

    private func increment() {
        value = min(value + step, maxValue)
        updateButtonStates()
    }

    private func decrement() {
        value = max(value - step, minValue)
        updateButtonStates()
    }
}

struct BPKNudger_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKNudger(value: .constant(0), min: 0, max: 10)
            BPKNudger(value: .constant(5), min: 0, max: 10)
            BPKNudger(value: .constant(10), min: 0, max: 10)
        }
    }
}
