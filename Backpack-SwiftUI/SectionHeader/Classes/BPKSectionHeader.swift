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

public struct BPKSectionHeader: View {
    let title: String
    let description: String?
    let style: Style
    let button: BPKButton?

    init(title: String, description: String? = nil, style: Style = .default) {
        self.title = title
        self.description = description
        self.style = style
        self.button = nil
    }

    init(title: String, description: String? = nil, style: Style = .default, @ViewBuilder button: () -> BPKButton) {
        self.title = title
        self.description = description
        self.style = style
        self.button = button()
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                BPKText(title, style: .heading3)
                if let description = description {
                    BPKText(description, style: .bodyDefault)
                }
            }
            .foregroundColor(style == .default ? .textPrimaryColor : .textOnDarkColor)
            Spacer()
            if let button = button {
                button
            }
        }
        .background(style == .default ? .canvasColor : .surfaceContrastColor)
    }

    enum Style {
        case `default`
        case onDark
    }
}
