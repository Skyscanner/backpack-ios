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

import Combine
import XCTest
@testable import Backpack_SwiftUI

final class BPKVideoPlayerPlaybackMetricsTrackerTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    func test_publisher_beforeDurationKnown_emitsNothing() {
        let sut = BPKVideoPlayerPlaybackMetricsTracker()
        var received: [BPKVideoPlayerPlaybackMetrics] = []

        sut.publisher.sink { received.append($0) }.store(in: &cancellables)

        XCTAssertTrue(received.isEmpty)
        XCTAssertNil(sut.metrics)
    }

    func test_updateDuration_publishesCurrentMetrics() {
        let sut = BPKVideoPlayerPlaybackMetricsTracker()
        var received: [BPKVideoPlayerPlaybackMetrics] = []
        sut.publisher.sink { received.append($0) }.store(in: &cancellables)

        sut.updateDuration(10)

        XCTAssertEqual(received, [.init(playTime: 0, duration: 10, fractionPlayed: 0)])
        XCTAssertEqual(sut.metrics, received.last)
    }

    func test_publisher_forLateSubscriber_replaysLatestMetrics() {
        let sut = BPKVideoPlayerPlaybackMetricsTracker()
        sut.updateDuration(10)
        sut.recordSample(playhead: 0, duration: 10, isLooping: false)
        sut.recordSample(playhead: 2, duration: 10, isLooping: false)
        var received: [BPKVideoPlayerPlaybackMetrics] = []

        sut.publisher.sink { received.append($0) }.store(in: &cancellables)

        XCTAssertEqual(received, [.init(playTime: 2, duration: 10, fractionPlayed: 0.2)])
    }

    func test_repeatedSample_suppressesDuplicateMetrics() {
        let sut = BPKVideoPlayerPlaybackMetricsTracker()
        var received: [BPKVideoPlayerPlaybackMetrics] = []
        sut.publisher.sink { received.append($0) }.store(in: &cancellables)
        sut.updateDuration(10)
        sut.recordSample(playhead: 0, duration: 10, isLooping: false)
        sut.recordSample(playhead: 1, duration: 10, isLooping: false)

        sut.recordSample(playhead: 1, duration: 10, isLooping: false)

        XCTAssertEqual(received.count, 2)
    }
}
