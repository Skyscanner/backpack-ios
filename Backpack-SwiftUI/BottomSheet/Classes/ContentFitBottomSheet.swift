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
    let backgroundColor: BPKColor

    @State private var headerHeight: CGFloat = 0.0
    @State private var detentHeight: CGFloat = 0
    @State private var initialDetentHeight: CGFloat = 0
    @State private var windowHeight: CGFloat = 0

    // Until the window height is known, use a large uncapped value so the content
    // can size to its natural height. Once windowHeight is set, the 95% cap applies.
    private var maximumDetentHeight: CGFloat {
        windowHeight > 0 ? windowHeight * 0.95 : 10_000
    }

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
                BottomSheetDragIndicator()
                header
                    .onGeometryChange(for: CGFloat.self, of: { $0.size.height }, action: { newValue in
                        headerHeight = newValue
                    })
                ScrollView {
                    bottomSheetContent
                        .avoidKeyboard()
                }
                .frame(maxHeight: max(0, maximumDetentHeight - headerHeight))
                .fixedSize(horizontal: false, vertical: true)
            }
            .onGeometryChange(for: CGFloat.self) { geo in
                if detentHeight != initialDetentHeight && geo.size.height > maximumDetentHeight {
                    return detentHeight
                }
                return geo.size.height
            } action: { newValue in
                if initialDetentHeight == 0 {
                    initialDetentHeight = newValue
                }
                detentHeight = min(newValue, maximumDetentHeight)
            }
            .presentationDetents(detents)
            .presentationDragIndicator(.hidden)
        }
        .background(WindowHeightReader { height in windowHeight = height })
        .onChange(of: maximumDetentHeight) { newMax in
            if detentHeight > newMax {
                detentHeight = newMax
            }
        }
        .background(backgroundColor)
        .ignoresSafeArea(.keyboard)
    }
}

// Reads the presenting window's bounds height via the UIKit view hierarchy.
// Uses view.window?.bounds — Pattern A option 1 from the UIScreen.main migration guide.
// Safe in app extensions: no UIApplication.shared access.
private struct WindowHeightReader: UIViewRepresentable {
    let onHeightChange: (CGFloat) -> Void

    func makeUIView(context: Context) -> UIView { UIView() }

    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            guard let height = uiView.window?.bounds.height, height > 0 else { return }
            onHeightChange(height)
        }
    }
}
