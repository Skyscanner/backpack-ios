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

public extension View {

    /// Presents a bottom sheet.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the bottom sheet should be shown.
    ///   - contentMode: The content mode of the bottom sheet. Defaults to `.medium`.
    ///   - closeButtonAccessibilityLabel: The accessibility label for the close button.
    ///         If `nil`, the close button will not be shown.
    ///   - title: The title of the bottom sheet. If `nil`, the title will not be shown.
    ///   - action: The action button of the bottom sheet. If `nil`, the action button will not be shown.
    ///   - bottomSheetContent: The content of the bottom sheet.
    ///
    /// - Note: For iOS 16 users and above, the bottom sheet will be presented using
    ///         SwiftUI's native `BottomSheet` view.
    ///         For iOS 15 users and below, the bottom sheet will be presented using a custom implementation.
    @ViewBuilder
    func bpkBottomSheet<BottomSheetContent: View>(
        isPresented: Binding<Bool>,
        contentMode: BPKBottomSheetContentMode = .medium,
        closeButtonAccessibilityLabel: String? = nil,
        title: String? = nil,
        action: BPKBottomSheetAction? = nil,
        presentingController: UIViewController,
        @ViewBuilder bottomSheetContent: @escaping () -> BottomSheetContent
    ) -> some View {
        if #available(iOS 16.0, *) {
            modifier(
                BottomSheetContainerViewModifier(
                    isPresented: isPresented,
                    contentMode: contentMode,
                    header: {
                        header(
                            closeAction: closeAction(
                                closeButtonAccessibilityLabel: closeButtonAccessibilityLabel,
                                closeAction: { isPresented.wrappedValue.toggle() }
                            ),
                            title: title,
                            action: action
                        )
                    },
                    bottomSheetContent: bottomSheetContent
                )
            )
        } else {
            modifier(
                LegacyBottomSheetContainerViewModifier(
                    isPresented: isPresented,
                    contentMode: contentMode,
                    header: {
                        header(
                            closeAction: closeAction(
                                closeButtonAccessibilityLabel: closeButtonAccessibilityLabel,
                                closeAction: { isPresented.wrappedValue.toggle() }
                            ),
                            title: title,
                            action: action
                        )
                    },
                    bottomSheetContent: bottomSheetContent,
                    presentingController: presentingController
                )
            )
        }
    }
    
    @ViewBuilder
    func bpkBottomSheet<BottomSheetContent: View, Item: Identifiable>(
        item: Binding<Item?>,
        contentMode: BPKBottomSheetContentMode = .medium,
        closeButtonAccessibilityLabel: String? = nil,
        title: String? = nil,
        action: BPKBottomSheetAction? = nil,
        presentingController: UIViewController,
        @ViewBuilder bottomSheetContent: @escaping (Item) -> BottomSheetContent
    ) -> some View {
        if #available(iOS 16.0, *) {
            modifier(
                ItemBottomSheetContainerViewModifier(
                    item: item,
                    contentMode: contentMode,
                    header: {
                        header(
                            closeAction: closeAction(
                                closeButtonAccessibilityLabel: closeButtonAccessibilityLabel,
                                closeAction: { item.wrappedValue = nil }
                            ),
                            title: title,
                            action: action
                        )
                    },
                    bottomSheetContent: bottomSheetContent
                )
            )
        } else {
            modifier(
                LegacyBottomSheetContainerViewModifier(
                    isPresented: Binding(
                        get: { item.wrappedValue != nil },
                        set: { _ in item.wrappedValue = nil }
                    ),
                    contentMode: contentMode,
                    header: {
                        header(
                            closeAction: closeAction(
                                closeButtonAccessibilityLabel: closeButtonAccessibilityLabel,
                                closeAction: { item.wrappedValue = nil }
                            ),
                            title: title,
                            action: action
                        )
                    },
                    bottomSheetContent: {
                        if let itemValue = item.wrappedValue {
                            bottomSheetContent(itemValue)
                        }
                    },
                    presentingController: presentingController
                )
            )
        }
    }
    
    private func closeAction(
        closeButtonAccessibilityLabel: String?,
        closeAction: @escaping () -> Void
    ) -> BPKBottomSheetAction? {
        guard let closeButtonAccessibilityLabel else { return nil }
        return BPKBottomSheetAction(title: closeButtonAccessibilityLabel, action: closeAction)
    }
    
    @ViewBuilder
    private func header(
        closeAction: BPKBottomSheetAction?,
        title: String?,
        action: BPKBottomSheetAction?
    ) -> some View {
        if closeAction != nil || title != nil || action != nil {
            BottomSheetHeader(
                closeAction: closeAction,
                title: title,
                action: action
            )
        }
    }
}

struct BPKBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKButton("Show closeable bottom sheet") {}
                .bpkBottomSheet(
                    isPresented: .constant(true),
                    contentMode: .fitContent, closeButtonAccessibilityLabel: "asd", title: "Hello",
                    action: BPKBottomSheetAction(
                        title: "Action",
                        action: {}),
                    presentingController: UIViewController()) {
                    BPKText("Bottom sheet content")
                }
        }
    }
}
