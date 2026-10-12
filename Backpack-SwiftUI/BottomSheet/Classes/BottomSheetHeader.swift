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

struct BottomSheetHeader: View {
    @Environment(\.bottomSheetUsesSideRailHeader) private var usesSideRailTitleLayout
    @Environment(\.bottomSheetUsesSystemToolbar) private var usesSystemToolbar

    let closeAction: BPKBottomSheetAction?
    let title: String?
    let action: BPKBottomSheetAction?
    var body: some View {
        if usesSideRailTitleLayout {
            sideRailHeader
        } else {
            HStack {
                closeButtonView
                if let title {
                    BPKText(title, style: .heading5)
                }
                actionView
            }
            .padding(.lg)
        }
    }

    private var sideRailHeader: some View {
        HStack(spacing: BPKSpacing.base) {
            if let closeAction {
                BPKCloseButton(accessibilityLabel: closeAction.title, action: closeAction.action)
                    .layoutPriority(usesSystemToolbar ? 1 : 0)
            }
            if let title {
                BPKText(title, style: .heading5)
            }
            if !usesSystemToolbar {
                Spacer(minLength: 0)
                if let action {
                    BPKButton(action.title, action: action.action)
                        .buttonStyle(.link)
                }
            }
        }
        .frame(maxWidth: usesSystemToolbar ? nil : .infinity)
        .padding(usesSystemToolbar ? BPKSpacing.none : BPKSpacing.lg)
    }

    @ViewBuilder
    private var closeButtonView: some View {
        if let closeAction {
            Spacer()
                .overlay(
                    BPKCloseButton(accessibilityLabel: closeAction.title, action: closeAction.action),
                    alignment: .leading
                )
        } else {
            Spacer()
        }
    }

    @ViewBuilder
    private var actionView: some View {
        if let action {
            Spacer()
                .overlay(
                    BPKButton(action.title, action: action.action)
                        .buttonStyle(.link),
                    alignment: .trailing
                )
        } else {
            Spacer()
        }
    }
}

private struct BottomSheetUsesSystemToolbarKey: EnvironmentKey {
    static let defaultValue = false
}

private struct BottomSheetUsesSideRailHeaderKey: EnvironmentKey {
    static let defaultValue = false
}

private extension EnvironmentValues {
    var bottomSheetUsesSideRailHeader: Bool {
        get { self[BottomSheetUsesSideRailHeaderKey.self] }
        set { self[BottomSheetUsesSideRailHeaderKey.self] = newValue }
    }

    var bottomSheetUsesSystemToolbar: Bool {
        get { self[BottomSheetUsesSystemToolbarKey.self] }
        set { self[BottomSheetUsesSystemToolbarKey.self] = newValue }
    }
}

// Read the presenting layout before entering the sheet's navigation hierarchy.
struct BottomSheetPresentationContext<Content: View>: View {
    @ViewBuilder let content: (Bool) -> Content

    var body: some View {
        #if compiler(>=6.4)
        if #available(iOS 27.1, *) {
            AdaptiveBottomSheetPresentationContext(content: content)
        } else {
            content(false)
        }
        #else
        content(false)
        #endif
    }
}

struct BottomSheetInlineHeader<Header: View>: View {
    @Environment(\.bottomSheetUsesSystemToolbar) private var usesSystemToolbar
    @ViewBuilder let header: () -> Header

    var body: some View {
        if !usesSystemToolbar {
            header()
        }
    }
}

// On iOS 27.1+, when built with Swift 6.4+, Backpack hosts sheet content in its own
// NavigationStack on all layouts to preserve content state across folding changes.
// Caller-provided navigation stacks and toolbars must account for this outer navigation container.
struct BottomSheetNavigationContainer<Header: View, Content: View>: View {
    let usesSideRail: Bool
    let toolbarAction: BPKBottomSheetAction?
    @ViewBuilder let header: () -> Header
    @ViewBuilder let content: () -> Content

    @State private var headerAvailableWidth: CGFloat?

    private var usesSystemToolbar: Bool {
        usesSideRail && toolbarAction != nil
    }

    var body: some View {
        #if compiler(>=6.4)
        if #available(iOS 27.1, *) {
            // Keep content identity stable when folding or changing the action.
            NavigationStack {
                content()
                    .onGeometryChange(for: CGFloat.self) { geometry in
                        max(0, geometry.size.width - 2 * BPKSpacing.lg.value)
                    } action: { width in
                        headerAvailableWidth = width
                    }
                    .environment(\.bottomSheetUsesSystemToolbar, usesSystemToolbar)
                    .environment(\.bottomSheetUsesSideRailHeader, usesSideRail)
                    .toolbar {
                        if usesSideRail, let toolbarAction {
                            ToolbarItem(placement: .topBarLeading) {
                                header()
                                    // Preserve intrinsic sizing for the toolbar, but truncate long titles
                                    // within the sheet's content area, clear of the side rail.
                                    .frame(maxWidth: headerAvailableWidth, alignment: .leading)
                                    .fixedSize(horizontal: true, vertical: false)
                                    .environment(\.bottomSheetUsesSystemToolbar, true)
                                    .environment(\.bottomSheetUsesSideRailHeader, true)
                            }
                            .axisBehavior(.horizontalOnly)
                            .sharedBackgroundVisibility(.hidden)
                            ToolbarItem(placement: .topBarPinnedTrailing) {
                                BPKButton(toolbarAction.title, action: toolbarAction.action)
                                    .buttonStyle(.link)
                                    .fixedSize(horizontal: true, vertical: false)
                            }
                            .axisBehavior(.verticalPreferred)
                            .sharedBackgroundVisibility(.hidden)
                        }
                    }
                    .toolbar(usesSystemToolbar ? .visible : .hidden, for: .navigationBar)
            }
        } else {
            inlineContent
        }
        #else
        inlineContent
        #endif
    }

    private var inlineContent: some View {
        content()
            .environment(\.bottomSheetUsesSystemToolbar, false)
            .environment(\.bottomSheetUsesSideRailHeader, usesSideRail)
    }
}

#if compiler(>=6.4)
@available(iOS 27.1, *)
private struct AdaptiveBottomSheetPresentationContext<Content: View>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.toolbarVerticalEdge) private var toolbarVerticalEdge
    @ViewBuilder let content: (Bool) -> Content

    var body: some View {
        content(horizontalSizeClass == .compact && toolbarVerticalEdge != nil)
    }
}
#endif

struct BottomSheetHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BottomSheetHeader(
                closeAction: BPKBottomSheetAction(title: "a11y", action: {}),
                title: "Some Title",
                action: BPKBottomSheetAction(title: "Action", action: {})
            )
            BottomSheetHeader(
                closeAction: nil,
                title: "Some Title",
                action: nil
            )
        }
    }
}
