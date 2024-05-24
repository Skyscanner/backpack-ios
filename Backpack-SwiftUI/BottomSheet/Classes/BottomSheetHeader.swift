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

struct BottomSheetHeader: View {
    let closeAction: BPKBottomSheetAction?
    let title: String?
    let action: BPKBottomSheetAction?
    
    @ViewBuilder
    private var closeButtonView: some View {
        if let closeAction {
            Spacer()
                .overlay(
                    BPKCloseButton(accessibilityLabel: closeAction.title, action: closeAction.action),
                    alignment: .leading
                )
        } else {
            Spacer()
        }
    }
    
    @ViewBuilder
    private var actionView: some View {
        if let action {
            Spacer()
                .overlay(
                    BPKButton(action.title, action: action.action)
                        .buttonStyle(.link),
                    alignment: .trailing
                )
        } else {
            Spacer()
        }
    }
    
    var body: some View {
        HStack {
            closeButtonView
            if let title {
                BPKText(title, style: .heading5)
            }
            actionView
        }
        .padding(.lg)
    }
}

struct BottomSheetHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BottomSheetHeader(
                closeAction: BPKBottomSheetAction(title: "a11y", action: {}),
                title: "Some Title",
                action: BPKBottomSheetAction(title: "Action", action: {})
            )
            BottomSheetHeader(
                closeAction: nil,
                title: "Some Title",
                action: nil
            )
        }
    }
}
