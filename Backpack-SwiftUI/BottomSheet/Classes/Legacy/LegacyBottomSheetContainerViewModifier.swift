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

struct BottomSheetContainerViewModifier<BottomSheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    private let snapRatio: CGFloat = 0.5
    
    var maxHeight: CGFloat = UIScreen.main.bounds.height
    let contentMode: BPKBottomSheetContentMode
    let isClosable: Bool
    let closeButtonAccessibilityLabel: String?
    let title: String?
    let action: BPKBottomSheetAction?
    let bottomSheetContent: BottomSheetContent
    
    @GestureState var translation: CGFloat = 0
    
    @State var offset: CGFloat = 0
    
    var minHeight: CGFloat {
        maxHeight * 0.5
    }
    
    private var handle: some View {
        Color(BPKColor.lineColor)
            .clipShape(Capsule())
            .frame(width: BPKSpacing.xxl, height: BPKSpacing.sm)
    }
    
    init(
        isPresented: Binding<Bool>,
        maxHeight: CGFloat,
        contentMode: BPKBottomSheetContentMode,
        isClosable: Bool,
        closeButtonAccessibilityLabel: String? = nil,
        title: String? = nil,
        action: BPKBottomSheetAction? = nil,
        @ViewBuilder bottomSheetContent: () -> BottomSheetContent
    ) {
        self._isPresented = isPresented
        self.maxHeight = maxHeight
        self.contentMode = contentMode
        self.isClosable = isClosable
        self.closeButtonAccessibilityLabel = closeButtonAccessibilityLabel
        self.title = title
        self.action = action
        self.bottomSheetContent = bottomSheetContent()
        _offset = isPresented.wrappedValue ? .init(initialValue: minHeight) :
            .init(initialValue: maxHeight)
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
    private var header: some View {
        if isClosable || title != nil || action != nil {
            BottomSheetHeader(
                closeAction: headerCloseAction,
                title: title,
                action: action
            )
        }
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                content
                if isPresented {
                    Color(BPKColor.scrimColor)
                }
                VStack(spacing: BPKSpacing.none) {
                    ZStack(alignment: .top) {
                        handle
                            .padding(.top, .md)
                        header
                    }
                    bottomSheetContent
                }
                .frame(width: geometry.size.width, height: maxHeight, alignment: .top)
                .background(BPKColor.surfaceDefaultColor)
                .clipShape(.bottomSheet)
                .frame(height: geometry.size.height, alignment: .bottom)
                .offset(y: offset + translation)
                .animation(.interactiveSpring(), value: isPresented)
                .animation(.interactiveSpring(), value: offset)
                .gesture(dragGesture)
            }
        }
        .ignoresSafeArea()
        .onChange(of: isPresented, perform: onPresentedChanged)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($translation, body: { value, state, _ in
                if offset == 0, value.translation.height < 0 { return }
                state = value.translation.height
            })
            .onEnded({ value in
                var snapDistance = maxHeight * snapRatio
                
                if contentMode == .regular {
                    if offset != 0 {
                        snapDistance = minHeight * snapRatio
                    }
                    offset = value.translation.height > 0 ? maxHeight - minHeight : 0
                }
                
                if value.translation.height > snapDistance {
                    isPresented = false
                }
            })
    }
    
    private func onPresentedChanged(_ value: Bool) {
        withAnimation {
            guard value else {
                offset = maxHeight
                return
            }
            
            if contentMode == .regular {
                offset = maxHeight - minHeight
            } else {
                offset = 0
            }
        }
    }
}

private struct BottomSheetHeader: View {
    let closeAction: BPKBottomSheetAction?
    let title: String?
    let action: BPKBottomSheetAction?
    
    @ViewBuilder
    private var closeButtonView: some View {
        if let closeAction {
            Spacer()
                .overlay(
                    BPKIconView(.close, size: .large)
                        .onTapGesture(perform: closeAction.action)
                        .accessibilityLabel(closeAction.title)
                        .accessibilityAddTraits(.isButton),
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
    
    var body: some View {
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

struct BottomSheetContainerViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        BPKButton("Show bottom sheet", action: {})
            .modifier(
                BottomSheetContainerViewModifier(
                    isPresented: .constant(true),
                    maxHeight: 600,
                    contentMode: .regular,
                    isClosable: true,
                    closeButtonAccessibilityLabel: "Close button",
                    title: "Title",
                    action: BPKBottomSheetAction(title: "Action", action: {}),
                    bottomSheetContent: {
                        BPKText("Bottom sheet content")
                    })
            )
    }
}
