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

struct BottomSheetContainerViewModifier<BottomSheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    let maxHeight: CGFloat
    let contentMode: BPKBottomSheetContentMode
    
    @ViewBuilder let bottomSheetContent: BottomSheetContent
    
    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isPresented ? 0 : maxHeight
    }
    
    private var handle: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color(BPKColor.lineColor))
            .frame(width: BPKSpacing.xxl, height: BPKSpacing.sm)
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                content

                if isPresented {
                    Color.black.opacity(0.7)
                }

                VStack {
                    if contentMode == .fullSize {
                        handle.padding(.md)
                    }
                    bottomSheetContent
                }
                .frame(width: geometry.size.width, height: maxHeight, alignment: .top)
                .background(BPKColor.surfaceDefaultColor)
                .cornerRadius(Constants.radius)
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
                contentMode: .fullSize,
                bottomSheetContent: {
                    VStack {
                        Spacer()
                        BPKText("Bottom sheet content")
                        Spacer()
                    }
                    
                }
            )
        )
    }
}
