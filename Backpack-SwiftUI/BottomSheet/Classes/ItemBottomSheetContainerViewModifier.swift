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
    
    @State var selectedSheetDetent: PresentationDetent
    
    init(
        item: Binding<Item?>,
        peekHeight: CGFloat?,
        contentMode: BPKBottomSheetContentMode,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder bottomSheetContent: @escaping (Item) -> BottomSheetContent
    ) {
        self._item = item
        self.peekHeight = peekHeight
        _selectedSheetDetent = .init(initialValue: .initialDetent(for: contentMode))
        self.contentMode = contentMode
        self.header = header
        self.bottomSheetContent = bottomSheetContent
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(item: $item) { item in
                switch contentMode {
                case .large:
                    bottomSheetContent(for: [.large], item: item)
                case .medium(let expansible):
                    let detents: Set<PresentationDetent> = expansible ? [.medium, .large] : [.medium]
                    bottomSheetContent(for: detents, item: item)
                case .fitContent:
                    GeometryReader { reader in
                        ContentFitBottomSheet(
                            peekHeight: peekHeight,
                            header: header,
                            bottomSheetContent: { bottomSheetContent(item) },
                            sheetProxy: reader.size
                        )
                    }
                }
            }
    }
    
    private func bottomSheetContent(for detents: Set<PresentationDetent>, item: Item) -> some View {
        var finalDetents = detents
        if let peekHeight {
            finalDetents.insert(.height(peekHeight))
        }
        return VStack {
            header()
            bottomSheetContent(item)
                .presentationDetents(finalDetents, selection: $selectedSheetDetent)
                .presentationDragIndicator(.visible)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
