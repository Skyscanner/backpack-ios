/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2023 Skyscanner Ltd
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

struct AppSearchModalErrorView: View {
    let state: BPKAppSearchModalError
    private let imageHeight: CGFloat = 200
    private let imageWidth: CGFloat = 277
    
    var body: some View {
        VStack {
            Spacer()
            state.image
                .resizable()
                .frame(width: imageWidth, height: imageHeight)
                .padding(.bottom, 82)
                .accessibilityHidden(true)
            VStack(spacing: .base) {
                BPKText(state.title, style: .heading4)
                    .accessibilityAddTraits(.isHeader)
                BPKText(state.description, style: .footnote)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                BPKButton(state.action.text, size: .large, action: state.action.onActionSelected)
                    .stretchable()
            }
            Spacer()
        }
    }
}

struct AppSearchModalErrorView_Previews: PreviewProvider {
    static var previews: some View {
        AppSearchModalErrorView(
            state: .init(
                title: "Title",
                description: "This is the subtitle",
                action: .init( text: "Title for button", onActionSelected: { }),
                image: Image(systemName: "photo")
            )
        )
    }
}
