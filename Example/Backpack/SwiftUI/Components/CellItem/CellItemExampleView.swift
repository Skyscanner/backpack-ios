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
import Backpack_SwiftUI

struct CellItemExampleView: View {
    @State private var notificationsEnabled = true

    var body: some View {
        ScrollView {
            VStack(spacing: .md) {
                // Basic examples
                sectionHeader("Basic")
                BPKCellItem(title: "Settings")
                BPKCellItem(
                    title: "Notifications",
                    body: "Manage your notification preferences"
                )
                BPKCellItem(
                    title: "Account",
                    body: "View and edit your profile",
                    icon: .accountCircle
                )

                // Slot examples
                sectionHeader("Slot Types")
                BPKCellItem(
                    title: "Account Settings",
                    icon: .settings,
                    slot: .chevron,
                    onClick: {}
                )
                BPKCellItem(
                    title: "Push Notifications",
                    icon: .alertActive,
                    slot: .switch(isOn: $notificationsEnabled)
                )
                BPKCellItem(
                    title: "Language",
                    slot: .text("English")
                )
                BPKCellItem(
                    title: "Privacy Policy",
                    slot: .link(text: "View", url: "https://skyscanner.net/privacy") { _ in }
                )
                BPKCellItem(
                    title: "Partner Airlines",
                    slot: .image(Image(systemName: "star.fill"))
                )

                // Styling examples
                sectionHeader("Styling")
                BPKCellItem(
                    title: "Surface Low Contrast",
                    style: .surfaceLowContrast
                )
                BPKCellItem(
                    title: "Rounded Corners",
                    corner: .rounded
                )
                BPKCellItem(
                    title: "Combined Styling",
                    body: "Low contrast with rounded corners",
                    icon: .star,
                    style: .surfaceLowContrast,
                    corner: .rounded,
                    slot: .chevron
                )
            }
            .padding(.base)
            .background(.canvasContrastColor)
        }
    }

    @ViewBuilder
    private func sectionHeader(_ title: String) -> some View {
        HStack {
            BPKText(title, style: .heading4)
            Spacer()
        }
        .padding(.top, .md)
    }
}

struct CellItemExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CellItemExampleView()
    }
}
