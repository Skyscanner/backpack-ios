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
import SwiftUI
@testable import Backpack_SwiftUI

class BPKNudgerTests: XCTestCase {
    
    func test_validValue() {
        assertSnapshot(
            BPKNudger(value: .constant(1), min: 0, max: 10, step: 1)
        )
    }

    func test_minValue() {
        assertSnapshot(
            BPKNudger(value: .constant(0), min: 0, max: 10, step: 1)
        )
    }

    func test_maxValue() {
        assertSnapshot(
            BPKNudger(value: .constant(10), min: 0, max: 10, step: 1)
        )
    }
    
    func test_title() {
        assertSnapshot(
            BPKNudger(title: "Rooms", value: .constant(2), min: 0, max: 10, step: 1)
        )
    }
    
    func test_title_and_subtitle() {
        assertSnapshot(
            BPKNudger(title: "Adults", subtitle: "Aged 16+", value: .constant(5), min: 0, max: 10, step: 1)
        )
    }
    
    func test_title_and_icon() {
        assertSnapshot(
            BPKNudger(title: "Room", icon: .room, value: .constant(5), min: 0, max: 10, step: 1)
        )
    }
    
    func test_title_subtitle_and_icon() {
        assertSnapshot(
            BPKNudger(
                title: "Adults",
                subtitle: "Aged 16+",
                icon: .adult,
                value: .constant(5),
                min: 0,
                max: 10,
                step: 1
            )
        )
    }
}
