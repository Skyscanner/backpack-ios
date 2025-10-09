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
import Backpack_Common

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
    /// - Parameter truncate: A Boolean value that determines whether the text should be truncated
    ///    or displayed on multiple lines.
    public init(isOn: Binding<Bool>, text: String, truncate: Bool = true) where Content == BPKText {
        let bpkText = truncate ? BPKText(text) : BPKText(text).lineLimit(nil)

        self.init(isOn: isOn) {
            bpkText
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
                .if(!BPKFont.enableDynamicType, transform: {
                    $0.sizeCategory(.large)
                })
        }
        .toggleStyle(SwitchToggleStyle(tint: Color(.coreAccentColor)))
    }
}

struct BPKSwitch_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable closure_body_length
        Group {
            VStack {
                BPKSwitch(isOn: .constant(true), text: "Test")
                BPKSwitch(isOn: .constant(false)) {
                    BPKText("Test")
                }
                BPKSwitch(
                    isOn: .constant(true),
                    // swiftlint:disable:next line_length
                    text: "This is a sample sentence designed to test the layout behavior, text truncation, and multi-line wrapping in SwiftUI previews, especially when rendering across different screen sizes, accessibility font settings, and dynamic type scaling scenarios.",
                    truncate: true
                )
                BPKSwitch(
                    isOn: .constant(true),
                    // swiftlint:disable:next line_length
                    text: "This is a sample sentence designed to test the layout behavior, text truncation, and multi-line wrapping in SwiftUI previews, especially when rendering across different screen sizes, accessibility font settings, and dynamic type scaling scenarios.",
                    truncate: false
                )
            }
            .previewLayout(.sizeThatFits)
            VStack {
                BPKSwitch(isOn: .constant(true), text: "Test")
                BPKSwitch(isOn: .constant(false)) {
                    BPKText("Test")
                }
                BPKSwitch(
                    isOn: .constant(true),
                    // swiftlint:disable:next line_length
                    text: "This is a sample sentence designed to test the layout behavior, text truncation, and multi-line wrapping in SwiftUI previews, especially when rendering across different screen sizes, accessibility font settings, and dynamic type scaling scenarios."
                )
                BPKSwitch(
                    isOn: .constant(true),
                    // swiftlint:disable:next line_length
                    text: "This is a sample sentence designed to test the layout behavior, text truncation, and multi-line wrapping in SwiftUI previews, especially when rendering across different screen sizes, accessibility font settings, and dynamic type scaling scenarios.",
                    truncate: false
                )
            }
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        }
    }
}
