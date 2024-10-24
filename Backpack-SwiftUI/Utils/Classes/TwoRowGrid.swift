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

struct TwoRowGrid<Item, ItemView: View>: View {
    let items: [[(Item, Int)]]
    let spacing: BPKSpacing
    let itemView: (Item, Int) -> ItemView
    
    init(
        items: [Item],
        spacing: BPKSpacing = .md,
        itemView: @escaping (Item, Int) -> ItemView
    ) {
        var rows: [[(Item, Int)]] = []
        var index = 0
        while index < items.count {
            let count = index % 3 == 0 ? 1 : 2
            var row = [(Item, Int)]()
            for col in 0..<count {
                if items.indices.contains(index + col) {
                    row.append((items[index + col], index + col))
                }
            }
            rows.append(row)
            index += count
        }
        self.items = rows
        self.itemView = itemView
        self.spacing = spacing
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: spacing) {
                    ForEach(0..<items.count, id: \.self) { rowIndex in
                        row(proxy: proxy, rowIndex: rowIndex)
                    }
                }
            }
        }
    }
    
    private func row(proxy: GeometryProxy, rowIndex index: Int) -> some View {
        HStack(spacing: spacing) {
            ForEach(0..<items[index].count, id: \.self) { columnIndex in
                column(proxy: proxy, columnIndex: columnIndex, rowIndex: index)
            }
        }
    }
    
    private func column(proxy: GeometryProxy, columnIndex index: Int, rowIndex: Int) -> some View {
        let itemTuple = items[rowIndex][index]
        let shape = RoundedRectangle(cornerRadius: .md)
        return itemView(itemTuple.0, itemTuple.1)
            .if(rowIndex % 2 != 0) {
                $0.frame(width: (proxy.size.width / 2) - (spacing.value / 2))
            }
            .clipShape(shape)
            .contentShape(shape)
    }
}

struct TwoRowGrid_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TwoRowGrid(
                items: Array(0...2)
            ) { _, _ in Color.cyan.frame(height: 100) }
            
            TwoRowGrid(
                items: Array(0...2),
                spacing: .lg
            ) { _, _ in Color.green.frame(height: 100) }
            
            TwoRowGrid(
                items: Array(0...2),
                spacing: .xxl
            ) { _, _ in Color.red.frame(height: 100) }
        }
    }
}
