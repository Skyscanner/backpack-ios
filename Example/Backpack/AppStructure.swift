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

protocol Presentable {
    func makeViewController() -> UIViewController
}

extension Presentable {
    /**
     * Add an enrichment step to the presentable.
     *
     * parameter map: The function to apply to the result before returning the view controller.
     * returns: A new Presentable containing the enrichement.
    */
    func enrich(_ map: @escaping (UIViewController) -> Void) -> Presentable {
        return EnrichedPresentable(inner: self, closure: map)
    }
}

struct EnrichedPresentable {
    let inner: Presentable
    let closure: (UIViewController) -> Void
}

extension EnrichedPresentable: Presentable {
    func makeViewController() -> UIViewController {
        let innerVc = inner.makeViewController()
        closure(innerVc)

        return innerVc
    }
}

enum ItemValue {
    case story(Presentable)
    case group([Item])
}

protocol ItemConvertible {
    func asItems() -> [Item]
}

public struct Item {
    var name: String
    var value: ItemValue
}

extension Item {
    func isGroup() -> Bool {
        switch self.value {
        case .group:
            return true
        default:
            return false
        }
    }

    func isStory() -> Bool {
        switch self.value {
        case .story:
            return true
        default:
            return false
        }
    }

    /**
     * Returns a list of sub items if the item is a group.
     * Otherwise returns nil.
     */
    func subItems() -> [Item]? {
        switch self.value {
        case .group(let items):
            return items
        default:
            return nil
        }
    }
}

extension Item: ItemConvertible {
    func asItems() -> [Item] {
        [self]
    }
}

public struct Group {
    var name: String
    var items: [Item]

    /**
     * Construct a group with a given name and subitems
     *
     * parameter name: The name of the group.
     * parameter content: The child items of the group.
     */
    init(name: String, @AppBuilder builder: () -> [Item]) {
        self.name = name
        self.items = builder()
    }
}

extension Group: ItemConvertible {
    func asItems() -> [Item] {
        [Item(name: name, value: .group(items))]
    }
}

extension Array: ItemConvertible where Element == Item {
    func asItems() -> [Item] {
        self
    }
}

@resultBuilder
public struct AppBuilder {
    public static func buildBlock() -> [Item] { [] }
}

extension AppBuilder {
    static func buildBlock(_ groups: ItemConvertible...) -> [Item] {
        groups.flatMap { $0.asItems() }
    }
}

/**
 * Construct a list of groups from a series of items.
 *
 * parameter content: The items to construct into an app structure.
 */
public func makeApp(@AppBuilder _ content: () -> [Item]) -> [Item] {
    content()
}
