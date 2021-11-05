//
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

import XCTest
@testable import Backpack_Native

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        guard lhs.name == rhs.name else {
            return false
        }

        return lhs.subItems() == rhs.subItems()
    }
}

extension Row: Equatable where T: Equatable {
    public static func == (lhs: Row<T>, rhs: Row<T>) -> Bool {
        guard lhs.name == rhs.name else {
            return false
        }

        return lhs.value == rhs.value
    }
}

extension Section: Equatable where T: Equatable {
    public static func == (lhs: Section<T>, rhs: Section<T>) -> Bool {
        guard lhs.name == rhs.name else {
            return false
        }
        guard lhs.rows.count == rhs.rows.count else {
            return false
        }

        return lhs.rows == rhs.rows
    }
}

class MockStoryPresentable: Presentable {
    func makeViewController() -> UIViewController {
        return UIViewController()
    }
}

class TableNavigationDataTest: XCTestCase {
    func testSectionifyingAppStructure() throws {
        let appStructure = makeApp {
            Item(name: "Item X", value: .story(MockStoryPresentable()))
            Item(name: "Item Y", value: .story(MockStoryPresentable()))
        }

        let result = sectionify(items: appStructure)
        print(result)
        let expectedResult: [Section<Item>] = [
            Section(name: nil, rows: [
                Row(name: "Item X", value: Item(name: "Item X", value: .story(MockStoryPresentable()))),
                Row(name: "Item Y", value: Item(name: "Item Y", value: .story(MockStoryPresentable())))
            ])
        ]

        XCTAssertEqual(result, expectedResult, "Structure is not as expected")
    }

    func testSectionifyingAppStructureWithGroups() throws {
        let appStructure = makeApp {
            Item(name: "Item X", value: .story(MockStoryPresentable()))
            Group(name: "Group 1") {
                Item(name: "Item 1.1", value: .story(MockStoryPresentable()))
            }
            Group(name: "Group 2") {
                Item(name: "Item 2.1", value: .story(MockStoryPresentable()))
                Item(name: "Item 2.2", value: .story(MockStoryPresentable()))
            }
            Item(name: "Item Y", value: .story(MockStoryPresentable()))
        }

        let result = sectionify(items: appStructure)
        print(result)
        let expectedResult: [Section<Item>] = [
            Section(name: "Group 1", rows: [
                Row(name: "Item 1.1", value: Item(name: "Item 1.1", value: .story(MockStoryPresentable())))
            ]),
            Section(name: "Group 2", rows: [
                Row(name: "Item 2.1", value: Item(name: "Item 2.1", value: .story(MockStoryPresentable()))),
                Row(name: "Item 2.2", value: Item(name: "Item 2.2", value: .story(MockStoryPresentable())))
            ]),
            Section(name: nil, rows: [
                Row(name: "Item X", value: Item(name: "Item X", value: .story(MockStoryPresentable()))),
                Row(name: "Item Y", value: Item(name: "Item Y", value: .story(MockStoryPresentable())))
            ])
        ]

        XCTAssertEqual(result, expectedResult, "Structure is not as expected")
    }

    func testSectionifyingAppStructureWithEmptyGroups() throws {
        let appStructure = makeApp {
            Group(name: "Group 1") { }
            Group(name: "Group 2") { }
            Item(name: "Item X", value: .story(MockStoryPresentable()))
            Item(name: "Item Y", value: .story(MockStoryPresentable()))
        }

        let result = sectionify(items: appStructure)
        print(result)
        let expectedResult: [Section<Item>] = [
            Section(name: "Group 1", rows: []),
            Section(name: "Group 2", rows: []),
            Section(name: nil, rows: [
                Row(name: "Item X", value: Item(name: "Item X", value: .story(MockStoryPresentable()))),
                Row(name: "Item Y", value: Item(name: "Item Y", value: .story(MockStoryPresentable())))
            ])
        ]

        XCTAssertEqual(result, expectedResult, "Structure is not as expected")
    }
}
