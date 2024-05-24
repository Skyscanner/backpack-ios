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
                        ForEach(rowItems) { item in
                            content(item.data, item.id)
                                .modifier(ReadSizeModifier { size in
                                    elementsSize[item.data] = size
                                })
                        }
                    }
                }
            }
        }
    }
    
    private struct Item: Hashable, Identifiable {
        let id: Int
        var data: Data.Element
    }
    
    private func computeRows() -> [[Item]] {
        var rows: [[Item]] = []
        var currentRow = 0
        var remainingWidth = availableWidth
        var currentIndex = 0
        
        data.forEach { element in
            let defaultSize = CGSize(width: availableWidth, height: 1)
            let elementSize = elementsSize[element, default: defaultSize]
            let doesNotFitInCurrentRow = elementSize.width + spacing.width > remainingWidth
            
            if doesNotFitInCurrentRow { // new row
                remainingWidth = availableWidth
                currentRow += 1
                rows.append([Item(id: currentIndex, data: element)])
            } else { // existing row
                if !rows.indices.contains(currentRow) {
                    rows.append([])
                }
                rows[currentRow].append(Item(id: currentIndex, data: element))
            }
            currentIndex += 1
            remainingWidth -= (elementSize.width + spacing.width)
        }
        return rows
    }
}

struct BPKFlowStackView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32) {
            let alignments = [HorizontalAlignment.leading, .center, .trailing]
            ForEach(0..<3, id: \.self) { index in
                BPKFlowStackView(
                    data: Array(0...10),
                    alignment: alignments[index],
                    content: { element, index in makeBadge(index: element) }
                )
            }
        }
        .padding()
    }
    
    @ViewBuilder
    static func makeBadge(index: Int) -> some View {
        BPKBadge("Hello" + Array(repeating: "👋", count: index % 5).joined())
            .badgeStyle(.brand)
    }
}
