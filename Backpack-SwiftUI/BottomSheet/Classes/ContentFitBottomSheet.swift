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

struct ContentFitBottomSheet<Content: View, Header: View>: View {
    let peekHeight: CGFloat?
    let header: () -> Header
    let bottomSheetContent: () -> Content
    let sheetProxy: GeometryProxy
    
    @State private var showInScrollView: Bool = false
    @State private var viewHeight: CGFloat = 0
    
    @State private var detentHeight: CGFloat = 0
    
    private var detents: Set<PresentationDetent> {
        var finalDetents: Set<PresentationDetent> = [.height(detentHeight)]
        if let peekHeight {
            finalDetents.insert(.height(peekHeight))
        }
        return finalDetents
    }
    
//    func isItScrollView() -> some View {
//        if sheetProxy.size.height + 5.0 < detentHeight {
//            print("--- Computed ---")
//            return
//                ScrollView {
//                    bottomSheetContent()
//                }
//        } else {
//            print("--- Computed1 ---")
//            return bottomSheetContent()
//        }
////        print("--- Computed ---")
////        print(sheetProxy.size.height + 5.0 < detentHeight)
////        print("--- Computed ---")
////        return sheetProxy.size.height + 5.0 < detentHeight
//    }
    
    var body: some View {
        VStack {
            header()
            if sheetProxy.size.height > UIScreen.main.bounds.height * 0.93 {
                BPKText("SCROLL")

                bottomSheetContent()
                    .background(
                        GeometryReader { reader in
                            Color.clear.onChange(of: reader.size.height, perform: { _ in
                                showInScrollView = sheetProxy.size.height + 5.0 < detentHeight
                                viewHeight = reader.size.height
                            })
                        }
                    )

            } else {
                BPKText("height: \(sheetProxy.size.height)")
                BPKText("is it true: \(sheetProxy.size.height < UIScreen.main.bounds.height)")
                
                bottomSheetContent()
                    .background(
                        GeometryReader { reader in
                            Color.clear.onChange(of: reader.size.height, perform: { _ in
                                showInScrollView = sheetProxy.size.height + 5.0 < detentHeight
                                viewHeight = reader.size.height
                            })
                        }
                    )
            }
        }
        .presentationDetents(detents)
        .presentationDragIndicator(.visible)
        .readHeight()
        .onPreferenceChange(HeightPreferenceKey.self) { height in
            if let height {
                self.detentHeight = height
            }
        }
    }
}

private struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat?
    
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}

private struct ReadHeightModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
        }
    }
    
    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}

private extension View {
    func readHeight() -> some View {
        self.modifier(ReadHeightModifier())
    }
}
