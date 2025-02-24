//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

struct BottomSheetExampleView: View {
    struct ExampleItem: Identifiable {
        let id: String
        let name: String
    }
    
    @State private var peekingBottomSheetShown = false
    @State private var closableBottomSheetShown = false
    @State private var largeBottomSheetShown = false
    @State private var mediumBottomSheetShown = false
    @State private var mediumFixedBottomSheetShown = false
    @State private var fitContentBottomSheetShown = false
    @State private var itemToShow: ExampleItem?
    
    @State private var noOfItems: Int = 0

    func content(_ text: String = "Bottom sheet content") -> some View {
        VStack {
            Spacer()
            BPKText(text)
            Spacer()
        }
    }
    
    var body: some View {
        versionedButtons
            .bpkBottomSheet(
                isPresented: $closableBottomSheetShown,
                contentMode: .medium,
                closeButtonAccessibilityLabel: "Close",
                title: "Title",
                action: BPKBottomSheetAction(
                    title: "Action",
                    action: { closableBottomSheetShown.toggle() }
                ),
                presentingController: rootViewController,
                bottomSheetContent: { content() }
            )
            .bpkBottomSheet(
                isPresented: $largeBottomSheetShown,
                contentMode: .large,
                title: "Title",
                action: BPKBottomSheetAction(
                    title: "Action",
                    action: { largeBottomSheetShown.toggle() }
                ),
                presentingController: rootViewController,
                bottomSheetContent: { content() }
            )
            .bpkBottomSheet(
                isPresented: $mediumBottomSheetShown,
                contentMode: .medium,
                title: "Title",
                action: BPKBottomSheetAction(
                    title: "Action",
                    action: { mediumBottomSheetShown.toggle() }
                ),
                presentingController: rootViewController,
                bottomSheetContent: { content() }
            )
            .bpkBottomSheet(
                isPresented: $mediumFixedBottomSheetShown,
                contentMode: .medium(false),
                title: "Title",
                action: BPKBottomSheetAction(
                    title: "Action",
                    action: { mediumBottomSheetShown.toggle() }
                ),
                presentingController: rootViewController,
                bottomSheetContent: { content() }
            )
            .bpkBottomSheet(
                isPresented: $fitContentBottomSheetShown,
                contentMode: .fitContent,
                title: "Title",
                action: BPKBottomSheetAction(
                    title: "Action",
                    action: { fitContentBottomSheetShown.toggle() }
                ),
                presentingController: rootViewController,
                bottomSheetContent: {
                    VStack {
                        ForEach(0..<noOfItems, id: \.self) { _ in
                            Text("Hello, World!")
                        }
                        
                        BPKButton("Add one") {
                            noOfItems += 1
                        }
                        
                        BPKButton("Do Action") {
                            noOfItems -= 1
                        }
                    }
                    .padding()
                }
            )
    }
    
    @ViewBuilder
    var versionedButtons: some View {
        if #available(iOS 16.4, *) {
            buttons
                .bpkBottomSheet(
                    isPresented: $peekingBottomSheetShown,
                    peekHeight: 120,
                    bottomSheetContent: { content() }
                )
        } else {
            buttons
        }
    }
    
    var buttons: some View {
        VStack {
            BPKButton("Show closable bottom sheet") {
                closableBottomSheetShown.toggle()
            }
            BPKButton("Show peeking bottom sheet") {
                peekingBottomSheetShown.toggle()
            }
            BPKButton("Show large bottom sheet") {
                largeBottomSheetShown.toggle()
            }
            BPKButton("Show medium bottom sheet") {
                mediumBottomSheetShown.toggle()
            }
            BPKButton("Show medium bottom sheet (fixed)") {
                mediumFixedBottomSheetShown.toggle()
            }
            BPKButton("Show fit content bottom sheet") {
                fitContentBottomSheetShown.toggle()
            }
            BPKButton("Show content with item") {
                itemToShow = .init(id: "1", name: "Fight to London")
            }
            .bpkBottomSheet(item: $itemToShow, presentingController: rootViewController) { item in
                content(item.name)
            }
        }
    }
    
    private var rootViewController: UIViewController {
        UIApplication.shared
            .windows
            .filter { $0.isKeyWindow }
            .first?
            .rootViewController ?? UIViewController()
    }
}

struct BottomSheetExampleView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetExampleView()
    }
}
