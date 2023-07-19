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

/// Dialog view with an icon header.
struct DialogWithIconContent: View {
    let icon: BPKIcon
    let iconColor: BPKColor
    var textContent: DialogTextContent
    var actions: DialogActionsView
    
    var body: some View {
        VStack(spacing: 0) {
            DialogIconHeaderView(icon: icon, color: iconColor)
                .padding(.bottom, -30)
            VStack(spacing: BPKSpacing.lg.value) {
                textContent
                actions
            }
            .padding(.lg)
            .padding(.top, 12)
            .background(.surfaceDefaultColor)
            .clipShape(RoundedRectangle(cornerRadius: .md))
            .shadow(.lg)
        }
    }
}

private struct DialogIconHeaderView: View {
    let icon: BPKIcon
    let color: BPKColor
    
    var body: some View {
        ZStack {
            Color(color)
                .clipShape(Circle())
                .padding(4)
            BPKIconView(icon, size: .large)
                .foregroundColor(.textPrimaryInverseColor)
        }
        .zIndex(1)
        .frame(width: 64, height: 64)
        .background(.surfaceDefaultColor)
        .clipShape(Circle())
        .accessibilityHidden(true)
    }
}

struct DialogWithIconContent_Previews: PreviewProvider {
    static var previews: some View {
        DialogWithIconContent(
            icon: .trash,
            iconColor: .statusDangerSpotColor,
            textContent: DialogTextContent(
                title: "Title in here",
                text: "Description that goes two lines ideally, but sometimes it can go longer",
                contentAlignment: .center
            ),
            actions: DialogActionsView(buttons: [
                BPKDialogButton("Confirm", .featured, action: {}),
                BPKDialogButton("Skip", .secondary, action: {}),
                BPKDialogButton("More info", .link, action: {})
            ])
        )
    }
}
