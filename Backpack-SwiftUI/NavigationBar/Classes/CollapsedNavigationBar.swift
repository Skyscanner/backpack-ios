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

struct CollapsedNavigationBar: View {
    /// Apple's minimum touch target.
    private static let touchTarget: CGFloat = 44
    /// How far the 44 pt touch target reaches past a 24 pt icon, on each side.
    private static let touchTargetOutset: CGFloat = 10

    let title: String?
    let style: BPKNavigationBarStyle
    let leadingItems: [BPKNavigationBarItem]
    let trailingItems: [BPKNavigationBarItem]
    let expanded: Bool
    
    @State private var leadingItemsSize: CGSize = .zero
    @State private var trailingItemsSize: CGSize = .zero
    
    private var maxItemGroupWidth: CGFloat {
        if leadingItemsSize.width > trailingItemsSize.width {
            return leadingItemsSize.width
        }
        return trailingItemsSize.width
    }
    
    // swiftlint:disable closure_body_length
    var body: some View {
        VStack(spacing: BPKSpacing.none) {
            ZStack {
                // The background runs under side safe areas, such as the iPhone Duo's rail, so the bar
                // doesn't stop short of the screen edge. The items stay inside the safe area.
                Color(style.backgroundColor(expanded: expanded))
                    .frame(height: 44)
                    .ignoresSafeArea(edges: .horizontal)
                HStack(spacing: .md) {
                    HStack(spacing: .base) {
                        toolbarItemView(forItems: leadingItems)
                    }
                    .modifier(ReadSizeModifier { leadingItemsSize = $0 })
                    .frame(width: maxItemGroupWidth, alignment: .leading)
                    Spacer()
                    
                    if !expanded {
                        BPKText(title ?? "", style: .heading5)
                            .foregroundColor(style.foregroundColor(expanded: expanded))
                            .lineLimit(1)
                            .accessibilityAddTraits(title?.isEmpty == false ? .isHeader : [])
                    }
                    
                    Spacer()
                    HStack(spacing: .base) {
                        toolbarItemView(forItems: trailingItems)
                            .padding(.trailing, .md)
                    }
                    .modifier(ReadSizeModifier { trailingItemsSize = $0 })
                    .frame(width: maxItemGroupWidth, alignment: .trailing)
                }
                .padding(.horizontal, .md)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
            }
            if !expanded, let lineColor = style.lineColor {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(lineColor)
            }
        }
    }
    
    private func iconItemView(
        withIcon icon: BPKIcon,
        accessibilityLabel: String,
        accessibilityIdentifier: String?,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            BPKIconView(icon, size: .large)
                // A real 44 pt frame gives the button Apple's minimum touch target. A larger content
                // shape alone doesn't reach past the view's frame.
                .frame(width: Self.touchTarget, height: Self.touchTarget)
                .contentShape(Rectangle())
        }
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(accessibilityLabel)
        .foregroundColor(style.foregroundColor(expanded: expanded))
        .accessibilityIdentifier(accessibilityIdentifier ?? "")
        // Keeps the 24 pt the icon took in the layout, so nothing in the bar moves.
        .padding(-Self.touchTargetOutset)
    }
    
    // swiftlint:disable closure_body_length
    @ViewBuilder
    private func toolbarItemView(forItems items: [BPKNavigationBarItem]) -> some View {
        ForEach(0..<items.count, id: \.self) { index in
            let item = items[index]
            switch item.type {
            case .icon(let icon, let accessibilityLabel, let accessibilityIdentifier):
                iconItemView(
                    withIcon: icon,
                    accessibilityLabel: accessibilityLabel,
                    accessibilityIdentifier: accessibilityIdentifier,
                    action: item.action
                )
            case .title(let title):
                BPKButton(title, action: item.action)
                    .buttonStyle(.link)
                    .fixedSize()
            case .backButton(let accessibilityLabel, let accessibilityIdentifier):
                iconItemView(
                    withIcon: .chevronLeft,
                    accessibilityLabel: accessibilityLabel,
                    accessibilityIdentifier: accessibilityIdentifier,
                    action: item.action
                )
            case .closeButton(let accessibilityLabel, let accessibilityIdentifier):
                iconItemView(
                    withIcon: .close,
                    accessibilityLabel: accessibilityLabel,
                    accessibilityIdentifier: accessibilityIdentifier,
                    action: item.action
                )
            }
        }
    }
}

struct CollapsedNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CollapsedNavigationBar(
                title: "Hotels",
                style: .default,
                leadingItems: [.init(type: .backButton("Back"), action: {})],
                trailingItems: [
                    .init(type: .icon(.settings, "AI"), action: {}),
                    .init(type: .icon(.faceId, "Add"), action: {})
                ],
                expanded: false
            )
            
            CollapsedNavigationBar(
                title: "Hotels",
                style: .transparent,
                leadingItems: [.init(type: .backButton("Back"), action: {})],
                trailingItems: [
                    .init(type: .icon(.settings, "AI"), action: {}),
                    .init(type: .icon(.faceId, "Add"), action: {})
                ],
                expanded: false
            )
            
            CollapsedNavigationBar(
                title: "Hotels",
                style: .transparent,
                leadingItems: [.init(type: .backButton("Back"), action: {})],
                trailingItems: [
                    .init(type: .icon(.settings, "AI"), action: {}),
                    .init(type: .icon(.faceId, "Add"), action: {})
                ],
                expanded: true
            )
            
            CollapsedNavigationBar(
                title: "Hotels",
                style: .surfaceContrast,
                leadingItems: [.init(type: .backButton("Back"), action: {})],
                trailingItems: [
                    .init(type: .icon(.settings, "AI"), action: {}),
                    .init(type: .icon(.faceId, "Add"), action: {})
                ],
                expanded: false
            )
        }
        .frame(maxHeight: .infinity)
        .background(.red)
    }
}
