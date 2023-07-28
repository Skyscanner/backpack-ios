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

@available(iOS 16.0, *)
struct BottomSheetContainerViewModifier<BottomSheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let contentMode: BPKBottomSheetContentMode
    let isClosable: Bool
    let closeButtonAccessibilityLabel: String?
    let title: String?
    let action: BPKBottomSheetAction?
    let bottomSheetContent: () -> BottomSheetContent
    
    @State var selectedSheetDetent: PresentationDetent
    
    init(
        isPresented: Binding<Bool>,
        contentMode: BPKBottomSheetContentMode,
        isClosable: Bool,
        closeButtonAccessibilityLabel: String? = nil,
        title: String? = nil,
        action: BPKBottomSheetAction? = nil,
        @ViewBuilder bottomSheetContent: @escaping () -> BottomSheetContent
    ) {
        self._isPresented = isPresented
        _selectedSheetDetent = .init(initialValue: .initialDetent(for: contentMode))
        self.contentMode = contentMode
        
        self.isClosable = isClosable
        self.closeButtonAccessibilityLabel = closeButtonAccessibilityLabel
        self.title = title
        self.action = action
        self.bottomSheetContent = bottomSheetContent
        
    }
    
    private var headerCloseAction: BPKBottomSheetAction? {
        guard isClosable, let closeButtonAccessibilityLabel else {
            return nil
        }
        return BPKBottomSheetAction(title: closeButtonAccessibilityLabel) {
            isPresented.toggle()
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        if isClosable || title != nil || action != nil {
            BottomSheetHeader(
                closeAction: headerCloseAction,
                title: title,
                action: action
            )
        }
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                switch contentMode {
                case .large:
                    bottomSheetContent(for: [.large])
                case .medium:
                    bottomSheetContent(for: [.medium, .large])
                case .fitContent:
                    ContentFitBottomSheet(
                        header: header,
                        bottomSheetContent: bottomSheetContent
                    )
                }
            }
    }
    
    private func bottomSheetContent(for detents: Set<PresentationDetent>) -> some View {
        VStack {
            header()
            bottomSheetContent()
                .presentationDetents(detents, selection: $selectedSheetDetent)
                .presentationDragIndicator(.visible)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

@available(iOS 16.0, *)
private struct ContentFitBottomSheet<Content: View, Header: View>: View {
    let header: () -> Header
    let bottomSheetContent: () -> Content
    
    @State private var detentHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            header()
            bottomSheetContent()
                .presentationDetents([.height(detentHeight)])
        }
        .presentationDragIndicator(.visible)
        .readHeight()
        .onPreferenceChange(HeightPreferenceKey.self) { height in
            if let height {
                self.detentHeight = height
            }
        }
    }
}

private struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat?
    
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}

private struct ReadHeightModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
        }
    }
    
    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}

private extension View {
    func readHeight() -> some View {
        self.modifier(ReadHeightModifier())
    }
}

@available(iOS 16.0, *)
private extension PresentationDetent {
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
