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

struct ImageGalleryHeader: View {
    /// Apple's minimum touch target.
    private static let touchTarget: CGFloat = 44
    /// How far the 44 pt touch target reaches past the 32 pt the Close button takes in the layout, on each side.
    private static let touchTargetOutset: CGFloat = 6

    let closeAccessibilityLabel: String
    let onCloseTapped: () -> Void

    var body: some View {
        HStack {
            Button(action: onCloseTapped, label: {
                BPKIconView(.close, size: .large)
                    .foregroundColor(.textPrimaryColor)
                    // A real 44 pt frame gives the button Apple's minimum touch target. A larger content
                    // shape alone doesn't reach past the view's frame.
                    .frame(width: Self.touchTarget, height: Self.touchTarget)
                    .contentShape(Rectangle())
            })
            .accessibilityLabel(closeAccessibilityLabel)
            // Keeps the 32 pt the button took in the layout, so the icon doesn't move.
            .padding(-Self.touchTargetOutset)
            Spacer()
        }
    }
}

struct ImageGalleryHeader_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryHeader(closeAccessibilityLabel: "close", onCloseTapped: { })
    }
}
