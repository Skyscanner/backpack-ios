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
    private let style: Style
    private let content: Content

    /// Creates a switch that generates its label from a string.
    ///
    /// This initializer creates a ``BPKText`` view on your behalf, and treats the
    /// title similar to ``BPKText/init(_:)``.
    ///
    /// - Parameters:
    ///   - isOn: A binding to a property that indicates whether the switch is on or off.
    ///   - text: A string that describes the purpose of the switch.
    ///   - style: The visual style of the switch. Defaults to `.default`.
    ///   - truncate: A Boolean value that determines whether the text should be truncated
    ///      or displayed on multiple lines.
    public init(
        isOn: Binding<Bool>,
        text: String,
        style: Style = .default,
        truncate: Bool = true
    ) where Content == BPKText {
        let bpkText = truncate ? BPKText(text) : BPKText(text).lineLimit(nil)

        self.init(isOn: isOn, style: style) {
            bpkText
        }
    }

    /// Creates a switch that displays a custom label.
    ///
    /// - Parameters:
    ///   - isOn: A binding to a property that determines whether the switch is on or off.
    ///   - style: The visual style of the switch. Defaults to `.default`.
    ///   - content: A view that describes the purpose of the switch.
    public init(
        isOn: Binding<Bool>,
        style: Style = .default,
        @ViewBuilder content: () -> Content
    ) {
        self._isOn = isOn
        self.style = style
        self.content = content()
    }
    
    public var body: some View {
        switch style {
            case .default:
            Toggle(isOn: $isOn) {
                content
                    .if(!BPKFont.enableDynamicType, transform: {
                        $0.sizeCategory(.large)
                    })
            }
            .toggleStyle(SwitchToggleStyle(tint: Color(.coreAccentColor)))

            case .onContrast:
            Toggle(isOn: $isOn) {
                content
                    .if(!BPKFont.enableDynamicType, transform: {
                        $0.sizeCategory(.large)
                    })
            }
            // Using the ToggleStyle modifier, we cannot change the off (non-selected) track color.
            .labelsHidden()
            .tint(Color(style.onTintColor))
            .background(Color(style.offTrackColor), in: .capsule)
        }
    }
}

// MARK: - Style

/// The visual style for `BPKSwitch`.
public enum BPKSwitchStyle {
    /// Use on default/light backgrounds.
    case `default`
    
    /// Use on contrast/dark backgrounds.
    case onContrast
}

extension BPKSwitchStyle {
    /// The tint color for the "on" state track.
    var onTintColor: BPKColor {
        switch self {
        case .default, .onContrast:
            return .coreAccentColor
        }
    }

    /// The color for the "off" state track.
    var offTrackColor: BPKColor {
        switch self {
        case .default:
            return .textDisabledColor
        case .onContrast:
            return .textOnDarkColor.withAlphaComponent(0.4)
        }
    }
}

public extension BPKSwitch {
    /// Typealias for convenience.
    typealias Style = BPKSwitchStyle
}

struct BPKSwitch_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable closure_body_length
        VStack(spacing: .xl) {
            // Default style
            VStack(alignment: .leading, spacing: .md) {
                BPKText("Default Style", style: .heading5)
                BPKSwitch(isOn: .constant(true), text: "On")
                BPKSwitch(isOn: .constant(false), text: "Off")
            }
            .padding()
            .background(.canvasColor)

            // On Contrast style
            VStack(alignment: .leading, spacing: .md) {
                BPKText("On Contrast Style", style: .heading5)
                    .foregroundColor(.textOnDarkColor)
                BPKSwitch(isOn: .constant(true), text: "On", style: .onContrast)
                    .foregroundColor(.textOnDarkColor)
                BPKSwitch(isOn: .constant(false), text: "Off", style: .onContrast)
                    .foregroundColor(.textOnDarkColor)
            }
            .padding()
            .background(.surfaceContrastColor)

            // Multi-line example
            VStack(alignment: .leading, spacing: .md) {
                BPKText("Multi-line", style: .heading5)
                BPKSwitch(
                    isOn: .constant(true),
                    text: "This is a longer label that wraps to multiple lines",
                    truncate: false
                )
            }
            .padding()
        }
    }
}
