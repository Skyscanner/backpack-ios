/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

@_functionBuilder
public struct AppBuilder {
    // returns empty array of Items
    public static func buildBlock() -> [Item] { [] }
}

extension AppBuilder {
    // maps groups to list of Items
    static func buildBlock(_ groups: ItemConvertible...) -> [Item] {
        groups.flatMap { $0.asItems() }
    }
}

public func makeApp(@AppBuilder _ content: () -> [Item]) -> [Item] {
    content()
}
