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
final class BPKVideoPlayerControllerProgressTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    func test_whenInitialized_thenRegistersQuarterSecondObserverOnMainQueue() {
        // Given
        let observer = PeriodicTimeObserverMock()

        // When
        _ = makeSUT(observer: observer)

        // Then
        XCTAssertEqual(observer.addCallCount, 1)
        XCTAssertEqual(observer.interval?.seconds ?? 0, 0.25, accuracy: 0.000_001)
        XCTAssertEqual(observer.queue, .main)
    }

    func test_whenPeriodicSamplesArrive_thenPublishesNormalizedProgress() async {
        // Given
        let observer = PeriodicTimeObserverMock()
        let sut = makeSUT(observer: observer)
        let published = expectation(description: "Progress published")
        published.expectedFulfillmentCount = 2
        var received: [BPKVideoPlayerProgress] = []
        sut.progressPublisher.sink {
            received.append($0)
            published.fulfill()
        }.store(in: &cancellables)

        // When
        observer.send(seconds: 0)
        observer.send(seconds: 2.5)

        // Then
        await fulfillment(of: [published], timeout: 1)
        XCTAssertEqual(received.last, .init(playTime: 2.5, duration: 10, fractionPlayed: 0.25))
        XCTAssertEqual(sut.progress, received.last)
    }

    func test_whenSubscribedBeforeFirstSample_thenEmitsNothing() {
        // Given
        let sut = makeSUT(observer: PeriodicTimeObserverMock())
        var received: [BPKVideoPlayerProgress] = []

        // When
        sut.progressPublisher.sink { received.append($0) }.store(in: &cancellables)

        // Then
        XCTAssertTrue(received.isEmpty)
        XCTAssertNil(sut.progress)
    }

    func test_givenExistingProgress_whenSubscriberAttaches_thenReplaysLatestProgress() async {
        // Given
        let observer = PeriodicTimeObserverMock()
        let sut = makeSUT(observer: observer)
        observer.send(seconds: 0)
        observer.send(seconds: 2)
        let published = expectation(description: "Latest progress replayed")
        var received: [BPKVideoPlayerProgress] = []

        // When
        sut.progressPublisher.sink {
            received.append($0)
            published.fulfill()
        }.store(in: &cancellables)

        // Then
        await fulfillment(of: [published], timeout: 1)
        XCTAssertEqual(received, [.init(playTime: 2, duration: 10, fractionPlayed: 0.2)])
    }

    func test_givenRepeatedSample_whenRecorded_thenSuppressesDuplicateProgress() async {
        // Given
        let observer = PeriodicTimeObserverMock()
        let sut = makeSUT(observer: observer)
        let published = expectation(description: "Distinct progress published")
        published.expectedFulfillmentCount = 2
        var received: [BPKVideoPlayerProgress] = []
        sut.progressPublisher.sink {
            received.append($0)
            published.fulfill()
        }.store(in: &cancellables)
        observer.send(seconds: 0)
        observer.send(seconds: 1)

        // When
        observer.send(seconds: 1)

        // Then
        await fulfillment(of: [published], timeout: 1)
        XCTAssertEqual(received.count, 2)
    }

    func test_whenProgressIsPublished_thenDeliversOnMainThread() async {
        // Given
        let observer = PeriodicTimeObserverMock()
        let sut = makeSUT(observer: observer)
        let published = expectation(description: "Progress published on main thread")
        var deliveredOnMainThread = false

        sut.progressPublisher.sink { _ in
            deliveredOnMainThread = Thread.isMainThread
            published.fulfill()
        }.store(in: &cancellables)

        // When
        DispatchQueue.global().async {
            observer.send(seconds: 0.25)
        }

        // Then
        await fulfillment(of: [published], timeout: 1)
        XCTAssertTrue(deliveredOnMainThread)
    }

    func test_whenDeinitialized_thenRemovesPeriodicObserverToken() {
        // Given
        let observer = PeriodicTimeObserverMock()
        weak var weakSUT: BPKVideoPlayerController?

        // When
        autoreleasepool {
            let sut = makeSUT(observer: observer)
            weakSUT = sut
        }

        // Then
        XCTAssertNil(weakSUT)
        XCTAssertTrue(observer.removedToken === observer.addedToken)
    }

    func test_whenCurrentItemCompletes_thenPublishesCompletionProgress() async {
        // Given
        let observer = PeriodicTimeObserverMock()
        let notificationCenter = NotificationCenter()
        let sut = makeSUT(observer: observer, notificationCenter: notificationCenter)
        let completion = expectation(description: "Completion progress")
        var received: BPKVideoPlayerProgress?
        sut.progressPublisher.sink {
            received = $0
            if $0.fractionPlayed == 1 {
                completion.fulfill()
            }
        }.store(in: &cancellables)

        // When
        DispatchQueue.main.async {
            notificationCenter.post(
                name: AVPlayerItem.didPlayToEndTimeNotification,
                object: sut.player.currentItem
            )
        }

        // Then
        await fulfillment(of: [completion], timeout: 1)
        XCTAssertEqual(received, .init(playTime: 10, duration: 10, fractionPlayed: 1))
    }

    func test_givenCompletedPlayback_whenResetToStart_thenPublishesProgressFromStart() async {
        // Given
        let notificationCenter = NotificationCenter()
        let sut = makeSUT(observer: PeriodicTimeObserverMock(), notificationCenter: notificationCenter)
        await complete(sut, notificationCenter: notificationCenter)
        let reset = expectation(description: "Progress reset")
        var received: BPKVideoPlayerProgress?
        sut.progressPublisher
            .filter { $0.fractionPlayed == 0 }
            .sink {
                received = $0
                reset.fulfill()
            }
            .store(in: &cancellables)

        // When
        sut.resetToStart()

        // Then
        await fulfillment(of: [reset], timeout: 1)
        XCTAssertEqual(received, .init(playTime: 10, duration: 10, fractionPlayed: 0))
    }

    func test_givenCompletedPlayback_whenPlay_thenPublishesProgressFromStart() async {
        // Given
        let notificationCenter = NotificationCenter()
        let sut = makeSUT(observer: PeriodicTimeObserverMock(), notificationCenter: notificationCenter)
        await complete(sut, notificationCenter: notificationCenter)
        let reset = expectation(description: "Progress reset")
        var received: BPKVideoPlayerProgress?
        sut.progressPublisher
            .filter { $0.fractionPlayed == 0 }
            .sink {
                received = $0
                reset.fulfill()
            }
            .store(in: &cancellables)

        // When
        sut.play()

        // Then
        await fulfillment(of: [reset], timeout: 1)
        XCTAssertEqual(received, .init(playTime: 10, duration: 10, fractionPlayed: 0))
    }

    private func complete(
        _ sut: BPKVideoPlayerController,
        notificationCenter: NotificationCenter
    ) async {
        let completion = expectation(description: "Playback completed")
        sut.progressPublisher
            .filter { $0.fractionPlayed == 1 }
            .sink { _ in completion.fulfill() }
            .store(in: &cancellables)

        DispatchQueue.main.async {
            notificationCenter.post(
                name: AVPlayerItem.didPlayToEndTimeNotification,
                object: sut.player.currentItem
            )
        }

        await fulfillment(of: [completion], timeout: 1)
    }

    private func makeSUT(
        observer: PeriodicTimeObserverMock,
        notificationCenter: NotificationCenter = NotificationCenter()
    ) -> BPKVideoPlayerController {
        BPKVideoPlayerController(
            url: URL(string: "data:video/mp4,stub")!,
            autoPlay: false,
            loop: false,
            loadTimeout: 0,
            periodicTimeObserver: observer,
            durationProvider: { _ in 10 },
            notificationCenter: notificationCenter
        )
    }
}

private final class PeriodicTimeObserverMock: BPKVideoPlayerPeriodicTimeObserving, @unchecked Sendable {
    private(set) var addCallCount = 0
    private(set) var interval: CMTime?
    private(set) var queue: DispatchQueue?
    let addedToken = NSObject()
    private(set) var removedToken: AnyObject?
    private var callback: ((CMTime) -> Void)?

    func addPeriodicTimeObserver(
        to player: AVPlayer,
        interval: CMTime,
        queue: DispatchQueue,
        using callback: @escaping (CMTime) -> Void
    ) -> Any {
        addCallCount += 1
        self.interval = interval
        self.queue = queue
        self.callback = callback
        return addedToken
    }

    func removePeriodicTimeObserver(_ token: Any, from player: AVPlayer) {
        removedToken = token as AnyObject
    }

    func send(seconds: TimeInterval) {
        callback?(CMTime(seconds: seconds, preferredTimescale: 600))
    }
}
