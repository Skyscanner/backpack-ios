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

/// This extension provides a set of convenience methods to display a dialog that works as a view.
/// It's usage is discouraged in favour of the `BPKDialog` view. Usage of this view should be limited to cases where
/// presenting a new view controller is not possible. (`BPKDialog` uses a view controller to present the dialog
/// behind the scenes).
public extension View {
    /// Displays a success dialog with a title, text and a list of buttons.
    func bpkSuccessDialogView(
        presented: Binding<Bool>,
        icon: BPKIcon,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryActions: BPKDialogSecondaryActions? = nil,
        onTouchOutside: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryActions {
            buttons.append(BPKDialogButton(button: secondaryActions.secondaryButton, style: .secondary))
            if let linkButton = secondaryActions.linkButton {
                buttons.append(BPKDialogButton(button: linkButton, style: .link))
            }
        }
        return self.modifier(DialogContainerViewModifier(isPresented: presented, dialogContent: {
            DialogWithIconContent(
                icon: icon,
                iconColor: .coreAccentColor,
                textContent: DialogTextContent(title: title, text: text, contentAlignment: .center),
                actions: DialogActionsView(buttons: buttons)
            )
        }, onTouchOutside: onTouchOutside))
    }
    
    /// Displays a warning dialog with a title, text and a list of buttons.
    func bpkWarningDialogView(
        presented: Binding<Bool>,
        icon: BPKIcon,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryActions: BPKDialogSecondaryActions? = nil,
        onTouchOutside: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryActions {
            buttons.append(BPKDialogButton(button: secondaryActions.secondaryButton, style: .secondary))
            if let linkButton = secondaryActions.linkButton {
                buttons.append(BPKDialogButton(button: linkButton, style: .link))
            }
        }
        return self.modifier(DialogContainerViewModifier(isPresented: presented, dialogContent: {
            DialogWithIconContent(
                icon: icon,
                iconColor: .statusWarningSpotColor,
                textContent: DialogTextContent(title: title, text: text, contentAlignment: .center),
                actions: DialogActionsView(buttons: buttons)
            )
        }, onTouchOutside: onTouchOutside))
    }
    
    /// Displays a destructive dialog with a title, text and a list of buttons.
    func bpkDestructiveDialogView(
        presented: Binding<Bool>,
        icon: BPKIcon,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        linkButton: BPKDialogButton? = nil,
        onTouchOutside: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .destructive)]
        if let linkButton {
            buttons.append(BPKDialogButton(button: linkButton, style: .link))
        }
        return self.modifier(DialogContainerViewModifier(isPresented: presented, dialogContent: {
            DialogWithIconContent(
                icon: icon,
                iconColor: .statusDangerSpotColor,
                textContent: DialogTextContent(title: title, text: text, contentAlignment: .center),
                actions: DialogActionsView(buttons: buttons)
            )
        }, onTouchOutside: onTouchOutside))
    }
    
    /// Displays a dialog with an image, title, text and a list of buttons.
    func bpkImageDialogView(
        presented: Binding<Bool>,
        image: Image,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryActions: BPKDialogSecondaryActions? = nil,
        onTouchOutside: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryActions {
            buttons.append(BPKDialogButton(button: secondaryActions.secondaryButton, style: .secondary))
            if let linkButton = secondaryActions.linkButton {
                buttons.append(BPKDialogButton(button: linkButton, style: .link))
            }
        }
        return self.modifier(DialogContainerViewModifier(isPresented: presented, dialogContent: {
            DialogWithHeaderContent(
                textContent: DialogTextContent(title: title, text: text, contentAlignment: .leading)
                    .spacing(.md),
                actions: DialogActionsView(buttons: buttons)
            ) { DialogImageView(image: image) }
        }, onTouchOutside: onTouchOutside))
    }
    
    /// Displays a dialog with an image with a flare, title, text and a list of buttons.
    func bpkFlareDialogView(
        presented: Binding<Bool>,
        image: Image,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryActions: BPKDialogSecondaryActions? = nil,
        onTouchOutside: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryActions {
            buttons.append(BPKDialogButton(button: secondaryActions.secondaryButton, style: .secondary))
            if let linkButton = secondaryActions.linkButton {
                buttons.append(BPKDialogButton(button: linkButton, style: .link))
            }
        }
        return self.modifier(DialogContainerViewModifier(isPresented: presented, dialogContent: {
            DialogWithHeaderContent(
                textContent: DialogTextContent(title: title, text: text, contentAlignment: .center),
                actions: DialogActionsView(buttons: buttons)
            ) {
                BPKFlareView(roundedCorners: false) {
                    DialogImageView(image: image)
                }
            }
        }, onTouchOutside: onTouchOutside))
    }
}

struct BPKDialogView_Previews: PreviewProvider {
    static var previews: some View {
        Color(.canvasColor)
            .bpkSuccessDialogView(
                presented: .constant(true),
                icon: .tick,
                title: "Title in here",
                text: "Description that goes two lines ideally, but sometimes it can go longer",
                confirmButton: .init("Delete", action: {})
            )
    }
}
