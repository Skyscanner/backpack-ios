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

/// `FlowStackView` is a SwiftUI view that arranges its children in a grid with a flexible number of columns and rows.
///
/// This view adjusts the number of columns based on the available width and the widths of the children.
/// If a child does not fit in the current row, it is placed in the next row.
public struct FlowStackView<Content: View>: View {
    let content: () -> Content
    let spacing: CGSize

    /// Creates an instance with the given spacing and content.
    ///
    /// - Parameters:
    ///   - spacing: A `CGSize` value indicating the space between children.
    ///   - content: A view builder that creates the content of this stack.
    public init(spacing: CGSize, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.spacing = spacing
    }

    /// Creates an instance with the given spacing and content.
    ///
    /// - Parameters:
    ///   - spacing: A `BPKSpacing` value indicating the space between children, with the same value for horizontal and
    ///     vertical spacing.
    ///   - content: A view builder that creates the content of this stack.
    public init(spacing: BPKSpacing, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.spacing = CGSize(width: spacing, height: spacing)
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Setup for layout pass
            var available: CGFloat = 0
            var x: CGFloat = 0
            var y: CGFloat = 0
            Color.clear
                .frame(height: 0)
                .alignmentGuide(.top) { item in
                    available = item.width
                    x = 0
                    y = 0
                    return 0
                }

            content()
                .alignmentGuide(.leading) { item in
                    if x + item.width > available {
                        x = 0
                        y += item.height + spacing.height
                    }
                    let result = x
                    x += item.width + spacing.width
                    return -result
                }
                .alignmentGuide(.top) { _ in -y }
        }
    }
}

struct FlowStackView_Previews: PreviewProvider {
    static var previews: some View {
        FlowStackView(spacing: .md) {
            ForEach(0..<20) { index in
                BPKBadge("badge \(index)")
                    .badgeStyle(.brand)
            }
        }
        .padding()
    }
}
