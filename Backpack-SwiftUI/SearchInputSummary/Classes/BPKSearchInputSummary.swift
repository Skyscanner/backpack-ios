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

/// A control that displays an editable text interface for search inputs.
///
/// Use `inputState(_ state: State)` to change the state of the text field.
public struct BPKSearchInputSummary: View {
    
    public enum InputPrefix {
        case text(String)
        case icon(BPKIcon)
    }
    
    struct Icon {
        let icon: BPKIcon
        let color: BPKColor
    }
    
    @Binding private var text: String
    @FocusState private var focused: Bool
    @Environment(\.layoutDirection) private var layoutDirection
    private let placeholder: String
    private let inputPrefix: InputPrefix?
    private var style: Style = .default
    private var docking: Docking = .float
    private var minHeight: CGFloat = 48.0
    private let accessibilityIdentifier: String
    private var customAccessibilityValue: String?
    private let readOnly: Bool
    private let withBorder: Bool
    private let clearAction: ClearAction?

    public struct ClearAction {
        public let accessibilityLabel: String
        public let action: () -> Void

        public init(accessibilityLabel: String, action: @escaping () -> Void) {
            self.accessibilityLabel = accessibilityLabel
            self.action = action
        }
    }

    public init(
        placeholder: String = "",
        inputPrefix: InputPrefix? = nil,
        clearAction: ClearAction? = nil,
        readOnly: Bool = false,
        accessibilityIdentifier: String = "search_field",
        customAccessibilityValue: String? = nil,
        withBorder: Bool = true,
        _ text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.inputPrefix = inputPrefix
        self.clearAction = clearAction
        self.readOnly = readOnly
        self.accessibilityIdentifier = accessibilityIdentifier
        self.customAccessibilityValue = customAccessibilityValue
        self.withBorder = withBorder
        self._text = text
    }
    
    public var body: some View {
        HStack(spacing: .md) {
            prefixView
                .accessibilityHidden(true)
            TextField(placeholder, text: $text, prompt: placeholderView)
                .font(style: .bodyDefault)
                .foregroundColor(.textPrimaryColor)
                // `TextField`'s default/"natural" text alignment resolves from the bidi direction of
                // its *content* (e.g. English text/placeholder → left), not from the UI's layout
                // direction. On iOS 18+ this makes the field's text fail to mirror under RTL when its
                // content happens to be LTR-script. `.multilineTextAlignment(.leading/.trailing)` can't
                // fix this: those SwiftUI values are themselves direction-aware ("natural") and resolve
                // to the same thing. We force a hard (non-"natural") `UITextField.textAlignment`
                // instead, matching the current layout direction. See DON-3924.
                .background(TextFieldAlignmentFixer(alignment: layoutDirection == .rightToLeft ? .right : .left))
                .disabled(readOnly)
                .if(readOnly, transform: { view in
                    view.accessibilityElement()
                })
                .accessibilityValue(customAccessibilityValue ?? text)
                .accessibilityLabel(accessibilityLabel)
                .accessibilityAddTraits(readOnly ? [] : .isSearchField)
                .accessibilityIdentifier(accessibilityIdentifier)
                .focused($focused)
            accessory
        }
        .frame(maxWidth: .infinity, minHeight: minHeight)
        .padding(.horizontal, BPKSpacing.base)
        .background(.surfaceDefaultColor)
        .clipShape(dockingShape)
        .overlay(dockingBorder)
        
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
    }

    private var accessibilityLabel: String {
        if case let .text(prefixText)? = inputPrefix {
            return "\(prefixText), \(placeholder)"
        }
        return placeholder
    }

    @ViewBuilder
    private var accessory: some View {
        if let clearAction {
            Button(action: clearAction.action) {
                BPKIconView(.closeCircle)
                    .foregroundColor(.textSecondaryColor)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(clearAction.accessibilityLabel)
            .accessibilityAddTraits(.isButton)
            .opacity(text.isEmpty ? 0.0 : 1.0)
        }
    }
    
    @ViewBuilder
    private var placeholderView: Text {
        Text(placeholder)
            .foregroundColor(Color(BPKColor.textSecondaryColor.value))
    }
    
    @ViewBuilder
    private var prefixView: some View {
        if let inputPrefix {
            switch inputPrefix {
            case .text(let prefixText):
                BPKText(prefixText, style: .bodyDefault)
                    .foregroundColor(.textSecondaryColor)
            case .icon(let icon):
                BPKIconView(icon)
                    .foregroundColor(.textPrimaryColor)
            }
        }
    }
    
    public func customStyle(_ style: Style) -> BPKSearchInputSummary {
        var result = self
        result.style = style
        return result
    }

    /// Sets the docking position for stacked search inputs.
    /// - Parameter docking: The docking position (.float, .top, .middle, .bottom)
    /// - Returns: A modified search input summary with the specified docking
    public func docking(_ docking: Docking) -> BPKSearchInputSummary {
        var result = self
        result.docking = docking
        return result
    }

    /// Sets the minimum height for the search input.
    /// - Parameter height: The minimum height in points. Default is 48.
    /// - Returns: A modified search input summary with the specified minimum height
    public func inputMinHeight(_ height: CGFloat) -> BPKSearchInputSummary {
        var result = self
        result.minHeight = height
        return result
    }

    private var isBorderHighlighted: Bool {
        focused || style == .focused
    }

    private var dockingShape: UnevenRoundedRectangle {
        UnevenRoundedRectangle(
            topLeadingRadius: docking.topCornerRadius,
            bottomLeadingRadius: docking.bottomCornerRadius,
            bottomTrailingRadius: docking.bottomCornerRadius,
            topTrailingRadius: docking.topCornerRadius
        )
    }

    private var dockingBorder: some View {
        let lineWidth = isBorderHighlighted ? 2.0 : 1.0
        let borderColour: Color
        if !withBorder {
            borderColour = .clear
        } else if isBorderHighlighted {
            borderColour = Color(.coreAccentColor)
        } else {
            let isDocked = docking != .float
            borderColour = Color(UIColor { traits in
                traits.userInterfaceStyle == .dark && isDocked ? .clear : BPKColor.lineColor.value
            })
        }
        return dockingShape
            .stroke(borderColour, lineWidth: lineWidth)
    }
}

fileprivate extension TextField {
    func font(style: BPKFontStyle) -> some View {
        self.font(style.font)
    }
}

/// An invisible helper view that locates the nearest `UITextField` in the view hierarchy (via its
/// shared ancestor with this view) and forces a hard `textAlignment`, bypassing `UITextField`'s
/// `.natural` default which resolves from the bidi direction of the field's *content* rather than
/// the current `layoutDirection`. See the usage site in `BPKSearchInputSummary` for context.
private struct TextFieldAlignmentFixer: UIViewRepresentable {
    let alignment: NSTextAlignment

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Apply synchronously: by the time `updateUIView` runs, this view is already installed in the
        // hierarchy, and synchronous snapshot tests capture the view immediately after layout — a
        // `DispatchQueue.main.async` here would run too late (after the snapshot has already been taken).
        Self.applyAlignment(alignment, startingFrom: uiView)
    }

    /// Walks up the ancestor chain from `view` (since the exact hierarchy depth introduced by
    /// SwiftUI's `.background()` plus whatever other modifiers/gesture recognizers/accessibility
    /// grouping a given call site chains isn't guaranteed — real call sites with
    /// `.contentShape`/`.onTapGesture`/`.accessibilityElement(children:)` etc. can sit far deeper
    /// than a minimal snapshot-test harness) until at least one `UITextField` is found in the
    /// ancestor's subtree. We only stop at the root (`superview == nil`), since the search already
    /// terminates as soon as a match is found — an arbitrary depth cap just risks silently giving up
    /// too early in more deeply nested real screens. When multiple `BPKSearchInputSummary`s share
    /// that ancestor (e.g. several docked fields stacked in the same `VStack`), picking the *first*
    /// one found in subview order would incorrectly re-target the same (e.g. topmost) field every
    /// time — so instead we pick whichever candidate's frame is geometrically closest to this
    /// fixer's own frame.
    private static func applyAlignment(_ alignment: NSTextAlignment, startingFrom view: UIView) {
        var ancestor: UIView? = view.superview
        while let current = ancestor {
            let candidates = allTextFields(in: current)
            if let nearest = nearestTextField(to: view, among: candidates, in: current) {
                nearest.textAlignment = alignment
                return
            }
            ancestor = current.superview
        }
    }

    private static func allTextFields(in view: UIView) -> [UITextField] {
        if let textField = view as? UITextField {
            return [textField]
        }
        return view.subviews.flatMap { allTextFields(in: $0) }
    }

    private static func nearestTextField(
        to view: UIView,
        among candidates: [UITextField],
        in commonAncestor: UIView
    ) -> UITextField? {
        guard !candidates.isEmpty else { return nil }
        let origin = view.convert(view.bounds, to: commonAncestor).center
        return candidates.min { lhs, rhs in
            let lhsCenter = lhs.convert(lhs.bounds, to: commonAncestor).center
            let rhsCenter = rhs.convert(rhs.bounds, to: commonAncestor).center
            return origin.distanceSquared(to: lhsCenter) < origin.distanceSquared(to: rhsCenter)
        }
    }
}

private extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}

private extension CGPoint {
    func distanceSquared(to other: CGPoint) -> CGFloat {
        let dx = x - other.x
        let dy = y - other.y
        return dx * dx + dy * dy
    }
}

struct BPKSearchInputSummary_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable line_length
        ScrollView {
            VStack(spacing: .lg) {
                // Float (default - standalone) with clear action
                VStack(alignment: .leading, spacing: .sm) {
                    BPKText("With clear action", style: .caption)
                        .foregroundColor(.textOnDarkColor)
                    BPKSearchInputSummary(
                        placeholder: "Standalone input",
                        inputPrefix: .icon(.search),
                        clearAction: .init(accessibilityLabel: "Clear", action: {}),
                        .constant("Some value")
                    )
                }

                // Docked stack example (no clear action)
                VStack(alignment: .leading, spacing: .sm) {
                    BPKText("Docked stack (no clear action)", style: .caption)
                        .foregroundColor(.textOnDarkColor)
                    VStack(spacing: 0) {
                        BPKSearchInputSummary(
                            placeholder: "Where from?",
                            inputPrefix: .icon(.flightTakeoff),
                            .constant("")
                        )
                        .docking(.top)

                        BPKSearchInputSummary(
                            placeholder: "Where to?",
                            inputPrefix: .icon(.flightLanding),
                            .constant("")
                        )
                        .docking(.middle)

                        BPKSearchInputSummary(
                            placeholder: "Select dates",
                            inputPrefix: .icon(.calendar),
                            .constant("")
                        )
                        .docking(.bottom)
                    }
                }

                // Two docked inputs with values
                VStack(alignment: .leading, spacing: .sm) {
                    BPKText("With values", style: .caption)
                        .foregroundColor(.textOnDarkColor)
                    VStack(spacing: 0) {
                        BPKSearchInputSummary(
                            placeholder: "Origin",
                            inputPrefix: .icon(.flightTakeoff),
                            .constant("London")
                        )
                        .docking(.top)

                        BPKSearchInputSummary(
                            placeholder: "Destination",
                            inputPrefix: .icon(.flightLanding),
                            .constant("Paris")
                        )
                        .docking(.bottom)
                    }
                }

                // With focus state
                VStack(alignment: .leading, spacing: .sm) {
                    BPKText("With focus highlight", style: .caption)
                        .foregroundColor(.textOnDarkColor)
                    VStack(spacing: 0) {
                        BPKSearchInputSummary(
                            placeholder: "Where from?",
                            inputPrefix: .icon(.flightTakeoff),
                            .constant("Edinburgh")
                        )
                        .docking(.top)
                        .customStyle(.focused)

                        BPKSearchInputSummary(
                            placeholder: "Where to?",
                            inputPrefix: .icon(.flightLanding),
                            .constant("")
                        )
                        .docking(.bottom)
                    }
                }
            }
            .padding()
        }
        .background(.corePrimaryColor)
    }
}
