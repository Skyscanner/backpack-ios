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

    @Environment(\.sizeCategory) var sizeCategory
    @State private var canIncrement = true
    @State private var canDecrement = true
    @Binding private var value: Int
    
    private let title: String?
    private let subtitle: String?
    private let icon: BPKIcon?

    private var minValue: Int
    private var maxValue: Int
    private var step: Int
    private let minWidth: CGFloat = BPKSpacing.lg.value
    @State var accessibilityPrefix: String?
    
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
    ///   - accessibilityPrefix: The string which would be added to accessibility identifiers of `BPKNudger` components.
    ///     Defaults to `nil`.
    public init(value: Binding<Int>, min: Int, max: Int, step: Int = 1, accessibilityPrefix: String? = nil) {
        self.title = nil
        self.subtitle = nil
        self.icon = nil
        
        minValue = min
        maxValue = max
        self.step = step
        self.accessibilityPrefix = accessibilityPrefix
        self._value = value
    }
    
    /// Creates a `BPKNudger`.
    /// - Parameters:
    ///   - title: The value of the `BPKNudger` title label
    ///   - subtitle: The value of the `BPKNudger` subtitle label
    ///     Optional, when not set, the title will vertically center
    ///   - icon: An optional icon
    ///   - value: The value of the `BPKNudger`.
    ///     Must be between `min` and `max`.
    ///     If changed, the value will be clamped to be between `min` and `max`.
    ///   - min: The minimum value of the `BPKNudger`.
    ///     Must be less than `max`.
    ///   - max: The maximum value of the `BPKNudger`.
    ///     Must be greater than `min`.
    ///   - step: The step value of the `BPKNudger`.
    ///     Defaults to `1`.
    ///   - accessibilityPrefix: The string which would be added to accessibility identifiers of `BPKNudger` components.
    ///     Defaults to `nil`.
    public init(
        title: String,
        subtitle: String? = nil,
        icon: BPKIcon? = nil,
        value: Binding<Int>,
        min: Int,
        max: Int,
        step: Int = 1,
        accessibilityPrefix: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.minValue = min
        self.maxValue = max
        self.step = step
        self.accessibilityPrefix = accessibilityPrefix
        self._value = value
    }

    // swiftlint:disable closure_body_length
    public var body: some View {
        HStack(spacing: .md) {
            if let title {
                HStack(alignment: subtitle == nil ? .center : .top, spacing: .md) {
                    if let icon {
                        BPKIconView(icon, size: .large)
                            .accessibilityHidden(true)
                    }
                    VStack(alignment: .leading) {
                        BPKText(title, style: .heading5)
                            .lineLimit(titleLineLimit())
                        
                        if let subtitle {
                            BPKText(subtitle)
                                .foregroundColor(.textSecondaryColor)
                                .lineLimit(titleLineLimit())
                        }
                    }
                }
                Spacer()
            }
            Group {
                BPKButton(icon: .minus, accessibilityLabel: "", enabled: $canDecrement, action: decrement)
                    .buttonStyle(.secondary)
                    .accessibilityIdentifier(accessibilityIdentifier(for: "minus"))
                BPKText("\(value)", style: .heading5)
                    .frame(minWidth: minWidth)
                    .accessibilityIdentifier(accessibilityIdentifier(for: "value_label"))
                BPKButton(icon: .plus, accessibilityLabel: "", enabled: $canIncrement, action: increment)
                    .buttonStyle(.secondary)
                    .accessibilityIdentifier(accessibilityIdentifier(for: "plus"))
            }
            .accessibilityElement(children: .ignore)
        }
        .accessibilityElement(children: .combine)
        .accessibilityValue(Text("\(value)"))
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
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
    }
    
    private func titleLineLimit() -> Int? {
        let isDefaultSizeOrSmaller = sizeCategory <= .large
        return isDefaultSizeOrSmaller ? 1 : nil
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
    
    private func accessibilityIdentifier(for label: String) -> String {
        if let prefix = accessibilityPrefix {
            return "\(prefix)_\(label)"
        }
        return ""
    }
}

extension BPKNudger {
    func accessibilityPrefix(_ prefix: String?) -> BPKNudger {
        let result = self
        result.accessibilityPrefix = prefix
        return result
    }
}

struct BPKNudger_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKNudger(value: .constant(0), min: 0, max: 10)
                .accessibilityPrefix(" ")
            BPKNudger(value: .constant(5), min: 0, max: 10)
            BPKNudger(value: .constant(10), min: 0, max: 10)
            BPKNudger(title: "Adults", subtitle: "Aged 16 and older", value: .constant(1), min: 1, max: 10)
            BPKNudger(
                title: "Travellers",
                subtitle: "Aged 16 and older",
                icon: .adult,
                value: .constant(1),
                min: 1,
                max: 10
            )
            BPKNudger(title: "Rooms", icon: .room, value: .constant(1), min: 1, max: 10)
        }
    }
}
