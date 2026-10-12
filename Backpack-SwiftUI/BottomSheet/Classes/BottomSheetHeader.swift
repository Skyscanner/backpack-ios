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
    var trailingSafeAreaInset: CGFloat = 0

    var body: some View {
        ZStack {
            if let title, !usesSideRailTitleLayout {
                BPKText(title, style: .heading5)
                    .offset(x: trailingSafeAreaInset / 2)
            }
            HStack(spacing: BPKSpacing.base) {
                if let closeAction {
                    BPKCloseButton(accessibilityLabel: closeAction.title, action: closeAction.action)
                }
                if let title, usesSideRailTitleLayout {
                    BPKText(title, style: .heading5)
                }
                if !usesSystemToolbar {
                    Spacer(minLength: 0)
                }
                if let action, !usesSystemToolbar {
                    BPKButton(action.title, action: action.action)
                        .buttonStyle(.link)
                }
            }
        }
        .frame(maxWidth: usesSystemToolbar ? nil : .infinity)
        .padding(usesSystemToolbar ? BPKSpacing.none : BPKSpacing.lg)
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

struct BottomSheetNavigationContainer<Header: View, Content: View>: View {
    let usesSideRail: Bool
    let toolbarAction: BPKBottomSheetAction?
    @ViewBuilder let header: () -> Header
    @ViewBuilder let content: () -> Content

    var body: some View {
        #if compiler(>=6.4)
        if #available(iOS 27.1, *), usesSideRail, let toolbarAction {
            NavigationStack {
                content()
                    .environment(\.bottomSheetUsesSystemToolbar, true)
                    .environment(\.bottomSheetUsesSideRailHeader, true)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            header()
                                // Keep the title in the leading item's intrinsic width alongside the close button.
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
                    .toolbar(.visible, for: .navigationBar)
            }
        } else {
            content()
                .environment(\.bottomSheetUsesSideRailHeader, usesSideRail)
        }
        #else
        content()
        #endif
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
