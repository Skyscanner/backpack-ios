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

struct ItemBottomSheetContainerViewModifier<
    Header: View,
    BottomSheetContent: View,
    Item: Identifiable
>: ViewModifier {
    let peekHeight: CGFloat?
    @Binding var item: Item?
    @ViewBuilder let header: () -> Header
    let contentMode: BPKBottomSheetContentMode
    let bottomSheetContent: (Item) -> BottomSheetContent
    let backgroundColor: BPKColor
    let toolbarAction: BPKBottomSheetAction?
    
    @State var selectedSheetDetent: PresentationDetent

    init(
        item: Binding<Item?>,
        peekHeight: CGFloat?,
        contentMode: BPKBottomSheetContentMode,
        backgroundColor: BPKColor = .surfaceElevatedColor,
        toolbarAction: BPKBottomSheetAction? = nil,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder bottomSheetContent: @escaping (Item) -> BottomSheetContent
    ) {
        self._item = item
        self.peekHeight = peekHeight
        _selectedSheetDetent = .init(initialValue: .initialDetent(for: contentMode))
        self.contentMode = contentMode
        self.header = header
        self.bottomSheetContent = bottomSheetContent
        self.backgroundColor = backgroundColor
        self.toolbarAction = toolbarAction
    }
    
    func body(content: Content) -> some View {
        BottomSheetPresentationContext { usesSideRail in
            content
                .sheet(item: $item) { item in
                    switch contentMode {
                    case .large:
                        sheetContent(for: [.large], usesSideRail: usesSideRail, item: item)
                    case .medium(let expansible):
                        let detents: Set<PresentationDetent> = expansible ? [.medium, .large] : [.medium]
                        sheetContent(for: detents, usesSideRail: usesSideRail, item: item)
                    case .fitContent:
                        ContentFitBottomSheet(
                            peekHeight: peekHeight,
                            header: header(),
                            bottomSheetContent: bottomSheetContent(item),
                            backgroundColor: backgroundColor,
                            usesSideRail: usesSideRail,
                            toolbarAction: toolbarAction
                        )
                    }
                }
        }
    }

    private func sheetContent(
        for detents: Set<PresentationDetent>,
        usesSideRail: Bool, item: Item
    ) -> some View {
        var finalDetents = detents
        if let peekHeight {
            finalDetents.insert(.height(peekHeight))
        }
        return BottomSheetNavigationContainer(
            usesSideRail: usesSideRail,
            toolbarAction: toolbarAction,
            header: header
        ) {
            sheetBody(item: item)
        }
        // Configure presentation before the navigation content is laid out.
        .presentationDetents(finalDetents, selection: $selectedSheetDetent)
        .presentationDragIndicator(.visible)
        .bottomSheetBackground(backgroundColor)
    }

    private func sheetBody(item: Item) -> some View {
        VStack {
            BottomSheetInlineHeader(header: header)
            bottomSheetContent(item)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
