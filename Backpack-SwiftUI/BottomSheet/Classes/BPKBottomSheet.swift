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
        isPresented: Binding<Bool> = .constant(false),
        isClosable: Bool = true,
        closeButtonAccessibilityLabel: String? = nil,
        title: String? = nil,
        action: BPKBottomSheetAction? = nil,
        contentMode: BPKBottomSheetContentMode = .regular,
        @ViewBuilder bottomSheetContent: () -> BottomSheetContent
    ) -> some View {
        modifier(
            BottomSheetContainerViewModifier(
                isPresented: isPresented,
                bottomSheetContent: {
                    BPKBottomSheetContent(
                        isPresented: isPresented,
                        isClosable: isClosable,
                        closeButtonAccessibilityLabel: closeButtonAccessibilityLabel,
                        title: title,
                        contentMode: contentMode,
                        action: action) { bottomSheetContent() }
                })
        )
    }
}

struct BPKBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        Button("Show bottom sheet") {}
            .bpkBottomSheet(isPresented: .constant(true), isClosable: false) {
            Text("Bottom sheet content")
        }
    }
}
