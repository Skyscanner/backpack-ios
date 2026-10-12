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
    let toolbarAction: BPKBottomSheetAction?
    
    @State var selectedSheetDetent: PresentationDetent

    init(
        isPresented: Binding<Bool>,
        peekHeight: CGFloat?,
        contentMode: BPKBottomSheetContentMode,
        backgroundColor: BPKColor = .surfaceElevatedColor,
        toolbarAction: BPKBottomSheetAction? = nil,
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
        self.toolbarAction = toolbarAction
    }
    
    func body(content: Content) -> some View {
        BottomSheetPresentationContext { usesSideRail in
            content
                .sheet(isPresented: $isPresented) {
                    switch contentMode {
                    case .large:
                        sheetContent(for: [.large], usesSideRail: usesSideRail)
                    case .medium(let expansible):
                        let detents: Set<PresentationDetent> = expansible ? [.medium, .large] : [.medium]
                        sheetContent(for: detents, usesSideRail: usesSideRail)
                    case .fitContent:
                        ContentFitBottomSheet(
                            peekHeight: peekHeight,
                            header: header(),
                            bottomSheetContent: bottomSheetContent(),
                            backgroundColor: backgroundColor,
                            usesSideRail: usesSideRail,
                            toolbarAction: toolbarAction,
                            extendsContentToBottom: !usesSideRail
                        )
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
        }
    }

    private func sheetContent(
        for detents: Set<PresentationDetent>,
        usesSideRail: Bool
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
            sheetBody()
                .ignoresSafeArea(.container, edges: usesSideRail ? [] : .bottom)
        }
        // Configure presentation before the navigation content is laid out.
        .presentationDetents(finalDetents, selection: $selectedSheetDetent)
        .presentationDragIndicator(.visible)
        .bottomSheetBackground(backgroundColor)
    }

    private func sheetBody() -> some View {
        VStack {
            BottomSheetInlineHeader(header: header)
            bottomSheetContent()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

extension View {
    // iOS 16.4 introduced presentationBackground, which fills the sheet's presentation bounds.
    // Earlier versions extend only the background sideways and down, preserving the top boundary and content safe areas.
    @ViewBuilder
    func bottomSheetBackground(_ color: BPKColor) -> some View {
        if #available(iOS 16.4, *) {
            presentationBackground(Color(color.value))
        } else {
            background(Color(color.value), ignoresSafeAreaEdges: [.horizontal, .bottom])
        }
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
