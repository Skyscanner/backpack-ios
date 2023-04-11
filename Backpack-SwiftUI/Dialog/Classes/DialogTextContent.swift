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

/// A view that renders a text content for a dialog.
struct DialogTextContent: View {
    private let title: String
    private let text: String
    private let contentAlignment: HorizontalAlignment
    private var spacing: CGFloat = BPKSpacing.base.value
    
    /// Creates a new instance of `DialogTextContent`.
    ///
    /// - Parameters:
    ///   - title: The title of the dialog.
    ///   - text: The text of the dialog.
    ///   - contentAlignment: The alignment of the content.
    init(title: String, text: String, contentAlignment: HorizontalAlignment) {
        self.title = title
        self.text = text
        self.contentAlignment = contentAlignment
    }
    
    var body: some View {
        VStack(alignment: contentAlignment, spacing: spacing) {
            HStack {
                if contentAlignment == .trailing {
                    Spacer()
                }
                BPKText(title, style: .heading3)
                if contentAlignment == .leading {
                    Spacer()
                }
            }
            BPKText(text)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(contentAlignment.textAlignment)
        }
    }
    
    func spacing(_ spacing: BPKSpacing) -> DialogTextContent {
        var result = self
        result.spacing = spacing.value
        return result
    }
}

fileprivate extension HorizontalAlignment {
    var textAlignment: TextAlignment {
        switch self {
        case .leading: return .leading
        case .center: return .center
        case .trailing: return .trailing
        default: return .leading
        }
    }
}

struct DialogTextContent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DialogTextContent(
                title: "Title in here",
                text: "Description that goes two lines ideally, but sometimes it can go longer",
                contentAlignment: .leading
            )
            DialogTextContent(
                title: "Title in here",
                text: "Description that goes two lines ideally, but sometimes it can go longer",
                contentAlignment: .center
            )
            DialogTextContent(
                title: "Title in here",
                text: "Description that goes two lines ideally, but sometimes it can go longer",
                contentAlignment: .trailing
            )
        }
    }
}
