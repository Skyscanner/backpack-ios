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

    private let accessibilityLabel: String
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
    public init(value: Binding<Int>, min: Int, max: Int, step: Int = 1, accessibilityLabel: String) {
        minValue = min
        maxValue = max
        self.step = step
        self._value = value
        self.accessibilityLabel = accessibilityLabel
    }

    public var body: some View {
        HStack(spacing: BPKSpacing.md.value) {
            BPKButton(icon: .minus, accessibilityLabel: "", enabled: $canDecrement, action: decrement)
                .buttonStyle(.secondary)
            BPKText("\(value)", style: .heading5)
            BPKButton(icon: .plus, accessibilityLabel: "", enabled: $canIncrement, action: increment)
                .buttonStyle(.secondary)
        }
        .accessibilityElement()
        .accessibilityValue("\(value)")
        .accessibilityLabel(accessibilityLabel)
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
    }

    private func updateButtonStates() {
        canIncrement = value < maxValue
        canDecrement = value > minValue
    }

    private func increment() {
        value = min(value + step, maxValue)
        UIAccessibility.post(notification: .announcement, argument: "\(value)")
        updateButtonStates()
    }

    private func decrement() {
        value = max(value - step, minValue)
        UIAccessibility.post(notification: .announcement, argument: "\(value)")
        updateButtonStates()
    }
}

struct BPKNudger_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKNudger(value: .constant(0), min: 0, max: 10, accessibilityLabel: "")
            BPKNudger(value: .constant(5), min: 0, max: 10, accessibilityLabel: "")
            BPKNudger(value: .constant(10), min: 0, max: 10, accessibilityLabel: "")
        }
    }
}
