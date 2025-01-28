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
    
    /// Presents a bottom sheet that, unless manually toggling the `isPresented` property, this sheet
    /// will not be dismissed when dragging down.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the bottom sheet should be shown.
    ///   - peekHeight: The height of the sheet when it is peeking the screen.
    ///   - contentMode: The content mode of the bottom sheet. Defaults to `.medium`.
    ///   - closeButtonAccessibilityLabel: The accessibility label for the close button.
    ///         If `nil`, the close button will not be shown.
    ///   - title: The title of the bottom sheet. If `nil`, the title will not be shown.
    ///   - action: The action button of the bottom sheet. If `nil`, the action button will not be shown.
    ///   - bottomSheetContent: The content of the bottom sheet.
    @available(iOS 16.4, *)
    @ViewBuilder
    func bpkBottomSheet<BottomSheetContent: View>(
        isPresented: Binding<Bool>,
        peekHeight: CGFloat,
        contentMode: BPKBottomSheetContentMode = .medium,
        closeButtonAccessibilityLabel: String? = nil,
        title: String? = nil,
        action: BPKBottomSheetAction? = nil,
        @ViewBuilder bottomSheetContent: @escaping () -> BottomSheetContent
    ) -> some View {
        modifier(
            BottomSheetContainerViewModifier(
                isPresented: isPresented,
                peekHeight: peekHeight,
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
                bottomSheetContent: {
                    bottomSheetContent()
                        .interactiveDismissDisabled()
                        .presentationBackgroundInteraction(PresentationBackgroundInteraction.enabled)
                }
            )
        )
    }
    
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
        modifier(
            BottomSheetContainerViewModifier(
                isPresented: isPresented,
                peekHeight: nil,
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
    }
    
    /// Presents a bottom sheet that, unless manually setting the `item` property to nil, this sheet
    /// will not be dismissed when dragging down.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the sheet.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure.
    ///   - peekHeight: The height of the sheet when it is peeking the screen.
    ///   - contentMode: The content mode of the bottom sheet. Defaults to `.medium`.
    ///   - closeButtonAccessibilityLabel: The accessibility label for the close button.
    ///         If `nil`, the close button will not be shown.
    ///   - title: The title of the bottom sheet. If `nil`, the title will not be shown.
    ///   - action: The action button of the bottom sheet. If `nil`, the action button will not be shown.
    ///   - bottomSheetContent: The content of the bottom sheet.
    @available(iOS 16.4, *)
    @ViewBuilder
    func bpkBottomSheet<BottomSheetContent: View, Item: Identifiable>(
        item: Binding<Item?>,
        peekHeight: CGFloat,
        contentMode: BPKBottomSheetContentMode = .medium,
        closeButtonAccessibilityLabel: String? = nil,
        title: String? = nil,
        action: BPKBottomSheetAction? = nil,
        presentingController: UIViewController,
        @ViewBuilder bottomSheetContent: @escaping (Item) -> BottomSheetContent
    ) -> some View {
        modifier(
            ItemBottomSheetContainerViewModifier(
                item: item,
                peekHeight: peekHeight,
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
                bottomSheetContent: { item in
                    bottomSheetContent(item)
                        .interactiveDismissDisabled()
                        .presentationBackgroundInteraction(PresentationBackgroundInteraction.enabled)
                }
            )
        )
    }
    
    /// Presents a bottom sheet.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the sheet.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure.
    ///   - contentMode: The content mode of the bottom sheet. Defaults to `.medium`.
    ///   - closeButtonAccessibilityLabel: The accessibility label for the close button.
    ///         If `nil`, the close button will not be shown.
    ///   - title: The title of the bottom sheet. If `nil`, the title will not be shown.
    ///   - action: The action button of the bottom sheet. If `nil`, the action button will not be shown.
    ///   - bottomSheetContent: The content of the bottom sheet.
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
        modifier(
            ItemBottomSheetContainerViewModifier(
                item: item,
                peekHeight: nil,
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
