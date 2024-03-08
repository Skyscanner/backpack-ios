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

struct LegacyBottomSheetContainerViewModifier<BottomSheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    @State private var controller: UIViewController?
    
    let contentMode: BPKBottomSheetContentMode
    let isClosable: Bool
    let closeButtonAccessibilityLabel: String?
    let title: String?
    let action: BPKBottomSheetAction?
    let bottomSheetContent: () -> BottomSheetContent
    let rootViewController: UIViewController?
    
    init(
        isPresented: Binding<Bool>,
        contentMode: BPKBottomSheetContentMode,
        isClosable: Bool,
        closeButtonAccessibilityLabel: String? = nil,
        title: String? = nil,
        action: BPKBottomSheetAction? = nil,
        @ViewBuilder bottomSheetContent: @escaping () -> BottomSheetContent,
        rootViewController: UIViewController?
    ) {
        self._isPresented = isPresented
        self.contentMode = contentMode
        self.isClosable = isClosable
        self.closeButtonAccessibilityLabel = closeButtonAccessibilityLabel
        self.title = title
        self.action = action
        self.bottomSheetContent = bottomSheetContent
        self.rootViewController = rootViewController
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { _ in
                if isPresented {
                    showDialogWithContent {
                        ZStack {
                            scrim
                            switch contentMode {
                            case .large:
                                GeometryReader { proxy in
                                    contentWithMode(.large(maxHeight: maxHeight(forProxy: proxy)))
                                }
                            case .medium:
                                GeometryReader { proxy in
                                    let maxHeight = maxHeight(forProxy: proxy)
                                    contentWithMode(.medium(minHeight: maxHeight / 2, maxHeight: maxHeight))
                                }
                            case .fitContent:
                                GeometryReader { proxy in
                                    let maxHeight = maxHeight(forProxy: proxy)
                                    contentWithMode(.fitContent(offset: maxHeight))
                                }
                            }
                        }
                    }
                } else {
                    controller?.dismiss(animated: true)
                }
            }
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
    
    @ViewBuilder
    private var scrim: some View {
        if isPresented {
            Color(BPKColor.scrimColor)
                .onTapGesture {
                    isPresented.toggle()
                }
                .ignoresSafeArea()
        }
    }
    
    private func contentWithMode(_ mode: LegacyBottomSheetContentViewContentMode) -> some View {
        VStack {
            Spacer()
            LegacyBottomSheetContentView(
                isPresented: $isPresented,
                contentMode: mode,
                header: { header },
                bottomSheetContent: bottomSheetContent
            )
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    private func maxHeight(forProxy proxy: GeometryProxy) -> CGFloat {
        proxy.size.height - proxy.safeAreaInsets.top - proxy.safeAreaInsets.bottom
    }
    
    private func showDialogWithContent<Content: View>(_ content: () -> Content) {
        let controller = UIHostingController(rootView: content())
        controller.view.backgroundColor = .clear
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen

        rootViewController?.present(controller, animated: true)
        self.controller = controller
    }
}

struct LegacyBottomSheetContainerViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        BPKButton("Show bottom sheet", action: {})
            .modifier(
                LegacyBottomSheetContainerViewModifier(
                    isPresented: .constant(true),
                    contentMode: .fitContent,
                    isClosable: true,
                    closeButtonAccessibilityLabel: "Close button",
                    title: "Title",
                    action: BPKBottomSheetAction(title: "Action", action: {}),
                    bottomSheetContent: {
                        VStack {
                            BPKText("Bottom sheet content", style: .heading2)
                            BPKText("Bottom sheet content", style: .heading4)
                            BPKText("Bottom sheet content dfgdfg dfgntasd asdasd sdd  asd asd asd adsasda")
                                .lineLimit(nil)
                            
                            BPKButton("Make Payment") {}
                                .padding()
                        }
                    },
                    rootViewController: nil)
            )
        
    }
}
