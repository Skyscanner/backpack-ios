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

enum BottomSheetContentViewContentMode {
    case large(maxHeight: CGFloat)
    case medium(minHeight: CGFloat, maxHeight: CGFloat)

    var minHeight: CGFloat {
        switch self {
        case .large(let height):
            return height
        case .medium(let height, _):
            return height
        }
    }
    
    var maxHeight: CGFloat {
        switch self {
        case .large(let height):
            return height
        case .medium(_, let height):
            return height
        }
    }
}

struct LegacyBottomSheetContentView<Header: View, Content: View>: View {
    private let snapRatio: CGFloat = 0.5
    
    @Binding var isPresented: Bool
    @GestureState var translation: CGFloat = 0
    @State var offset: CGFloat
    
    let contentMode: BottomSheetContentViewContentMode
    
    let minHeight: CGFloat
    let maxHeight: CGFloat
    
    let header: () -> Header
    let bottomSheetContent: () -> Content
    
    init(
        isPresented: Binding<Bool>,
        contentMode: BottomSheetContentViewContentMode,
        header: @escaping () -> Header,
        bottomSheetContent: @escaping () -> Content
    ) {
        _isPresented = isPresented
        
        self.contentMode = contentMode
        minHeight = contentMode.minHeight
        maxHeight = contentMode.maxHeight
        offset = maxHeight
        self.header = header
        self.bottomSheetContent = bottomSheetContent
    }
    
    var body: some View {
        let currentSize = max(maxHeight - offset - translation, minHeight)
        VStack(spacing: BPKSpacing.none) {
            ZStack(alignment: .top) {
                handle.padding(.top, .md)
                header()
            }
            bottomSheetContent()
                .frame(maxWidth: .infinity)
                .if(maxHeight > 0, transform: { sheetContent in
                    sheetContent
                        .frame(maxHeight: maxHeight)
                        .frame(minHeight: minHeight)
                        .frame(height: currentSize)
                })
        }
        .background(BPKColor.surfaceDefaultColor)
        .clipShape(.bottomSheet)
        .offset(y: verticalOffset(currentSize: currentSize))
        .animation(.interactiveSpring(), value: isPresented)
        .animation(.interactiveSpring(), value: offset)
        .animation(.interactiveSpring(), value: translation)
        .gesture(dragGesture)
        .onChange(of: isPresented, perform: onPresentedChanged)
    }
    
    private func verticalOffset(currentSize: CGFloat) -> CGFloat {
        guard isPresented else {
            return maxHeight + minHeight
        }
        guard currentSize - translation < minHeight else { return 0 }
        return translation
    }
    
    private var handle: some View {
        Color(BPKColor.lineColor)
            .clipShape(Capsule())
            .frame(width: BPKSpacing.xxl, height: BPKSpacing.sm)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($translation, body: { value, state, _ in
                if offset == 0, value.translation.height < 0 { return }
                state = value.translation.height
            })
            .onEnded({ value in
                var snapDistance = minHeight
                if case .medium = contentMode {
                    if offset != 0 {
                        snapDistance = minHeight * snapRatio
                    }
                    offset = value.translation.height > 0 ? minHeight : 0
                }
                
                if value.translation.height > snapDistance {
                    withAnimation {
                        isPresented = false
                    }
                }
            })
    }
    
    private func onPresentedChanged(_ value: Bool) {
        withAnimation {
            guard value else {
                offset = maxHeight
                return
            }
            if case .medium = contentMode {
                offset = minHeight
            } else {
                offset = 0
            }
        }
    }
}

struct BottomSheetContentView_Previews: PreviewProvider {
    private static var large: some View {
        LegacyBottomSheetContentView(
            isPresented: .constant(false),
            contentMode: .large(maxHeight: 200),
            header: {
                BPKText("Large")
                    .padding()
            },
            bottomSheetContent: {
                VStack {
                    BPKText("Hi")
                    Spacer()
                    BPKText("Hi again")
                }
            }
        )
    }
    
    private static var medium: some View {
        LegacyBottomSheetContentView(
            isPresented: .constant(false),
            contentMode: .medium(minHeight: 100, maxHeight: 200),
            header: {
                BPKText("Hello")
                    .padding()
            },
            bottomSheetContent: {
                VStack {
                    BPKText("Hi")
                    Spacer()
                    BPKText("Hi again")
                }
            }
        )
    }
    
    static var previews: some View {
        ZStack {
            large
            medium
        }
    }
}
