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

/// A control that toggles between on and off states.
///
/// You create a switch by providing an `isOn` binding and a label. Bind `isOn`
/// to a Boolean property that determines whether the switch is on or off. Set
/// the label to a view that visually describes the purpose of switching between
/// toggle states
public struct BPKSwitch<Content: View>: View {
    @Binding private var isOn: Bool
    private let content: Content
    
    /// Creates a switch that generates its label from a string.
    ///
    /// This initializer creates a ``BPKText`` view on your behalf, and treats the
    /// title similar to ``BPKText/init(_:)``.
    ///
    /// - Parameter isOn: A binding to a property that indicates whether the switch is
    ///    on or off.
    /// - Parameter text: A string that describes the purpose of the switch.
    public init(isOn: Binding<Bool>, text: String) where Content == BPKText {
        self.init(isOn: isOn) {
            BPKText(text)
        }
    }
    
    /// Creates a switch that displays a custom label.
    ///
    /// - Parameters:
    ///   - isOn: A binding to a property that determines whether the switch is on
    ///     or off.
    ///   - content: A view that describes the purpose of the switch.
    public init(isOn: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isOn = isOn
        self.content = content()
    }
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            content
        }
        .toggleStyle(SwitchToggleStyle(tint: Color(.primaryColor)))
    }
}

struct BPKSwitch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                BPKSwitch(isOn: .constant(true), text: "Test")
                BPKSwitch(isOn: .constant(false)) {
                    BPKText("Test")
                }
            }
            .previewLayout(.sizeThatFits)
            VStack {
                BPKSwitch(isOn: .constant(true), text: "Test")
                BPKSwitch(isOn: .constant(false)) {
                    BPKText("Test")
                }
            }
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        }
    }
}
