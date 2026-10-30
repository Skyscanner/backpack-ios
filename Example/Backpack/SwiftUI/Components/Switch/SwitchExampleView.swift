/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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
import Backpack_SwiftUI

struct SwitchExampleView: View {
    @State private var assessmentMode: NativeTipKitAssessmentMode?
    @State private var value = true
    @State private var disabledValue = true
    @State private var showsTooltipExample = false
    @State private var hasSeenTooltip = false
    @State private var isReturningVisit = false
    @State private var tooltipIsPresented = true

    private var attributedLabel: AttributedString {
        var label = AttributedString("Switch with styled text")
        label.foregroundColor = Color(.coreAccentColor)
        return label
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .base) {
                BPKText("Experimental tooltip", style: .heading5)
                BPKButton("Open experimental switch") {
                    isReturningVisit = hasSeenTooltip
                    tooltipIsPresented = !hasSeenTooltip
                    showsTooltipExample = true
                }
                .accessibilityIdentifier("SwitchExample.OpenTooltip")

                if #available(iOS 17.0, *) {
                    BPKButton("Assess Apple TipKit") { assessmentMode = .tipKit }
                        .accessibilityIdentifier("TipKitAssessment.OpenTipKit")
                    BPKButton("Assess native popover") { assessmentMode = .nativePopover }
                        .accessibilityIdentifier("TipKitAssessment.OpenPopover")
                    if #available(iOS 26.0, *) {
                        BPKButton("Assess TipKit with iOS 26 controls") { assessmentMode = .controlledTipKit }
                            .accessibilityIdentifier("TipKitAssessment.OpenControlledTipKit")
                    }
                }

                BPKText("Default", style: .heading5)

                BPKSwitch(
                    isOn: $value,
                    text: "Switch is \(value ? "On" : "Off")"
                )

                BPKSwitch(
                    isOn: $disabledValue,
                    text: "Disabled switch",
                    enabled: false
                )

                BPKSwitch(
                    isOn: $value,
                    text: attributedLabel
                )

                BPKSwitch(
                    isOn: $value,
                    text: "A longer switch label that demonstrates multiline wrapping.",
                    truncate: false
                )

                VStack(alignment: .leading, spacing: .base) {
                    BPKText("On contrast", style: .heading5)
                        .foregroundColor(.textOnDarkColor)

                    HStack {
                        BPKText("On contrast switch")
                            .foregroundColor(.textOnDarkColor)
                            .accessibilityHidden(true)

                        Spacer()

                        BPKSwitch(
                            isOn: $value,
                            text: "On contrast switch",
                            style: .onContrast
                        )
                    }

                    HStack {
                        BPKText("Disabled on contrast")
                            .foregroundColor(.textOnDarkColor)
                            .accessibilityHidden(true)

                        Spacer()

                        BPKSwitch(
                            isOn: $disabledValue,
                            text: "Disabled on contrast",
                            enabled: false,
                            style: .onContrast
                        )
                    }
                }
                .padding(.base)
                .background(Color(.surfaceContrastColor))
            }
            .padding()
        }
        .sheet(item: $assessmentMode) { mode in
            if #available(iOS 17.0, *) { NativeTipKitAssessmentView(mode: mode) }
        }
        .sheet(isPresented: $showsTooltipExample) {
            VStack(alignment: .leading, spacing: .lg) {
                BPKText("Experimental switch tooltip", style: .heading3)
                BPKSwitch(isOn: $value, text: "Include nearby airports", truncate: false)
                    .experimentalTooltip(.init(
                        message: "Find cheaper flights by including nearby airports in your search.",
                        informationAccessibilityLabel: "About nearby airports",
                        dismissAccessibilityLabel: "Close information",
                        showsInformationButton: isReturningVisit,
                        onPresented: { hasSeenTooltip = true }
                    ), isPresented: $tooltipIsPresented)
                    .zIndex(1)
                BPKText("Search suggestions stay in place")
                    .accessibilityIdentifier("SwitchExample.ContentBelowSwitch")
                Spacer()
                BPKButton("Done") { showsTooltipExample = false }
                    .stretchable()
                    .accessibilityIdentifier("SwitchExample.CloseTooltip")
            }
            .padding(.lg)
        }
    }
}

struct SwitchExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchExampleView()
    }
}

/// Example-only comparison. This does not change the experimental Switch API.
@available(iOS 17.0, *)
@MainActor
enum TipKitAssessmentConfiguration {
    static let errorMessage: String? = {
        do {
            let directory = try FileManager.default.url(
                for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true
            ).appendingPathComponent("NearbyAirportsTipKitAssessment", isDirectory: true)
            if ProcessInfo.processInfo.arguments.contains("TIPKIT_ASSESSMENT_RESET") {
                if FileManager.default.fileExists(atPath: directory.path) {
                    try FileManager.default.removeItem(at: directory)
                }
                UserDefaults.standard.removeObject(forKey: NativeTipKitAssessmentView.historyKey)
                UserDefaults.standard.removeObject(forKey: NativeTipKitAssessmentView.controlledHistoryKey)
            }
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
            try Tips.configure([.datastoreLocation(.url(directory)), .displayFrequency(.immediate)])
            return nil
        } catch {
            return error.localizedDescription
        }
    }()
}

enum NativeTipKitAssessmentMode: String, Identifiable {
    case tipKit, nativePopover, controlledTipKit
    var id: String { rawValue }
    var title: String {
        switch self {
        case .tipKit: return "Apple TipKit"
        case .nativePopover: return "Native SwiftUI popover"
        case .controlledTipKit: return "TipKit · iOS 26 controls"
        }
    }
}

@available(iOS 17.0, *)
private struct NearbyAirportsAssessmentTip: Tip {
    var id = "nearby-airports-tipkit-assessment"
    var title: Text { Text("Nearby airports") }
    var message: Text? { Text(NativeTipKitAssessmentView.message) }
    var options: [any TipOption] { [Tips.IgnoresDisplayFrequency(true), Tips.MaxDisplayCount(1)] }
}

@available(iOS 17.0, *)
struct NativeTipKitAssessmentView: View {
    static let historyKey = "tipKitAssessment.nativePopover.hasSeen"
    static let controlledHistoryKey = "tipKitAssessment.controlledTipKit.hasSeen"
    static let message = "Find cheaper flights by including nearby airports in your search."

    let mode: NativeTipKitAssessmentMode
    @Environment(\.dismiss) private var dismiss
    @AppStorage(Self.historyKey) private var hasSeenPopover = false
    @AppStorage(Self.controlledHistoryKey) private var hasSeenControlledTip = false
    @State private var isOn = false
    @State private var selector: AssessmentSelector?
    @State private var isReturningVisit = false
    @State private var isPresented = false
    @State private var tipStatus = "Ready"
    @State private var reopenRequest = 0
    private var tip: NearbyAirportsAssessmentTip {
        NearbyAirportsAssessmentTip(id: mode == .controlledTipKit
            ? "nearby-airports-controlled-tipkit-assessment" : "nearby-airports-tipkit-assessment")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .lg) {
            BPKText(mode.title, style: .heading3)
            if let error = TipKitAssessmentConfiguration.errorMessage {
                BPKText("TipKit setup failed: \(error)").lineLimit(nil)
            }
            BPKText("Open From or To to compare the first and later visits.").lineLimit(nil)
            HStack(spacing: .md) {
                openSelector(.from)
                openSelector(.to)
            }
            BPKText("TipKit state: \(tipStatus)", style: .footnote)
                .lineLimit(nil)
                .accessibilityIdentifier("TipKitAssessment.Status")
            Spacer()
            BPKButton("Back to switches") { dismiss() }
                .accessibilityIdentifier("TipKitAssessment.CloseAssessment")
        }
        .padding(.lg)
        .sheet(item: $selector) { name in
            VStack(alignment: .leading, spacing: .lg) {
                BPKText("\(name.rawValue) · \(mode.title)", style: .heading3)
                HStack(spacing: 0) {
                    BPKText("Include nearby airports").lineLimit(nil)
                        .accessibilityHidden(true)
                    if isReturningVisit {
                        informationButton
                    }
                    Spacer(minLength: BPKSpacing.sm.value)
                    switchControl
                }
                .frame(minHeight: BPKSpacing.xxl.value + BPKSpacing.sm.value)
                BPKText("Search suggestions stay in place")
                    .accessibilityIdentifier("TipKitAssessment.ContentBelowSwitch")
                Spacer()
                BPKButton("Done") { selector = nil }
                    .stretchable()
                    .accessibilityIdentifier("TipKitAssessment.CloseSelector")
            }
            .padding(.lg)
            .task(id: reopenRequest) {
                guard reopenRequest > 0, mode == .controlledTipKit else { return }
                if #available(iOS 26.0, *) {
                    await tip.resetEligibility()
                    guard !Task.isCancelled, selector != nil else { return }
                    isPresented = true
                }
            }
        }
        .task {
            for await status in tip.statusUpdates {
                switch status {
                case .pending: tipStatus = "Pending"
                case .available: tipStatus = "Available"
                case .invalidated:
                    tipStatus = "Permanently dismissed"
                    if mode == .controlledTipKit { hasSeenControlledTip = true }
                }
            }
        }
    }

    private func openSelector(_ choice: AssessmentSelector) -> some View {
        BPKButton(choice.rawValue) {
            if mode == .nativePopover {
                isReturningVisit = hasSeenPopover
            } else {
                if case .invalidated = tip.status { isReturningVisit = true } else { isReturningVisit = false }
                if mode == .controlledTipKit { isReturningVisit = isReturningVisit || hasSeenControlledTip }
            }
            reopenRequest = 0
            isPresented = !isReturningVisit
            selector = choice
        }
        .accessibilityIdentifier("TipKitAssessment.Open\(choice.rawValue)")
    }

    private var informationButton: some View {
        Button {
            if mode == .controlledTipKit && !isPresented {
                reopenRequest += 1
            } else {
                isPresented.toggle()
            }
        } label: {
            BPKIconView(.informationCircle, size: .large)
                .frame(width: BPKSpacing.xxl.value + BPKSpacing.sm.value,
                       height: BPKSpacing.xxl.value + BPKSpacing.sm.value)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .foregroundColor(Color(.textSecondaryColor))
        .accessibilityLabel("About nearby airports")
        .accessibilityIdentifier("TipKitAssessment.Information")
        .modifier(AssessmentPresentation(
            mode: mode, tip: tip, isPresented: $isPresented, isAnchor: true,
            onPresented: { hasSeenPopover = true }
        ))
    }

    private var switchControl: some View {
        BPKSwitch(isOn: $isOn, text: "Include nearby airports")
            .labelsHidden()
            .fixedSize()
            .accessibilityIdentifier("TipKitAssessment.Switch")
            .modifier(AssessmentPresentation(
                mode: mode, tip: tip, isPresented: $isPresented, isAnchor: !isReturningVisit,
                onPresented: { hasSeenPopover = true }
            ))
    }
}

@available(iOS 17.0, *)
private struct AssessmentPresentation: ViewModifier {
    let mode: NativeTipKitAssessmentMode
    let tip: NearbyAirportsAssessmentTip
    @Binding var isPresented: Bool
    let isAnchor: Bool
    let onPresented: () -> Void

    @ViewBuilder func body(content: Content) -> some View {
        if !isAnchor {
            content
        } else if mode == .tipKit {
            if isPresented {
                content.popoverTip(tip, arrowEdge: .top)
            } else {
                content
            }
        } else if mode == .controlledTipKit {
            if #available(iOS 26.0, *) {
                content.popoverTip(tip, isPresented: $isPresented, arrowEdge: .top)
                    .tipBackgroundInteraction(.enabled)
            }
        } else {
            content.popover(isPresented: $isPresented, attachmentAnchor: .rect(.bounds), arrowEdge: .top) {
                HStack(alignment: .top, spacing: .sm) {
                    BPKText(NativeTipKitAssessmentView.message, style: .footnote)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityIdentifier("TipKitAssessment.Message")
                    BPKButton(icon: .close, accessibilityLabel: "Close information") { isPresented = false }
                        .buttonStyle(.link)
                        .accessibilityIdentifier("TipKitAssessment.Dismiss")
                }
                .padding(.md)
                .presentationCompactAdaptation(.popover)
                .onAppear(perform: onPresented)
            }
        }
    }
}

private enum AssessmentSelector: String, Identifiable {
    case from = "From", to = "To"
    var id: String { rawValue }
}

@available(iOS 17.0, *)
struct NativeTipKitAssessmentView_Previews: PreviewProvider {
    static var previews: some View { NativeTipKitAssessmentView(mode: .nativePopover) }
}
