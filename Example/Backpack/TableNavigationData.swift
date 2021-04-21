/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

public struct Section<T> {
    let name: String?
    let rows: [Row<T>]
}

public struct Row<T> {
    let name: String
    let value: T
}

/**
 * Converts a list of group items into a list of sections if they have subitems
 *
 * parameter items: The items to organise into one or more sections.
 * returns: A list of sections.
 */
public func sectionify(items: [Item]) -> [Section<Item>] {
    let groups: [(String, [Item])] = items.compactMap({ group in
        group.subItems().map({
            (group.name, $0)
        })
    })

    let ungroupedItems: [Item] = items.filter({ $0.isStory() })

    var value = groups.map({group in
        Section(name: group.0, rows: group.1.map({ Row(name: $0.name, value: $0) }))
    })

    if ungroupedItems.count > 0 {
        value.append(Section(name: nil, rows: ungroupedItems.map({ Row(name: $0.name, value: $0) })))
    }

    return value
}
