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
import Backpack_Common

final class BpkConfigurationTests: XCTestCase {
    private let config = BpkConfiguration.shared

    override func setUp() {
        super.setUp()
        config.reset()
    }

    override func tearDown() {
        config.reset()
        super.tearDown()
    }

    func test_whenNoExperimentIsSelected_thenUsesDefaultConfiguration() {
        // Given / When
        let bottomSheet = config.bottomSheetConfig

        // Then
        XCTAssertNil(bottomSheet)
    }

    func test_whenSettingAnActiveExperiment_thenEnablesItsConfiguration() throws {
        // Given / When
        try config.set(configs: [.nativeBottomSheet])

        // Then
        XCTAssertEqual(config.bottomSheetConfig?.nativeModalSheet, true)
    }

    func test_whenSettingAnEmptyList_thenLeavesExperimentsDisabled() throws {
        // Given / When
        try config.set(configs: [])

        // Then
        XCTAssertNil(config.bottomSheetConfig)
    }

    func test_givenAConfigurationIsSet_whenSettingAgain_thenThrows() throws {
        // Given
        try config.set(configs: [.nativeBottomSheet])

        // When / Then
        XCTAssertThrowsError(try config.set(configs: [])) { error in
            XCTAssertEqual(error as? BpkConfiguration.ConfigurationError, .configAlreadySet)
        }
        XCTAssertEqual(config.bottomSheetConfig?.nativeModalSheet, true)
    }

    func test_givenAnActiveExperiment_whenResetting_thenClearsItAndAllowsAnotherAllocation() throws {
        // Given
        try config.set(configs: [.nativeBottomSheet])

        // When
        config.reset()

        // Then
        XCTAssertNil(config.bottomSheetConfig)
        XCTAssertNil(config.onConfigurationAccessed)
        XCTAssertNoThrow(try config.set(configs: [.nativeBottomSheet]))
    }

    func test_givenAnActiveExperiment_whenClearingConfiguration_thenUsesTheDefault() throws {
        // Given
        try config.set(configs: [.nativeBottomSheet])

        // When
        config.bottomSheetConfig = nil

        // Then
        XCTAssertNil(config.bottomSheetConfig)
    }

    func test_whenAllocatingConcurrently_thenOnlyAllowsOneAllocation() {
        // Given
        let allocation = expectation(description: "Only one allocation succeeds")
        allocation.assertForOverFulfill = true

        // When
        DispatchQueue.concurrentPerform(iterations: 20) { _ in
            do {
                try config.set(configs: [.nativeBottomSheet])
                allocation.fulfill()
            } catch {
                XCTAssertEqual(error as? BpkConfiguration.ConfigurationError, .configAlreadySet)
            }
        }

        // Then
        wait(for: [allocation], timeout: 1)
        XCTAssertEqual(config.bottomSheetConfig?.nativeModalSheet, true)
    }

    func test_whenParsingRetiredVDLNames_thenRejectsThem() {
        // Given
        let retiredValues = [
            "backpack_experiment", "backpack_icon", "backpack_chips",
            "backpack_card", "backpack_badge", "backpack_button", "backpack_all"
        ]

        // When / Then
        for value in retiredValues {
            XCTAssertNil(ConfigType(rawValue: value))
        }
        XCTAssertEqual(ConfigType(rawValue: "backpack_native_bottom_sheet"), .nativeBottomSheet)
    }

    func test_whenAccessingConfigurationRepeatedly_thenNotifiesOnce() {
        // Given
        let callback = expectation(description: "Configuration accessed once")
        callback.assertForOverFulfill = true
        config.onConfigurationAccessed = { callback.fulfill() }

        // When
        for _ in 0..<20 {
            _ = config.bottomSheetConfig
        }

        // Then
        wait(for: [callback], timeout: 1)
    }

    func test_givenConfigurationWasAccessed_whenResetting_thenAllowsANewNotification() {
        // Given
        let firstCallback = expectation(description: "First allocation accessed")
        config.onConfigurationAccessed = { firstCallback.fulfill() }
        _ = config.bottomSheetConfig
        wait(for: [firstCallback], timeout: 1)
        config.reset()
        let nextCallback = expectation(description: "Next allocation accessed")
        config.onConfigurationAccessed = { nextCallback.fulfill() }

        // When
        _ = config.bottomSheetConfig

        // Then
        wait(for: [nextCallback], timeout: 1)
    }

    func test_givenANotificationIsQueued_whenResetting_thenOnlyNotifiesForNewAccess() {
        // Given a callback holding the notification queue while another allocation is accessed.
        let callbackStarted = expectation(description: "First callback started")
        let releaseCallback = DispatchSemaphore(value: 0)
        defer { releaseCallback.signal() }
        config.onConfigurationAccessed = {
            callbackStarted.fulfill()
            XCTAssertEqual(releaseCallback.wait(timeout: .now() + 2), .success)
        }
        _ = config.bottomSheetConfig
        wait(for: [callbackStarted], timeout: 1)
        config.reset()
        _ = config.bottomSheetConfig

        // When the queued notification belongs to an allocation that has been reset.
        config.reset()
        let staleCallback = expectation(description: "No notification from the previous allocation")
        staleCallback.isInverted = true
        config.onConfigurationAccessed = { staleCallback.fulfill() }
        releaseCallback.signal()

        // Then the new allocation is only notified after its own configuration access.
        wait(for: [staleCallback], timeout: 0.2)
        let nextCallback = expectation(description: "New allocation accessed")
        config.onConfigurationAccessed = { nextCallback.fulfill() }
        _ = config.bottomSheetConfig
        wait(for: [nextCallback], timeout: 1)
    }

    func test_whenResettingFromAccessCallback_thenAllowsAnotherAllocation() {
        // Given
        let callback = expectation(description: "Callback can reset configuration")
        config.onConfigurationAccessed = {
            // When
            self.config.reset()

            // Then
            XCTAssertNil(self.config.onConfigurationAccessed)
            do {
                try self.config.set(configs: [.nativeBottomSheet])
            } catch {
                XCTFail("Expected allocation after reset, got \(error)")
            }
            callback.fulfill()
        }
        _ = config.bottomSheetConfig
        wait(for: [callback], timeout: 1)
        XCTAssertEqual(config.bottomSheetConfig?.nativeModalSheet, true)
    }
}
