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
#ifndef __BACKPACK_BADGE__
#define __BACKPACK_BADGE__

<<<<<<< HEAD:Backpack/Badge/Classes/Badge.h
#import "BPKBadge.h"
#endif
=======
import XCTest

class BPKBadgeTest: XCTestCase {
    func testInitWithTypeMessage() {
        let badge = BPKBadge(type: .success, message: "Backpack rocks!")
        XCTAssertEqual(badge.type, .success)
        XCTAssertEqual(badge.message, "Backpack rocks!")
    }
}
>>>>>>> f49be2a5 (migrating badge to Swift):Example/Tests/BPKBedgeTest.swift
