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
    var isExpanded = false
    var trailingSafeAreaInset: CGFloat = 0

    private var actionVerticalOffset: CGFloat {
        // The expanded sheet's trailing safe area contains the side status items.
        // Place the action below them while keeping the sheet content in the safe area.
        isExpanded ? trailingSafeAreaInset * 2 : 0
    }
    
    var body: some View {
        ZStack {
            if let title {
                BPKText(title, style: .heading5)
                    .offset(x: trailingSafeAreaInset / 2)
            }
            HStack {
                if let closeAction {
                    BPKCloseButton(accessibilityLabel: closeAction.title, action: closeAction.action)
                }
                Spacer(minLength: 0)
                if let action {
                    BPKButton(action.title, action: action.action)
                        .buttonStyle(.link)
                        .offset(x: trailingSafeAreaInset, y: actionVerticalOffset)
                }
            }
        }
        .frame(maxWidth: .infinity)
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
