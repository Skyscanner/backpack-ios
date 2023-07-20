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
    @ViewBuilder let bottomSheetContent: BottomSheetContent
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                if #available(iOS 16.0, *) {
                    VStack {
                        bottomSheetContent
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }
                } else {
                    bottomSheetContent
                }
            }
    }
}

struct BottomSheetContainerViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        BPKButton("Show bottom sheet", action: {})
            .modifier(
                BottomSheetContainerViewModifier(
                    isPresented: .constant(true),
                    bottomSheetContent: {
                        BPKText("Hello")
                    }
                )
            )
    }
}
