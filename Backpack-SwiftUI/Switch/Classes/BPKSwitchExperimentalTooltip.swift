/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2026 Skyscanner Ltd
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

/// Consumer-provided information for the optional switch tooltip.
///
/// Supply localised content and own presentation history in the consuming app.
/// Backpack does not persist identifiers, count visits, or alter the switch value.
///
/// - Experiment: This configuration is experimental and subject to change.
public struct BPKSwitchExperimentalTooltip {
    /// Localised explanation overlaid below the control.
    public let message: String
    /// Localised label for the separate information button.
    public let informationAccessibilityLabel: String
    /// Localised label for closing the explanation.
    public let dismissAccessibilityLabel: String
    /// Show an information button after the label on subsequent visits; hide it for the introduction.
    public let showsInformationButton: Bool
    /// Reports an explanation that actually appeared, rather than a constructed configuration.
    public let onPresented: () -> Void

    /// Creates optional switch information.
    ///
    /// - Parameters:
    ///   - message: Localised explanation overlaid below the control.
    ///   - informationAccessibilityLabel: Localised label for the information button.
    ///   - dismissAccessibilityLabel: Localised label for closing the explanation.
    ///   - showsInformationButton: Whether to offer an information button after the label, before the switch.
    ///   - onPresented: Called when the explanation actually appears, including manual reopening.
    public init(
        message: String,
        informationAccessibilityLabel: String,
        dismissAccessibilityLabel: String,
        showsInformationButton: Bool = true,
        onPresented: @escaping () -> Void = {}
    ) {
        self.message = message
        self.informationAccessibilityLabel = informationAccessibilityLabel
        self.dismissAccessibilityLabel = dismissAccessibilityLabel
        self.showsInformationButton = showsInformationButton
        self.onPresented = onPresented
    }
}

struct BPKSwitchTooltipContent<Message: View>: View {
    @Environment(\.layoutDirection) private var layoutDirection
    let configuration: BPKSwitchExperimentalTooltip
    let anchorX: CGFloat
    let onDismiss: () -> Void
    @ViewBuilder let message: () -> Message

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            GeometryReader { geometry in
                TooltipPointer()
                    .fill(Color(.coreAccentColor))
                    .frame(width: BPKSpacing.base.value, height: BPKSpacing.sm.value)
                    .position(x: pointerX(width: geometry.size.width), y: BPKSpacing.sm.value / 2)
            }
            .frame(height: BPKSpacing.sm.value)
            .accessibilityHidden(true)
            HStack(alignment: .top, spacing: .sm) {
                message()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, .md)
                BPKButton(icon: .close, accessibilityLabel: configuration.dismissAccessibilityLabel, size: .large, action: onDismiss)
                    .buttonStyle(.featured)
                    .accessibilityIdentifier("BPKSwitch.Tooltip.Dismiss")
            }
            .padding(.leading, .md)
            .padding(.trailing, .sm)
            .background(Color(.coreAccentColor))
            .clipShape(RoundedRectangle(cornerRadius: .sm))
            .accessibilityElement(children: .contain)
            .accessibilityAction(.escape, onDismiss)
        }
    }

    private func pointerX(width: CGFloat) -> CGFloat {
        let inset = BPKSpacing.base.value
        let position = min(max(anchorX, inset), max(inset, width - inset))
        return layoutDirection == .rightToLeft ? width - position : position
    }

    private struct TooltipPointer: Shape {
        func path(in rect: CGRect) -> Path {
            Path { path in
                path.move(to: CGPoint(x: rect.midX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.closeSubpath()
            }
        }
    }
}

/// Anchors follow the real control position, including multiline labels and RTL layouts.
struct BPKSwitchTooltipAnchorKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>?

    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue() ?? value
    }
}

enum BPKSwitchTooltipLayout {
    static let touchTarget = BPKSpacing.xxl.value + BPKSpacing.sm.value
}
