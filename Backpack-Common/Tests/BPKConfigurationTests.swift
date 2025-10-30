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
@testable import Backpack_Common

final class BpkConfigurationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        BpkConfiguration.shared.reset()
    }
    
    func testConfigurationAccessedCallbackIsCalledOnceWhenConfigIsAccessed() {
        // Given
        let config = BpkConfiguration.shared
        let expectation = self.expectation(description: "Configuration accessed callback called")
        var callCount = 0
        
        // When
        config.onConfigurationAccessed = {
            callCount += 1
            expectation.fulfill()
        }
        _ = config.chipConfig
        
        // Then
        waitForExpectations(timeout: 1)
        XCTAssertEqual(callCount, 1)
    }

    func testSetThrowsErrorIfCalledTwice() {
        // Given
        let config = BpkConfiguration.shared
        
        // When
        try? config.set(chipConfig: true)
        
        // Then
        XCTAssertThrowsError(try config.set(chipConfig: true)) { error in
            XCTAssertEqual(error as? BpkConfiguration.ConfigurationError, .configAlreadySet)
        }
    }

    func testChipConfigIsSetCorrectlyWhenSetIsCalled() throws {
        // Given
        let config = BpkConfiguration.shared
        
        // When
        try config.set(chipConfig: true)
        let chipConfig = config.chipConfig
        
        // Then
        XCTAssertNotNil(chipConfig)
        XCTAssertEqual(chipConfig?.height, 12)
        XCTAssertEqual(chipConfig?.heightDimension, "bpk_new_chip_height")
        XCTAssertEqual(chipConfig?.radius, 100)
        XCTAssertEqual(chipConfig?.radiusToken, .roundCorners)
    }

    func testChipConfigIsNilByDefault() {
        // Given
        let config = BpkConfiguration.shared
        
        // Then
        XCTAssertNil(config.chipConfig)
    }

    func testBadgeConfigIsSetCorrectlyWhenSetIsCalled() throws {
        // Given
        let config = BpkConfiguration.shared

        // When
        try config.set(badgeConfig: true)
        let badgeConfig = config.badgeConfig

        // Then
        XCTAssertNotNil(badgeConfig)
    }

    func testBadgeConfigIsNilByDefault() {
        // Given
        let config = BpkConfiguration.shared

        // Then
        XCTAssertNil(config.badgeConfig)
    }
}
