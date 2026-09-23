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
    /// Added on each side of the 32 pt Close button to reach Apple's 44 pt minimum touch target,
    /// without moving the button or changing the layout around it.
    private static let touchTargetOutset: CGFloat = 6

    let closeAccessibilityLabel: String
    let onCloseTapped: () -> Void

    var body: some View {
        HStack {
            Button(action: onCloseTapped, label: {
                BPKIconView(.close, size: .large)
                    .foregroundColor(.textPrimaryColor)
                    .padding(.sm)
                    .contentShape(Rectangle().inset(by: -Self.touchTargetOutset))
            })
            .accessibilityLabel(closeAccessibilityLabel)
            Spacer()
        }
    }
}

struct ImageGalleryHeader_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryHeader(closeAccessibilityLabel: "close", onCloseTapped: { })
    }
}
