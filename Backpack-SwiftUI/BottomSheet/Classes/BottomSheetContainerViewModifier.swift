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

struct BottomSheetContainerViewModifier<Header: View, BottomSheetContent: View>: ViewModifier {
    let peekHeight: CGFloat?
    @Binding var isPresented: Bool
    @ViewBuilder let header: () -> Header
    let contentMode: BPKBottomSheetContentMode
    let bottomSheetContent: () -> BottomSheetContent
    let backgroundColor: BPKColor
    
    @State var selectedSheetDetent: PresentationDetent
    
    init(
        isPresented: Binding<Bool>,
        peekHeight: CGFloat?,
        contentMode: BPKBottomSheetContentMode,
        backgroundColor: BPKColor = .surfaceElevatedColor,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder bottomSheetContent: @escaping () -> BottomSheetContent
    ) {
        self._isPresented = isPresented
        self.peekHeight = peekHeight
        _selectedSheetDetent = .init(initialValue: .initialDetent(for: contentMode))
        self.contentMode = contentMode
        self.header = header
        self.bottomSheetContent = bottomSheetContent
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                switch contentMode {
                case .large:
                    bottomSheetContent(for: [.large])
                case .medium(let expansible):
                    let detents: Set<PresentationDetent> = expansible ? [.medium, .large] : [.medium]
                    bottomSheetContent(for: detents)
                case .fitContent:
                    ContentFitBottomSheet(
                        peekHeight: peekHeight,
                        header: header(),
                        bottomSheetContent: bottomSheetContent()
                    )
                }
            }
    }
    
    private func bottomSheetContent(for detents: Set<PresentationDetent>) -> some View {
        var finalDetents = detents
        if let peekHeight {
            finalDetents.insert(.height(peekHeight))
        }
        return VStack {
            header()
            bottomSheetContent()
                .presentationDetents(finalDetents, selection: $selectedSheetDetent)
                .presentationDragIndicator(.visible)
        }
        .background(backgroundColor)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

extension PresentationDetent {
    static func initialDetent(for contentMode: BPKBottomSheetContentMode) -> PresentationDetent {
        switch contentMode {
        case .large:
            return .large
        case .medium:
            return .medium
        case .fitContent:
            return .height(0)
        }
    }
}

struct BottomSheetContainerViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
    }
}
