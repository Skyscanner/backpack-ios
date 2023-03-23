/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

public struct BPKPanel<Content: View>: View {    
    private let content: Content
    private let padding: Bool

    public init(
        padding: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.padding = padding
    }

    public var body: some View {
        Group {
            content
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .padding(padding ? .base : .none)
        .background(.surfaceDefaultColor)
        .cornerRadius(BPKCornerRadius.md.value)
        .overlay(
            RoundedRectangle(cornerRadius: BPKCornerRadius.md.value)
                .stroke(Color(BPKColor.lineColor), lineWidth: 1)
        )
    }
}

struct BPKPanel_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(BPKColor.canvasColor)
            VStack(spacing: 40){
                BPKPanel() {
                    BPKText("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet sagittis tellus, quis pharetra massa. Nunc nec nisl condimentum, efficitur sem vitae, facilisis erat. Nullam ut tellus sed tortor eleifend accumsan sed nec enim. Nullam nec rhoncus nulla. Fusce placerat blandit semper.")
                        .lineLimit(nil)
                }
                
                BPKPanel(padding: false) {
                    BPKText("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet sagittis tellus, quis pharetra massa. Nunc nec nisl condimentum, efficitur sem vitae, facilisis erat. Nullam ut tellus sed tortor eleifend accumsan sed nec enim. Nullam nec rhoncus nulla. Fusce placerat blandit semper.")
                        .lineLimit(nil)
                }
            }
            .padding()
        }
    }
}
