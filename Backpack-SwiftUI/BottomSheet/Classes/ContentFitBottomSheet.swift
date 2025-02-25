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
    let sheetProxy: CGSize
    
    @State private var showInScroll: Bool = false
    @State private var scrollViewSize: CGSize = .zero
    @State private var isPanelInitialising: Bool = true
    
    @State private var detentHeight: CGFloat = 0
    
    private var detents: Set<PresentationDetent> {
        var finalDetents: Set<PresentationDetent> = [.height(detentHeight)]
        if let peekHeight {
            finalDetents.insert(.height(peekHeight))
        }
        return finalDetents
    }
    
    var body: some View {
        VStack {
            header()
            bottomSheetContent()
                .onGeometryChange(for: CGSize.self, of: { $0.size }, action: {
                    if showInScroll && $0.height < scrollViewSize.height {
                        showInScroll = false
                    }
                })
                .onChange(of: sheetProxy, perform: {
                    if $0.height != 0.0 {
                        showInScroll = $0.height < detentHeight
                    }
                })
                .if(showInScroll, transform: { view in
                    ViewThatFits {
                        ScrollView {
                            view
                        }
                    }.onGeometryChange(for: CGSize.self, of: { $0.size }, action: { scrollViewSize = $0 })
                })
                .presentationDetents(detents)

        }
        .presentationDragIndicator(.visible)
        .onGeometryChange(for: CGSize.self, of: { $0.size }, action: {
            detentHeight = $0.height
        })
    }
}
