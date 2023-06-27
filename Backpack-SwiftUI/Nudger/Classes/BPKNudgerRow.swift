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

public struct BPKNudgerRow: View {
    @Binding private var value: Int
    
    private let title: String
    private let subtitle: String?
    
    private let minValue: Int
    private let maxValue: Int
    private let step: Int
    
    public init(title: String, subtitle: String? = nil, value: Binding<Int>, min: Int, max: Int, step: Int = 1) {
        self.title = title
        self.subtitle = subtitle
        self.minValue = min
        self.maxValue = max
        self.step = step
        self._value = value
    }
    
    public var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                BPKText(title, style: .heading5)
                
                if let subtitle {
                    BPKText(subtitle)
                        .foregroundColor(.textSecondaryColor)
                }
            }
            Spacer()
            BPKNudger(value: $value, min: minValue, max: maxValue, step: step)
        }
        .accessibilityElement(children: .combine)
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
        }
    }
    
    private func increment() {
        value = min(value + step, maxValue)
    }

    private func decrement() {
        value = max(value - step, minValue)
    }
}

struct BPKNudgerRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKNudgerRow(title: "Adults", subtitle: "Aged 16+", value: .constant(0), min: 0, max: 10)
            BPKNudgerRow(title: "Rooms", value: .constant(0), min: 0, max: 10)
        }
    }
}
