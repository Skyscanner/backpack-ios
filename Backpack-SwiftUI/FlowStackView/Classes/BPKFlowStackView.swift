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

/// `BPKFlowStackView` is a SwiftUI view that arranges its children in a grid with a flexible number
///     of columns and rows.
///
/// This view adjusts the number of columns based on the available width and the widths of the children.
/// If a child does not fit in the current row, it is placed in the next row.
public struct BPKFlowStackView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGSize
    let alignment: HorizontalAlignment
    let content: (Data.Element, Int) -> Content
    
    @State private var availableWidth: CGFloat = 1
    @State private var elementsSize: [Data.Element: CGSize] = [:]
    
    /// Creates an instance with the given spacing and content.
    ///
    /// - Parameters:
    ///   - data: The collection of data to be displayed
    ///   - spacing: A `BPKSpacing` value indicating the space between children, with the same value for horizontal and
    ///     vertical spacing.
    ///   - alignment: The horizontal alignment of elements
    ///   - content: The view builder closure used to render each data element
    public init(
        data: Data,
        spacing: BPKSpacing = .md,
        alignment: HorizontalAlignment = .leading,
        content: @escaping (Data.Element, Int) -> Content
    ) {
        self.data = data
        self.spacing = CGSize(width: spacing, height: spacing)
        self.alignment = alignment
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: Alignment(horizontal: alignment, vertical: .center)) {
            Color.clear
                .frame(height: 1)
                .modifier(ReadSizeModifier { size in
                    availableWidth = size.width
                })
            
            VStack(alignment: alignment, spacing: spacing.height) {
                ForEach(computeRows(), id: \.self) { rowItems in
                    HStack(spacing: spacing.width) {
                        ForEach(Array(rowItems.enumerated()), id: \.element) { index, item in
                            content(item, index)
                                .modifier(ReadSizeModifier { size in
                                    elementsSize[item] = size
                                })
                        }
                    }
                }
            }
        }
    }
    
    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        data.forEach { element in
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
            
            if elementSize.width + spacing.width > remainingWidth {
                remainingWidth = availableWidth
                currentRow += 1
                rows.append([element])
            } else {
                rows[currentRow].append(element)
            }
            
            remainingWidth -= (elementSize.width + spacing.width)
        }
        return rows
    }
}

struct BPKFlowStackView_Previews: PreviewProvider {
    static var previews: some View {
        BPKFlowStackView(
            data: Array(0...30),
            content: { element, index in makeKBadge(index: element) }
        )
        .padding()
        .previewDisplayName("Leading")
        
        BPKFlowStackView(
            data: Array(0...30),
            alignment: .center,
            content: { element, index in makeKBadge(index: element) }
        )
        .padding()
        .previewDisplayName("Center")
    }
    
    @ViewBuilder
    static func makeKBadge(index: Int) -> some View {
        BPKBadge("Hello" + Array(repeating: "👋", count: index % 5).joined())
            .badgeStyle(.brand)
    }
}
