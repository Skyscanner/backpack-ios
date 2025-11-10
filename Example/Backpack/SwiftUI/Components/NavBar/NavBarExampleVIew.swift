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
    @State var canvasContrast = false
    @State var forcesCompactNavbars = false

    var body: some View {
        VStack {
            BPKSwitch(isOn: $forcesCompactNavbars, text: "Forces compact title")
            BPKButton("Default") {
                defaultNavBar.toggle()
            }
            .stretchable()
            BPKButton("Transparent") {
                transparent.toggle()
            }
            .stretchable()
            BPKButton("Surface Contrast") {
                surfaceContrast.toggle()
            }
            .stretchable()
            BPKButton("Canvas Contrast") {
                canvasContrast.toggle()
            }
            .stretchable()
        }
        .padding(.horizontal, .lg)
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
                style: .default(forcesCompactNavbars ? .inline : .large)
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
                style: .transparent(forcesCompactNavbars ? .inline : .large)
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
        .sheet(isPresented: $canvasContrast, content: {
            BPKNavigationView(
                title: "Canvas Contrast",
                leadingItems: [.init(type: .closeButton("Close"), action: {
                    canvasContrast.toggle()
                })],
                trailingItems: [
                    .init(type: .icon(.accessibility, "accessibility"), action: {}),
                    .init(type: .icon(.alertAdd, "Add"), action: {})
                ],
                style: .canvasContrast(forcesCompactNavbars ? .inline : .large)
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

struct NavBarExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarExampleView()
    }
}
