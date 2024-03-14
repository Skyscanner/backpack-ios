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
    
    @State var presentingSuccessDialogView = false
    @State var presentingWarningDialogView = false
    @State var presentingDestructiveDialogView = false
    @State var presentingImageDialogView = false
    @State var presentingFlareDialogView = false
    
    var body: some View {
        HStack {
            viewDialogs
            modalDialogs
        }
        .bpkSuccessDialogView(
            presented: $presentingSuccessDialogView,
            icon: .tick,
            title: "Title in here",
            text: "Desription that goes two lines ideally, but sometimes it can go longer",
            confirmButton: confirmButton,
            secondaryActions: BPKDialogSecondaryActions(
                secondaryButton: secondaryButton,
                linkButton: linkButton
            ),
            onTouchOutside: dismissDialogs
        )
        .bpkWarningDialogView(
            presented: $presentingWarningDialogView,
            icon: .alertAdd,
            title: "Title in here",
            text: "Description that goes two lines ideally, but sometimes it can go longer",
            confirmButton: confirmButton,
            secondaryActions: BPKDialogSecondaryActions(
                secondaryButton: secondaryButton,
                linkButton: linkButton
            ),
            onTouchOutside: dismissDialogs
        )
        .bpkDestructiveDialogView(
            presented: $presentingDestructiveDialogView,
            icon: .trash,
            title: "Title in here",
            text: "Description that goes two lines ideally, but sometimes it can go longer",
            confirmButton: BPKDialogButton("Delete", action: dismissDialogs),
            linkButton: BPKDialogButton("Cancel", action: dismissDialogs),
            onTouchOutside: dismissDialogs
        )
        .bpkImageDialogView(
            presented: $presentingImageDialogView,
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
        .bpkFlareDialogView(
            presented: $presentingFlareDialogView,
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
        BPKDialogButton("Confirmation", action: dismissDialogs)
    }
    
    private var secondaryButton: BPKDialogButton {
        BPKDialogButton("Skip", action: dismissDialogs)
    }
    
    private var linkButton: BPKDialogButton {
        BPKDialogButton("Link opitonal", action: dismissDialogs)
    }
    
    private func dismissDialogs() {
        presentingSuccessDialog = false
        presentingWarningDialog = false
        presentingDestructiveDialog = false
        presentingImageDialog = false
        presentingFlareDialog = false
        
        presentingSuccessDialogView = false
        presentingWarningDialogView = false
        presentingDestructiveDialogView = false
        presentingImageDialogView = false
        presentingFlareDialogView = false
    }
    
    var modalDialogs: some View {
        VStack {
            BPKText("As Modal")
            BPKButton("Modal Success") {
                presentingSuccessDialog.toggle()
            }
            BPKButton("Modal Warning") {
                presentingWarningDialog.toggle()
            }
            BPKButton("Modal Destructive") {
                presentingDestructiveDialog.toggle()
            }
            BPKButton("Modal Image") {
                presentingImageDialog.toggle()
            }
            BPKButton("Modal Flare") {
                presentingFlareDialog.toggle()
            }
        }
        .bpkSuccessDialog(
            presented: $presentingSuccessDialog,
            icon: .tick,
            title: "Title in here",
            text: "Desription that goes two lines ideally, but sometimes it can go longer",
            confirmButton: confirmButton,
            secondaryActions: BPKDialogSecondaryActions(
                secondaryButton: secondaryButton,
                linkButton: linkButton
            ),
            presentingController: rootViewController,
            onTouchOutside: dismissDialogs
        )
        .bpkWarningDialog(
            presented: $presentingWarningDialog,
            icon: .alertAdd,
            title: "Title in here",
            text: "Description that goes two lines ideally, but sometimes it can go longer",
            confirmButton: confirmButton,
            secondaryActions: BPKDialogSecondaryActions(
                secondaryButton: secondaryButton,
                linkButton: linkButton
            ),
            presentingController: rootViewController,
            onTouchOutside: dismissDialogs
        )
        .bpkDestructiveDialog(
            presented: $presentingDestructiveDialog,
            icon: .trash,
            title: "Title in here",
            text: "Description that goes two lines ideally, but sometimes it can go longer",
            confirmButton: BPKDialogButton("Delete", action: dismissDialogs),
            linkButton: BPKDialogButton("Cancel", action: dismissDialogs),
            presentingController: rootViewController,
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
            presentingController: rootViewController,
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
            presentingController: rootViewController,
            onTouchOutside: dismissDialogs
        )
    }
    
    var viewDialogs: some View {
        VStack {
            BPKText("As View")
            BPKButton("View Success") {
                presentingSuccessDialogView.toggle()
            }
            BPKButton("View Warning") {
                presentingWarningDialogView.toggle()
            }
            BPKButton("View Destructive") {
                presentingDestructiveDialogView.toggle()
            }
            BPKButton("View Image") {
                presentingImageDialogView.toggle()
            }
            BPKButton("View Flare") {
                presentingFlareDialogView.toggle()
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

struct DialogExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DialogExampleView()
    }
}
