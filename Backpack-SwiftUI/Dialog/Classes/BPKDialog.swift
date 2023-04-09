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

public extension View {
    func bpkSuccessDialog(
        presented: Binding<Bool>,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryButton: BPKDialogButton? = nil,
        linkButton: BPKDialogButton? = nil,
        onTouchOutside: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryButton {
            buttons.append(BPKDialogButton(button: secondaryButton, style: .secondary))
        }
        if let linkButton {
            buttons.append(BPKDialogButton(button: linkButton, style: .link))
        }
        return self.modifier(DialogContainerViewModifier(isPresented: presented, dialogContent: {
            DialogWithIconContent(
                icon: .tick,
                iconColor: .coreAccentColor,
                textContent: DialogTextContent(title: title, text: text, contentAlignment: .center),
                actions: DialogActionsView(buttons: buttons)
            )
        }, onTouchOutside: onTouchOutside))
    }
    
    func bpkWarningDialog(
        presented: Binding<Bool>,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryButton: BPKDialogButton? = nil,
        linkButton: BPKDialogButton? = nil,
        onTouchOutside: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryButton {
            buttons.append(BPKDialogButton(button: secondaryButton, style: .secondary))
        }
        if let linkButton {
            buttons.append(BPKDialogButton(button: linkButton, style: .link))
        }
        return self.modifier(DialogContainerViewModifier(isPresented: presented, dialogContent: {
            DialogWithIconContent(
                icon: .alertAdd,
                iconColor: .statusWarningSpotColor,
                textContent: DialogTextContent(title: title, text: text, contentAlignment: .center),
                actions: DialogActionsView(buttons: buttons)
            )
        }, onTouchOutside: onTouchOutside))
    }
    
    func bpkDestructiveDialog(
        presented: Binding<Bool>,
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
                icon: .trash,
                iconColor: .statusDangerSpotColor,
                textContent: DialogTextContent(title: title, text: text, contentAlignment: .center),
                actions: DialogActionsView(buttons: buttons)
            )
        }, onTouchOutside: onTouchOutside))
    }
    
    func bpkImageDialog(
        presented: Binding<Bool>,
        image: Image,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryButton: BPKDialogButton? = nil,
        linkButton: BPKDialogButton? = nil,
        onTouchOutside: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryButton {
            buttons.append(BPKDialogButton(button: secondaryButton, style: .secondary))
        }
        if let linkButton {
            buttons.append(BPKDialogButton(button: linkButton, style: .link))
        }
        return self.modifier(DialogContainerViewModifier(isPresented: presented, dialogContent: {
            DialogWithHeaderContent(
                textContent: DialogTextContent(title: title, text: text, contentAlignment: .leading)
                    .spacing(.md),
                actions: DialogActionsView(buttons: buttons)
            ) { DialogImageView(image: image) }
        }, onTouchOutside: onTouchOutside))
    }
    
    func bpkFlareDialog(
        presented: Binding<Bool>,
        image: Image,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryButton: BPKDialogButton? = nil,
        linkButton: BPKDialogButton? = nil,
        onTouchOutside: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryButton {
            buttons.append(BPKDialogButton(button: secondaryButton, style: .secondary))
        }
        if let linkButton {
            buttons.append(BPKDialogButton(button: linkButton, style: .link))
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

struct BPKDialog_Previews: PreviewProvider {
    static var previews: some View {
        Color(.canvasColor)
            .bpkSuccessDialog(
                presented: .constant(true),
                title: "Title in here",
                text: "Description that goes two lines ideally, but sometimes it can go longer",
                confirmButton: .init("Delete", action: {})
            )
    }
}
