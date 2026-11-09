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

@MainActor
final class BPKVideoPlayerBytesTransferredTests: XCTestCase {

    // MARK: - Provider wiring

    func test_givenProviderReturnsFixedValue_whenKVOSettles_bytesTransferredMatchesProvider() async throws {
        // Given
        let sut = makeSUT(bytesProvider: { _ in 4_096 })

        // When
        try await waitUntil(sut, expected: 4_096)

        // Then
        XCTAssertEqual(sut.bytesTransferred, 4_096)
    }

    func test_givenProviderReturnsZero_whenKVOSettles_bytesTransferredIsZero() async throws {
        // Given
        let sut = makeSUT(bytesProvider: { _ in 0 })
        
        // When
        try await waitUntil(sut, expected: 0)
        
        // Then
        XCTAssertEqual(sut.bytesTransferred, 0)
    }

    // MARK: - Notification-triggered update

    func test_whenAccessLogEntryNotificationFires_bytesTransferredUpdatesToProviderValue() async throws {
        // Given
        let nc = NotificationCenter()
        var providerReturn: Int64 = 0
        let sut = makeSUT(notificationCenter: nc, bytesProvider: { _ in providerReturn })

        try await waitUntil(sut, expected: 0)
        let item = try XCTUnwrap(sut.player.currentItem, "player must have a current item after KVO settles")

        // When
        providerReturn = 2_048
        nc.post(name: .AVPlayerItemNewAccessLogEntry, object: item)

        // Then
        try await waitUntil(sut, expected: 2_048)
        XCTAssertEqual(sut.bytesTransferred, 2_048)
    }

    func test_givenMultipleAccessLogEntries_eachNotificationReadsLatestProviderReturn() async throws {
        // Given
        let nc = NotificationCenter()
        var providerReturn: Int64 = 0
        let sut = makeSUT(notificationCenter: nc, bytesProvider: { _ in providerReturn })
        try await waitUntil(sut, expected: 0)
        let item = try XCTUnwrap(sut.player.currentItem)

        // When
        for expected in [512, 1_024, 3_000] as [Int64] {
            providerReturn = expected
            nc.post(name: .AVPlayerItemNewAccessLogEntry, object: item)
            try await waitUntil(sut, expected: expected)
        }

        // Then
        XCTAssertEqual(sut.bytesTransferred, 3_000)
    }

    // MARK: - Notification for unrelated item is ignored

    func test_whenNotificationFiredForDifferentItem_bytesTransferredDoesNotChange() async throws {
        // Given
        let nc = NotificationCenter()
        let sut = makeSUT(notificationCenter: nc, bytesProvider: { _ in 1_024 })
        try await waitUntil(sut, expected: 1_024)
        let before = sut.bytesTransferred

        // When
        let otherItem = AVPlayerItem(url: stubURL)
        nc.post(name: .AVPlayerItemNewAccessLogEntry, object: otherItem)
        await Task.yield()
        await Task.yield()

        // Then
        XCTAssertEqual(sut.bytesTransferred, before)
    }

    // MARK: - Accumulates across loop swaps, persists when the item clears

    func test_givenNonZeroBytes_whenItemBecomesNil_bytesTransferredPersistsTheAccumulatedTotal() async throws {
        // Given
        let sut = makeSUT(bytesProvider: { _ in 8_192 })
        try await waitUntil(sut, expected: 8_192)

        // When
        sut.testOnly_handleCurrentItemChange(nil)

        // Then
        XCTAssertEqual(sut.bytesTransferred, 8_192)
    }

    func test_givenLoopReplacesCurrentItem_bytesTransferredAccumulatesAcrossItems() {
        // Given
        var bytesByItem: [ObjectIdentifier: Int64] = [:]
        let sut = makeSUT(bytesProvider: { item in
            item.map { bytesByItem[ObjectIdentifier($0)] ?? 0 } ?? 0
        })
        let firstItem = AVPlayerItem(url: stubURL)
        bytesByItem[ObjectIdentifier(firstItem)] = 5_000

        // When
        sut.testOnly_handleCurrentItemChange(firstItem)

        // Then
        XCTAssertEqual(sut.bytesTransferred, 5_000)

        // When
        let secondItem = AVPlayerItem(url: stubURL)
        sut.testOnly_handleCurrentItemChange(secondItem)

        // Then
        XCTAssertEqual(sut.bytesTransferred, 5_000)

        // When
        bytesByItem[ObjectIdentifier(secondItem)] = 1_200
        sut.updateBytesTransferred(for: secondItem)

        // Then
        XCTAssertEqual(sut.bytesTransferred, 6_200)
    }

    // MARK: - Published via Combine

    func test_bytesTransferred_publishesEachUpdateViaPublisher() async throws {
        // Given
        let nc = NotificationCenter()
        var providerReturn: Int64 = 0
        let sut = makeSUT(notificationCenter: nc, bytesProvider: { _ in providerReturn })
        try await waitUntil(sut, expected: 0)
        let item = try XCTUnwrap(sut.player.currentItem)
        var received: [Int64] = []
        let cancellable = sut.$bytesTransferred
            .sink { received.append($0) }
        defer { cancellable.cancel() }

        // When
        providerReturn = 500
        nc.post(name: .AVPlayerItemNewAccessLogEntry, object: item)
        try await waitUntil(sut, expected: 500)

        providerReturn = 1_500
        nc.post(name: .AVPlayerItemNewAccessLogEntry, object: item)
        try await waitUntil(sut, expected: 1_500)

        // Then
        XCTAssertTrue(received.contains(500),
                      "Publisher should have emitted 500; received: \(received)")
        XCTAssertTrue(received.contains(1_500),
                      "Publisher should have emitted 1500; received: \(received)")
        XCTAssertEqual(received.last, 1_500)
    }

    // MARK: - Helpers

    private var stubURL: URL { URL(string: "data:video/mp4,stub")! }

    /// Polls until `bytesTransferred` equals `expected` or the timeout expires.
    ///
    /// Both `DispatchQueue.main.async` callbacks and `Task { @MainActor }` blocks are driven
    /// by cooperating with the main actor executor via repeated yields.
    private func waitUntil(
        _ sut: BPKVideoPlayerController,
        expected: Int64,
        timeout: TimeInterval = 2
    ) async throws {
        let deadline = Date().addingTimeInterval(timeout)
        while sut.bytesTransferred != expected {
            guard Date() < deadline else {
                XCTFail(
                    "Timed out waiting for bytesTransferred == \(expected); " +
                    "current value: \(sut.bytesTransferred)"
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
