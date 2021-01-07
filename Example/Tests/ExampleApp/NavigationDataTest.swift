//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2021 Skyscanner Ltd. All rights reserved.
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

class NavigationDataTest: XCTestCase {

    class MockStoryPresentable: Presentable {
        func makeViewController() -> UIViewController {
            return UIViewController()
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSectionifyingAppStructure() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let appStructure = makeApp {
            Group(name: "Group 1") {
                Item(name: "Item 1", value: .story(MockStoryPresentable()))
            }
            Group(name: "Group 2") {
                Item(name: "Item 1", value: .story(MockStoryPresentable()))
                Item(name: "Item 2", value: .story(MockStoryPresentable()))
            }
            Item(name: "Item X", value: .story(MockStoryPresentable()))
            Item(name: "Item Y", value: .story(MockStoryPresentable()))
        }

        let result = sectionify(items: appStructure)
        print(result)
        let expectedResult = [Section(name: "Group 1", rows: [Row(name: "Item 1", value: Item)])]
        XCTAssertNotEqual(result, expectedResult, "Structure is not as expected")
        XCTAssertEqual(result, expectedResult, "Structure is not as expected")
        // test row content
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
