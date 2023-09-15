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

/// View modifier that adds a dialog to the view hierarchy.
///
/// - Parameters:
///   - isPresented: A binding to a boolean value that determines whether the dialog is presented.
///   - dialogContent: The content of the dialog.
///   - onTouchOutside: A callback that is called when the scrim is tapped.
/// - Returns: A view with the dialog added.
struct DialogContainerViewModifier<DialogContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder let dialogContent: DialogContent
    let onTouchOutside: (() -> Void)?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                ZStack {
                    Color(.scrimColor)
                        .ignoresSafeArea()
                        .onTapGesture { onTouchOutside?() }
                    HStack {
                        Spacer(minLength: .lg)
                        dialogContent
                            .frame(maxWidth: 400)
                        Spacer(minLength: .lg)
                    }
                }
                // This keeps the dialog on top of everything while animating out.
                .zIndex(.infinity)
                .transition(.opacity)
            }            
        }
        .animation(.easeIn, value: isPresented)
    }
}

struct DialogContainerViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Color(.canvasColor)
            .modifier(DialogContainerViewModifier(
                isPresented: .constant(true),
                dialogContent: {
                    BPKText("This is the content of a dialog!")
                        .background(.surfaceDefaultColor)
                },
                onTouchOutside: {}
            ))
    }
}
