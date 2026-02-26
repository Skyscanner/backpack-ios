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

/// A configurable cell item component for displaying list content.
///
/// `BPKCellItem` displays a cell with optional icon, title, body text, and trailing slot content.
/// It supports different background styles, corner treatments, and interactive behaviors.
///
/// Example usage:
/// ```swift
/// BPKCellItem(title: "Settings")
///
/// BPKCellItem(
///     title: "Flight updates",
///     body: "Get notified about your flight status",
///     icon: .notification
/// )
/// ```
public struct BPKCellItem: View {
    private let title: String
    private let bodyText: String?
    private let icon: BPKIcon?
    private let style: BPKCellItemStyle
    private let corner: BPKCellItemCorner
    private let slot: BPKCellItemSlot?
    private let onClick: (() -> Void)?

    @State private var isPressed: Bool = false

    /// Creates a cell item with the specified content and configuration.
    /// - Parameters:
    ///   - title: The primary text displayed in the cell (required).
    ///   - body: Optional secondary text displayed below the title.
    ///   - icon: Optional leading icon displayed before the text content.
    ///   - style: The background style for the cell. Defaults to `.surfaceDefault`.
    ///   - corner: The corner radius treatment. Defaults to `.default`.
    ///   - slot: Optional trailing content (chevron, switch, text, link, or image).
    ///   - onClick: Optional tap handler. When provided, the cell becomes interactive.
    public init(
        title: String,
        body: String? = nil,
        icon: BPKIcon? = nil,
        style: BPKCellItemStyle = .surfaceDefault,
        corner: BPKCellItemCorner = .default,
        slot: BPKCellItemSlot? = nil,
        onClick: (() -> Void)? = nil
    ) {
        self.title = title
        self.bodyText = body
        self.icon = icon
        self.style = style
        self.corner = corner
        self.slot = slot
        self.onClick = onClick
    }

    public var body: some View {
        contentView
            .padding(.base)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .opacity(isPressed ? 0.7 : 1.0)
            .contentShape(Rectangle())
            .if(onClick != nil) { view in
                view
                    .onTapGesture {
                        onClick?()
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPressed = true }
                            .onEnded { _ in isPressed = false }
                    )
            }
            .accessibilityElement(children: hasAccessibleSlot ? .contain : .combine)
            .if(onClick != nil) { view in
                view.accessibilityAddTraits(.isButton)
            }
    }

    @ViewBuilder
    private var contentView: some View {
        HStack(spacing: .base) {
            if let icon = icon {
                BPKIconView(icon, size: .large)
                    .foregroundColor(.textPrimaryColor)
            }

            textContent

            Spacer(minLength: 0)

            if let slot = slot {
                slotView(for: slot)
            }
        }
    }

    @ViewBuilder
    private var textContent: some View {
        VStack(alignment: .leading, spacing: .sm) {
            BPKText(title, style: .heading5)
                .lineLimit(nil)

            if let bodyText = bodyText {
                BPKText(bodyText, style: .footnote)
                    .foregroundColor(.textSecondaryColor)
                    .lineLimit(nil)
            }
        }
    }

    @ViewBuilder
    private func slotView(for slot: BPKCellItemSlot) -> some View {
        switch slot {
        case .chevron:
            BPKIconView(.chevronRight, size: .small)
                .foregroundColor(.textPrimaryColor)

        case .switch(let isOn):
            BPKSwitch(isOn: isOn) {}
                .labelsHidden()

        case .text(let text):
            BPKText(text, style: .footnote)
                .foregroundColor(.textPrimaryColor)

        case .link(let text, let url, let action):
            BPKLink(markdown: "[\(text)](\(url))") { _ in
                action(url)
            }

        case .image(let image):
            image
        }
    }

    private var backgroundColor: BPKColor {
        switch style {
        case .surfaceDefault:
            return .surfaceDefaultColor
        case .surfaceLowContrast:
            return .surfaceLowContrastColor
        }
    }

    private var cornerRadius: CGFloat {
        switch corner {
        case .default:
            return .zero
        case .rounded:
            return BPKCornerRadius.sm.value
        }
    }

    /// Returns true if the slot contains an independently focusable element (switch).
    private var hasAccessibleSlot: Bool {
        guard let slot = slot else { return false }
        switch slot {
        case .switch, .link:
            return true
        default:
            return false
        }
    }
}

