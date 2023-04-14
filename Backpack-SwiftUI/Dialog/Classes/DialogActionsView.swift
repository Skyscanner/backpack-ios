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

/// View that displays a list of buttons in a vertical stack for use in a dialog.
struct DialogActionsView: View {
    let buttons: [BPKDialogButton]
    
    var body: some View {
        VStack(spacing: BPKSpacing.md.value) {
            ForEach(buttons, id: \.title) { button in
                BPKButton(button.title, size: .large, action: button.action)
                    .buttonStyle(button.style)
                    .stretchable()
            }
        }
    }
}

struct DialogActionsView_Previews: PreviewProvider {
    static var previews: some View {
        DialogActionsView(
            buttons: [
                BPKDialogButton("Confirm", .featured, action: {}),
                BPKDialogButton("Skip", .secondary, action: {}),
                BPKDialogButton("More info", .link, action: {})
            ]
        )
    }
}
