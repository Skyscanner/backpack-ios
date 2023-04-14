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

/// Dialog that can display a custom header view.
struct DialogWithHeaderContent<HeaderView: View>: View {
    let textContent: DialogTextContent
    let actions: DialogActionsView
    @ViewBuilder let headerView: HeaderView
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            VStack(spacing: BPKSpacing.lg.value) {
                textContent
                actions
            }
            .padding(.lg)
        }
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .md))
        .shadow(.lg)
    }
}

struct DialogWithHeaderContent_Previews: PreviewProvider {
    static var previews: some View {
        DialogWithHeaderContent(
            textContent: DialogTextContent(
                title: "Title in here",
                text: "Description that goes two lines ideally, but sometimes it can go longer",
                contentAlignment: .leading
            ),
            actions: DialogActionsView(buttons: [
                BPKDialogButton("Confirm", .featured, action: {}),
                BPKDialogButton("Skip", .secondary, action: {}),
                BPKDialogButton("More info", .link, action: {})
            ])
        ) {
            Color(.coreAccentColor)
        }
    }
}
