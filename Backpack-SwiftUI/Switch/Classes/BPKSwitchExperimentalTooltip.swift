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
import TipKit

/// Localised information shared by a switch's bottom sheet and optional native tooltip.
///
/// - Experiment: This configuration is experimental and subject to change.
public struct BPKSwitchExperimentalInformation {
    /// Localised heading used by both presentations.
    public let title: String
    /// Localised explanation used by both presentations.
    public let message: String
    /// Localised accessibility label for the persistent information button.
    public let informationAccessibilityLabel: String
    /// Localised label for closing the bottom sheet.
    public let dismissAccessibilityLabel: String

    /// Creates content for the persistent information button and bottom sheet.
    public init(
        title: String,
        message: String,
        informationAccessibilityLabel: String,
        dismissAccessibilityLabel: String
    ) {
        self.title = title
        self.message = message
        self.informationAccessibilityLabel = informationAccessibilityLabel
        self.dismissAccessibilityLabel = dismissAccessibilityLabel
    }
}

/// Separately opts into a native Apple TipKit introduction on iOS 17 and later.
///
/// Configure TipKit once in the consuming app. Use the same stable ID across screens
/// that share one introduction. Apple owns eligibility and persisted display history.
/// The persistent information button and bottom sheet work without this configuration.
///
/// - Experiment: This configuration is experimental and subject to change.
public struct BPKSwitchExperimentalTooltip {
    /// Stable consumer-owned identity shared by related screens.
    public let id: String

    /// Creates a once-only introduction with a stable consumer-owned identity.
    public init(id: String) { self.id = id }
}

struct BPKSwitchInformationButton: View {
    let configuration: BPKSwitchExperimentalInformation
    let style: BPKSwitchStyle
    let onSelect: () -> Void

    var body: some View {
        // BPKButton's link style fixes its icon colour; this neutral trigger uses the native button.
        // swiftlint:disable:next bpk_button
        Button(action: onSelect) {
            BPKIconView(.informationCircle, size: .large)
                .frame(
                    width: BPKSpacing.xxl.value + BPKSpacing.sm.value,
                    height: BPKSpacing.xxl.value + BPKSpacing.sm.value
                )
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .foregroundColor(Color(style == .onContrast ? .textOnDarkColor : .textSecondaryColor))
        .accessibilityLabel(configuration.informationAccessibilityLabel)
        .accessibilityIdentifier("BPKSwitch.Information")
    }
}

struct BPKSwitchNativeIntroduction: ViewModifier {
    let information: BPKSwitchExperimentalInformation
    let tooltip: BPKSwitchExperimentalTooltip?

    func body(content: Content) -> some View {
        if let tooltip {
            let tip = BPKSwitchInformationTip(id: tooltip.id, information: information)
            // Keep the package buildable with its Xcode 16.4 toolchain as well as newer SDKs.
            #if compiler(>=6.2)
            if #available(iOS 26.0, *) {
                content.popoverTip(tip, attachmentAnchor: .point(.bottom), arrowEdges: .top)
            } else {
                content.popoverTip(tip, arrowEdge: .top)
            }
            #else
            content.popoverTip(tip, arrowEdge: .top)
            #endif
        } else {
            content
        }
    }
}

private struct BPKSwitchInformationTip: Tip {
    let id: String
    let information: BPKSwitchExperimentalInformation
    // Apple's Tip protocol requires native Text values.
    // swiftlint:disable:next bpk_text
    var title: Text { Text(information.title) }
    // swiftlint:disable:next bpk_text
    var message: Text? { Text(information.message) }
    var options: [any TipOption] { [Tips.MaxDisplayCount(1)] }
}
