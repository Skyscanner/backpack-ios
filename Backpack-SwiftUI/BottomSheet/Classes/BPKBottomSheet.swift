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
    
    func bpkBottomSheet<BottomSheetContent: View>(
        isPresented: Binding<Bool>,
        maxHeight: CGFloat,
        contentMode: BPKBottomSheetContentMode = .regular,
        @ViewBuilder bottomSheetContent: () -> BottomSheetContent
    ) -> some View {
        modifier(
            BottomSheetContainerViewModifier(
                isPresented: isPresented,
                maxHeight: maxHeight,
                contentMode: contentMode,
                isClosable: false,
                bottomSheetContent: { bottomSheetContent() }
            )
        )
    }
    
    // swiftlint:disable:next function_parameter_count
    func bpkCloseableBottomSheet<BottomSheetContent: View>(
        isPresented: Binding<Bool>,
        maxHeight: CGFloat,
        contentMode: BPKBottomSheetContentMode = .regular,
        closeButtonAccessibilityLabel: String,
        title: String,
        action: BPKBottomSheetAction,
        @ViewBuilder bottomSheetContent: () -> BottomSheetContent
    ) -> some View {
        modifier(
            BottomSheetContainerViewModifier(
                isPresented: isPresented,
                maxHeight: maxHeight,
                contentMode: contentMode,
                isClosable: true,
                closeButtonAccessibilityLabel: closeButtonAccessibilityLabel,
                title: title,
                action: action,
                bottomSheetContent: { bottomSheetContent() }
            )
        )
    }
}

struct BPKBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKButton("Show closeable bottom sheet") {}
                .bpkBottomSheet(isPresented: .constant(true), maxHeight: 400) {
                    BPKText("Bottom sheet content")
                }
        }
    }
}
