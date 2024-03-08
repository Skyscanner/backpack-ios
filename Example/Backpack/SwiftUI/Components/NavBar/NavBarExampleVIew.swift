//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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
import Backpack_SwiftUI

struct NavBarExampleView: View {
    @State var defaultNavBar = false
    @State var transparent = false
    @State var surfaceContrast = false
    
    var body: some View {
        VStack {
            BPKButton("Default") {
                defaultNavBar.toggle()
            }
            BPKButton("Transparent") {
                transparent.toggle()
            }
            BPKButton("Surface Contrast") {
                surfaceContrast.toggle()
            }
        }
        .sheet(isPresented: $defaultNavBar, content: {
            BPKNavigationView(
                title: "Default",
                leadingItems: [.init(type: .backButton("Back"), action: {
                    defaultNavBar.toggle()
                })],
                trailingItems: [
                    .init(type: .icon(.accessibility, "accessibility"), action: {}),
                    .init(type: .icon(.alertAdd, "Add"), action: {})
                ],
                style: .default(.large)
            ) {
                sheetContent
            }
        })
        .sheet(isPresented: $transparent, content: {
            BPKNavigationView(
                title: "Transparent",
                leadingItems: [.init(type: .backButton("Back"), action: {
                    transparent.toggle()
                })],
                trailingItems: [
                    .init(type: .icon(.accessibility, "accessibility"), action: {}),
                    .init(type: .icon(.alertAdd, "Add"), action: {})
                ],
                style: .transparent(.large)
            ) {
                sheetContent
            }
        })
        .sheet(isPresented: $surfaceContrast, content: {
            BPKNavigationView(
                title: "Surface Contrast",
                leadingItems: [.init(type: .closeButton("Close"), action: {
                    surfaceContrast.toggle()
                })],
                trailingItems: [
                    .init(type: .icon(.accessibility, "accessibility"), action: {}),
                    .init(type: .icon(.alertAdd, "Add"), action: {})
                ],
                style: .surfaceContrast
            ) {
                sheetContent
            }
        })
    }
    
    private var sheetContent: some View {
        ScrollView {
            VStack {
                Image("canadian_rockies_canada")
                    .resizable()
                    .frame(width: .infinity, height: 250)
                    .bpkOverlay(.linear(.high, .top))
                Spacer()
            }
            .background(.canvasColor)
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    NavBarExampleView()
}
