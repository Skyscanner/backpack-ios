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
    let accessibilityHeaderEnabled: Bool
    let button: BPKButton?

    /// Creates a Section Header without a trailing button.
    ///
    /// - Parameters:
    ///   - title: The title of the section.
    ///   - description: An optional description displayed below the title.
    ///   - style: The visual style of the Section Header. Defaults to `.default`.
    ///   - accessibilityHeaderEnabled: Whether the title has the accessibility
    ///     header trait. Defaults to `true`.
    public init(
        title: String,
        description: String? = nil,
        style: Style = .default,
        accessibilityHeaderEnabled: Bool = true
    ) {
        self.title = title
        self.description = description
        self.style = style
        self.accessibilityHeaderEnabled = accessibilityHeaderEnabled
        self.button = nil
    }

    /// Creates a Section Header with a trailing button.
    ///
    /// The button style is set automatically according to the Section Header style.
    ///
    /// - Parameters:
    ///   - title: The title of the section.
    ///   - description: An optional description displayed below the title.
    ///   - style: The visual style of the Section Header. Defaults to `.default`.
    ///   - accessibilityHeaderEnabled: Whether the title has the accessibility
    ///     header trait. Defaults to `true`.
    ///   - button: The button displayed after the title and description.
    public init(
        title: String,
        description: String? = nil,
        style: Style = .default,
        accessibilityHeaderEnabled: Bool = true,
        @ViewBuilder button: () -> BPKButton
    ) {
        self.title = title
        self.description = description
        self.style = style
        self.accessibilityHeaderEnabled = accessibilityHeaderEnabled
        self.button = button()
    }

    public var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: .sm) {
                BPKText(title, style: .heading3)
                    .foregroundColor(style == .default ? .textPrimaryColor : .textOnDarkColor)
                    .lineLimit(nil)
                    .accessibilityAddTraits(
                        accessibilityHeaderEnabled ? .isHeader : []
                    )
                    .accessibilityRemoveTraits(
                        accessibilityHeaderEnabled ? [] : .isHeader
                    )
                if let description = description {
                    BPKText(description, style: .bodyDefault)
                        .foregroundColor(style == .default ? .textPrimaryColor : .textOnDarkColor)
                        .lineLimit(nil)
                }
            }

            Spacer()
            if let button = button {
                button.buttonStyle(style == .default ? .primary : .primaryOnDark)
            }
        }
    }
}
