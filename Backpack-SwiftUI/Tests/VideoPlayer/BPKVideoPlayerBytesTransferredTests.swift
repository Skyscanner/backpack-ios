/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2026 Skyscanner Ltd. All rights reserved.
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

import AVFoundation
import Combine
import XCTest
@testable import Backpack_SwiftUI

/// Tests for `BPKVideoPlayerController.numberOfBytesTransferred`.
///
/// Design
/// ------
/// On init, `BPKVideoPlayerController` KVO-observes `player.currentItem` with `.initial` and
/// dispatches `handleCurrentItemChange` asynchronously via `DispatchQueue.main.async`. This means
/// the first provider call (and observer registration) happens after the current test-body
/// returns control to the run loop — not synchronously in `makeSUT`.
///
/// Tests therefore:
/// 1. Use an isolated `NotificationCenter` to prevent cross-test notification leakage.
/// 2. Use `waitUntil` to poll until the expected value appears, letting both
///    `DispatchQueue.main.async` callbacks and spawned `Task { @MainActor }` blocks run.
/// 3. Obtain the registered item via `sut.player.currentItem` **after** the KVO settles, so
///    `AVPlayerItemNewAccessLogEntry` notifications hit the correct observer.
@MainActor
final class BPKVideoPlayerBytesTransferredTests: XCTestCase {

    // MARK: - Provider return value reflected on attach

    func test_givenProviderReturnsFixedValue_whenKVOSettles_numberOfBytesTransferredMatchesProvider() async throws {
        // Given
        let sut = makeSUT(bytesProvider: { _ in 4_096 })

        // When — wait for the initial KVO → handleCurrentItemChange → updateBytesTransferred
        try await waitUntil(sut, expected: 4_096)

        // Then
        XCTAssertEqual(sut.numberOfBytesTransferred, 4_096)
    }

    func test_givenProviderReturnsZero_whenKVOSettles_numberOfBytesTransferredIsZero() async throws {
        let sut = makeSUT(bytesProvider: { _ in 0 })
        try await waitUntil(sut, expected: 0)
        XCTAssertEqual(sut.numberOfBytesTransferred, 0)
    }

    // MARK: - Notification-triggered update

    func test_whenAccessLogEntryNotificationFires_numberOfBytesTransferredUpdatesToProviderValue() async throws {
        // Given
        let nc = NotificationCenter()
        var providerReturn: Int64 = 0
        let sut = makeSUT(notificationCenter: nc, bytesProvider: { _ in providerReturn })

        // Let the initial KVO callback run so the observer is registered
        try await waitUntil(sut, expected: 0)
        let item = try XCTUnwrap(sut.player.currentItem, "player must have a current item after KVO settles")

        // When — access-log entry arrives
        providerReturn = 2_048
        nc.post(name: .AVPlayerItemNewAccessLogEntry, object: item)

        // Then
        try await waitUntil(sut, expected: 2_048)
        XCTAssertEqual(sut.numberOfBytesTransferred, 2_048)
    }

    func test_givenMultipleAccessLogEntries_eachNotificationReadsLatestProviderReturn() async throws {
        // Given
        let nc = NotificationCenter()
        var providerReturn: Int64 = 0
        let sut = makeSUT(notificationCenter: nc, bytesProvider: { _ in providerReturn })
        try await waitUntil(sut, expected: 0)
        let item = try XCTUnwrap(sut.player.currentItem)

        // When — three successive access-log entries with increasing byte counts
        for expected in [512, 1_024, 3_000] as [Int64] {
            providerReturn = expected
            nc.post(name: .AVPlayerItemNewAccessLogEntry, object: item)
            try await waitUntil(sut, expected: expected)
        }

        // Then
        XCTAssertEqual(sut.numberOfBytesTransferred, 3_000)
    }

    // MARK: - Notification for unrelated item is ignored

    func test_whenNotificationFiredForDifferentItem_numberOfBytesTransferredDoesNotChange() async throws {
        // Given — observer registered for player.currentItem only
        let nc = NotificationCenter()
        let sut = makeSUT(notificationCenter: nc, bytesProvider: { _ in 1_024 })
        try await waitUntil(sut, expected: 1_024)
        let before = sut.numberOfBytesTransferred

        // When — notification for a different AVPlayerItem instance
        let otherItem = AVPlayerItem(url: stubURL)
        nc.post(name: .AVPlayerItemNewAccessLogEntry, object: otherItem)
        // Drain twice: once for any DispatchQueue.main.async, once for any spawned MainActor Task
        await Task.yield()
        await Task.yield()

        // Then
        XCTAssertEqual(sut.numberOfBytesTransferred, before)
    }

    // MARK: - Reset when item clears

    func test_givenNonZeroBytes_whenItemBecomesNil_numberOfBytesTransferredResetsToZeroSynchronously() async throws {
        // Given — provider returns a non-zero value; wait for KVO to settle
        let sut = makeSUT(bytesProvider: { _ in 8_192 })
        try await waitUntil(sut, expected: 8_192)

        // When — item cleared (e.g. AVPlayerLooper momentarily clears currentItem)
        // The nil path in handleCurrentItemChange is synchronous: no Task is spawned.
        sut.testOnly_handleCurrentItemChange(nil)

        // Then — the reset is observable immediately, before any deferred callback runs
        XCTAssertEqual(sut.numberOfBytesTransferred, 0)
    }

    // MARK: - Published via Combine

    func test_numberOfBytesTransferred_publishesEachUpdateViaPublisher() async throws {
        // Given
        let nc = NotificationCenter()
        var providerReturn: Int64 = 0
        let sut = makeSUT(notificationCenter: nc, bytesProvider: { _ in providerReturn })
        try await waitUntil(sut, expected: 0)
        let item = try XCTUnwrap(sut.player.currentItem)

        // Subscribe before driving any updates
        var received: [Int64] = []
        let cancellable = sut.$numberOfBytesTransferred
            .sink { received.append($0) }
        defer { cancellable.cancel() }

        // When — two successive access-log entries
        providerReturn = 500
        nc.post(name: .AVPlayerItemNewAccessLogEntry, object: item)
        try await waitUntil(sut, expected: 500)

        providerReturn = 1_500
        nc.post(name: .AVPlayerItemNewAccessLogEntry, object: item)
        try await waitUntil(sut, expected: 1_500)

        // Then — publisher emitted both driven values; final value is correct
        XCTAssertTrue(received.contains(500),
                      "Publisher should have emitted 500; received: \(received)")
        XCTAssertTrue(received.contains(1_500),
                      "Publisher should have emitted 1500; received: \(received)")
        XCTAssertEqual(received.last, 1_500)
    }

    // MARK: - Helpers

    private var stubURL: URL { URL(string: "data:video/mp4,stub")! }

    /// Polls until `numberOfBytesTransferred` equals `expected` or the timeout expires.
    ///
    /// Both `DispatchQueue.main.async` callbacks and `Task { @MainActor }` blocks are driven
    /// by cooperating with the main actor executor via repeated yields.
    private func waitUntil(
        _ sut: BPKVideoPlayerController,
        expected: Int64,
        timeout: TimeInterval = 2
    ) async throws {
        let deadline = Date().addingTimeInterval(timeout)
        while sut.numberOfBytesTransferred != expected {
            guard Date() < deadline else {
                XCTFail(
                    "Timed out waiting for numberOfBytesTransferred == \(expected); " +
                    "current value: \(sut.numberOfBytesTransferred)"
                )
                return
            }
            await Task.yield()
        }
    }

    private func makeSUT(
        notificationCenter: NotificationCenter = NotificationCenter(),
        bytesProvider: @escaping BPKVideoPlayerBytesProvider = { _ in 0 }
    ) -> BPKVideoPlayerController {
        BPKVideoPlayerController(
            url: stubURL,
            autoPlay: false,
            loop: false,
            loadTimeout: 0,
            periodicTimeObserver: BytesTestNoOpTimeObserver(),
            durationProvider: { _ in nil },
            bytesTransferredProvider: bytesProvider,
            notificationCenter: notificationCenter,
            audioSession: BytesTestAudioSessionStub()
        )
    }
}

// MARK: - Private stubs

private final class BytesTestNoOpTimeObserver: BPKVideoPlayerPeriodicTimeObserving {
    func addPeriodicTimeObserver(
        to player: AVPlayer,
        interval: CMTime,
        queue: DispatchQueue,
        using callback: @escaping (CMTime) -> Void
    ) -> Any { NSObject() }

    func removePeriodicTimeObserver(_ token: Any, from player: AVPlayer) {}
}

private final class BytesTestAudioSessionStub: BPKVideoPlayerAudioSessionManaging {
    func setCategory(
        _ category: AVAudioSession.Category,
        mode: AVAudioSession.Mode,
        options: AVAudioSession.CategoryOptions
    ) throws {}

    func setActive(_ active: Bool, options: AVAudioSession.SetActiveOptions) throws {}
}
