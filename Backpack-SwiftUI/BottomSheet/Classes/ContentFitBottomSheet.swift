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
    let header: Header
    let bottomSheetContent: Content
    
    @State var headerHeight: CGFloat = 0.0
    @State private var detentHeight: CGFloat = 0
    @State private var initialDetentHeight: CGFloat = 0
    private let maximumDetentHeight: CGFloat = UIScreen.main.bounds.height * 0.95
    
    private var detents: Set<PresentationDetent> {
        var finalDetents: Set<PresentationDetent> = [.height(detentHeight)]
        if let peekHeight {
            finalDetents.insert(.height(peekHeight))
        }
        return finalDetents
    }
    
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: BPKSpacing.none) {
                header
                    .onGeometryChange(for: CGFloat.self, of: { $0.size.height }, action: { newValue in
                        headerHeight = newValue
                    })
                ScrollView {
                    bottomSheetContent
                        .avoidKeyboard()
                }
                .frame(maxHeight: maximumDetentHeight - headerHeight)
                .fixedSize(horizontal: false, vertical: true)
            }
            .onGeometryChange(for: CGFloat.self) { geometry in
                if detentHeight != initialDetentHeight && geometry.size.height > maximumDetentHeight {
                    return detentHeight
                }
                return geometry.size.height
            } action: { newValue in
                if initialDetentHeight == 0 {
                    initialDetentHeight = newValue
                }
                detentHeight = newValue
            }
            .presentationDetents(detents)
            .presentationDragIndicator(.visible)
        }
        .ignoresSafeArea(.keyboard)
    }
}
