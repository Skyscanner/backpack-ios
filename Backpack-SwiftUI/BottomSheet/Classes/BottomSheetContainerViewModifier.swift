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

fileprivate enum Constants {
    static let radius: CGFloat = BPKSpacing.lg.value
    static let cornerRadius: CGFloat = BPKSpacing.md.value
    static let snapRatio: CGFloat = 0.5
}

public struct BPKBottomSheetAction {
    var title: String
    var action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

struct BottomSheetContainerViewModifier<BottomSheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    let maxHeight: CGFloat
    let contentMode: BPKBottomSheetContentMode
    let isClosable: Bool
    let closeButtonAccessibilityLabel: String?
    let title: String?
    let action: BPKBottomSheetAction?
    let bottomSheetContent: BottomSheetContent
    
    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isPresented ? 0 : maxHeight
    }
    
    private var isFullSize: Bool {
        contentMode == .fullSize
    }
    
    private var handle: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color(BPKColor.lineColor))
            .frame(width: BPKSpacing.xxl, height: BPKSpacing.sm)
    }
    
    private var header: some View {
        HStack {
            if isClosable, let closeButtonAccessibilityLabel = closeButtonAccessibilityLabel {
                BPKIconView(.close, size: .large)
                    .onTapGesture {
                        isPresented.toggle()
                    }
                    .accessibilityLabel(closeButtonAccessibilityLabel)
                    .accessibilityAddTraits(.isButton)
            }
            Spacer()
            if let title = title {
                BPKText(title, style: .heading5)
            }
            Spacer()
            if let action = action {
                BPKButton(action.title, action: action.action)
                    .buttonStyle(.link)
            }
        }
        .padding(.vertical, .md)
        .padding(.horizontal, .base)
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
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                content

                if isPresented {
                    Color.black.opacity(0.7)
                }

                VStack {
                    if isFullSize {
                        handle.padding(.md)
                    } else {
                        header
                    }
                    bottomSheetContent
                }
                .frame(width: geometry.size.width, height: maxHeight, alignment: .top)
                .background(BPKColor.surfaceDefaultColor)
                .cornerRadius(radius: Constants.radius, corners: [.topLeft, .topRight])
                .frame(height: geometry.size.height, alignment: .bottom)
                .offset(y: max(offset + translation, 0))
                .animation(.interactiveSpring(), value: isPresented)
                .animation(.interactiveSpring(), value: translation)
                .gesture(
                    DragGesture()
                        .updating($translation) { value, state, _ in
                            state = value.translation.height
                        }
                        .onEnded { value in
                            let snapDistance = self.maxHeight * Constants.snapRatio
                            guard abs(value.translation.height) > snapDistance else {
                                return
                            }
                            isPresented = false
                        }
                )
            }
        }
        .ignoresSafeArea()
    }
}

struct BottomSheetContainerViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        BPKButton("Show bottom sheet", action: {})
        .modifier(
            BottomSheetContainerViewModifier(
                isPresented: .constant(true),
                maxHeight: 400,
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
