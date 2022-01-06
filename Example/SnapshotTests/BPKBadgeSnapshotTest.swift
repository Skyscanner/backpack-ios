//
/*
 * Backpack - Skyscanner's Design System
 *
<<<<<<< HEAD:Example/SnapshotTests/BPKBadgeSnapshotTest.swift
 * Copyright 2018-2022 Skyscanner Ltd
=======
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
>>>>>>> 05586564 (migrating badge to Swift):Backpack/Badge/Classes/Badge.h
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

class BPKBadgeTest: XCTestCase {
    func testInitWithTypeMessage() {
        let badge = BPKBadge(type: .success, message: "Backpack rocks!")
        XCTAssertEqual(badge.type, .success)
        XCTAssertEqual(badge.message, "Backpack rocks!")
    }
}
