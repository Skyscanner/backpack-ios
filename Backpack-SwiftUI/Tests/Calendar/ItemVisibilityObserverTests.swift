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

import XCTest
import Combine
@testable import Backpack_SwiftUI

final class ItemVisibilityObserverTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    private let months: [Int: CGRect] = [
        0: CGRect(x: 0, y: 0, width: 400, height: 300),
        1: CGRect(x: 0, y: 300, width: 400, height: 300)
    ]

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    func test_whenItemsIntersectTheParent_thenOnlyThoseAreVisible() {
        let observer = ItemVisibilityObserver(debounceThreshold: 0)
        let visible = expectation(description: "visible items published")
        var received: [Int] = []
        observer.$visibleItems.dropFirst().sink { items in
            received = items.sorted()
            visible.fulfill()
        }.store(in: &cancellables)

        observer.updatePreferences(months, parentFrame: CGRect(x: 0, y: 0, width: 400, height: 200))

        wait(for: [visible], timeout: 2)
        XCTAssertEqual(received, [0])
    }

    func test_whenSeveralItemsAreVisible_thenTheyArePublishedInOrder() {
        let observer = ItemVisibilityObserver(debounceThreshold: 0)
        let visible = expectation(description: "visible items published")
        var received: [Int] = []
        observer.$visibleItems.dropFirst().sink { items in
            received = items
            visible.fulfill()
        }.store(in: &cancellables)
        let year = Dictionary(uniqueKeysWithValues: (0..<12).map { month in
            (month, CGRect(x: 0, y: CGFloat(month) * 10, width: 400, height: 10))
        })

        observer.updatePreferences(year, parentFrame: CGRect(x: 0, y: 0, width: 400, height: 120))

        wait(for: [visible], timeout: 2)
        XCTAssertEqual(received, Array(0..<12))
    }

    func test_whenTheParentFrameChanges_thenVisibleItemsFollowTheNewFrame() {
        // Folding or unfolding a foldable changes the calendar's frame. Before this was fixed, the
        // observer kept measuring against the frame it was created with.
        let observer = ItemVisibilityObserver(debounceThreshold: 0)
        let followed = expectation(description: "visible items follow the parent's new frame")
        var received: [[Int]] = []
        observer.$visibleItems.dropFirst().sink { [months] items in
            received.append(items.sorted())
            if received.count == 1 {
                observer.updatePreferences(months, parentFrame: CGRect(x: 0, y: 350, width: 400, height: 200))
            } else {
                followed.fulfill()
            }
        }.store(in: &cancellables)

        observer.updatePreferences(months, parentFrame: CGRect(x: 0, y: 0, width: 400, height: 200))

        wait(for: [followed], timeout: 2)
        XCTAssertEqual(received, [[0], [1]])
    }
}
