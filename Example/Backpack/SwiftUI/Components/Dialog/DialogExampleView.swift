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

struct DialogExampleView: View {
    @State var presentingSuccessDialog = false
    @State var presentingWarningDialog = false
    @State var presentingDestructiveDialog = false
    @State var presentingImageDialog = false
    @State var presentingFlareDialog = false
    
    var body: some View {
        VStack {
            BPKButton("Open Success") {
                presentingSuccessDialog.toggle()
            }
            BPKButton("Open Warning") {
                presentingWarningDialog.toggle()
            }
            BPKButton("Open Destructive") {
                presentingDestructiveDialog.toggle()
            }
            BPKButton("Open Image") {
                presentingImageDialog.toggle()
            }
            BPKButton("Open Flare") {
                presentingFlareDialog.toggle()
            }
        }
        .bpkSuccessDialog(
            presented: $presentingSuccessDialog,
            icon: .tick,
            title: "Success Dialog!",
            text: "You have successfully completed this task. You can now continue to the next step.",
            confirmButton: confirmButton,
            secondaryActions: BPKDialogSecondaryActions(
                secondaryButton: secondaryButton,
                linkButton: linkButton
            ),
            onTouchOutside: dismissDialogs
        )
        .bpkWarningDialog(
            presented: $presentingWarningDialog,
            icon: .alertAdd,
            title: "Warning Dialog!",
            text: "You have not completed this task. Continuing will result in losing your progress.",
            confirmButton: confirmButton,
            secondaryActions: BPKDialogSecondaryActions(
                secondaryButton: secondaryButton,
                linkButton: linkButton
            ),
            onTouchOutside: dismissDialogs
        )
        .bpkDestructiveDialog(
            presented: $presentingDestructiveDialog,
            icon: .trash,
            title: "Destructive Dialog!",
            text: "You're about to delete this item. This action cannot be undone.",
            confirmButton: confirmButton,
            linkButton: linkButton,
            onTouchOutside: dismissDialogs
        )
        .bpkImageDialog(
            presented: $presentingImageDialog,
            image: Image("dialog_image"),
            title: "Image Dialog!",
            text: "You're about to delete this item. This action cannot be undone.",
            confirmButton: confirmButton,
            secondaryActions: BPKDialogSecondaryActions(
                secondaryButton: secondaryButton,
                linkButton: linkButton
            ),
            onTouchOutside: dismissDialogs
        )
        .bpkFlareDialog(
            presented: $presentingFlareDialog,
            image: Image("dialog_flare"),
            title: "Flare Dialog!",
            text: "You're about to delete this item. This action cannot be undone.",
            confirmButton: confirmButton,
            secondaryActions: BPKDialogSecondaryActions(
                secondaryButton: secondaryButton,
                linkButton: linkButton
            ),
            onTouchOutside: dismissDialogs
        )
    }
    
    private var confirmButton: BPKDialogButton {
        BPKDialogButton("Continue", action: dismissDialogs)
    }
    
    private var secondaryButton: BPKDialogButton {
        BPKDialogButton("Cancel", action: dismissDialogs)
    }
    
    private var linkButton: BPKDialogButton {
        BPKDialogButton("Learn more", action: dismissDialogs)
    }
    
    private func dismissDialogs() {
        presentingSuccessDialog = false
        presentingWarningDialog = false
        presentingDestructiveDialog = false
        presentingImageDialog = false
        presentingFlareDialog = false
    }
}

struct DialogExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DialogExampleView()
    }
}
