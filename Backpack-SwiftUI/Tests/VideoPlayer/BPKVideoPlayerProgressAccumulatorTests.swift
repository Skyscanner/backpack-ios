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

import XCTest
@testable import Backpack_SwiftUI

final class BPKVideoPlayerProgressAccumulatorTests: XCTestCase {
    func test_whenInitialized_thenProgressIsUnavailable() {
        // Given
        let sut = makeSUT()

        // When
        let progress = sut.progress

        // Then
        XCTAssertNil(progress)
    }

    func test_givenFinitePositiveDuration_whenSet_thenProgressIsAvailable() {
        // Given
        var sut = makeSUT()

        // When
        sut.setDuration(10)

        // Then
        assertProgress(sut.progress, playTime: 0, duration: 10, fractionPlayed: 0)
    }

    func test_givenInvalidDuration_whenSet_thenProgressIsUnavailable() {
        // Given
        for duration in [0, -1, .nan, .infinity] {
            var sut = makeSUT()

            // When
            sut.setDuration(duration)

            // Then
            XCTAssertNil(sut.progress)
        }
    }

    func test_givenForwardSamples_whenRecorded_thenAccumulatesPlayTimeAndMaximumFraction() {
        // Given
        var sut = makeSUT()

        // When
        record([0, 0.25, 0.25, 0.5], on: &sut, duration: 10)

        // Then
        assertProgress(sut.progress, playTime: 0.5, duration: 10, fractionPlayed: 0.05)
    }

    func test_givenPlaybackAlreadyAdvanced_whenFirstSampleRecorded_thenCountsFromStart() {
        // Given
        var sut = makeSUT()

        // When
        sut.record(playhead: 0.25, duration: 10, isLooping: false)

        // Then
        assertProgress(sut.progress, playTime: 0.25, duration: 10, fractionPlayed: 0.025)
    }

    func test_givenInvalidPlayhead_whenRecorded_thenIsIgnored() {
        // Given
        var sut = makeSUT()
        record([0, 1], on: &sut, duration: 10)

        // When
        for playhead in [-1, .nan, .infinity] {
            sut.record(playhead: playhead, duration: 10, isLooping: false)
        }

        // Then
        assertProgress(sut.progress, playTime: 1, duration: 10, fractionPlayed: 0.1)
    }

    func test_givenLoopingPlayback_whenPlayheadMovesBackward_thenCountsBoundaryAndCompletesFraction() {
        // Given
        var sut = makeSUT()

        // When
        record([0, 9.8, 0.1], on: &sut, duration: 10, isLooping: true)

        // Then
        assertProgress(sut.progress, playTime: 10.1, duration: 10, fractionPlayed: 1)
    }

    func test_givenLoopingPlayback_whenCompleted_thenDoesNotDoubleCountLoopTail() {
        // Given
        var sut = makeSUT()
        record([0, 9.8], on: &sut, duration: 10, isLooping: true)

        // When
        sut.complete(duration: 10, isLooping: true)
        sut.record(playhead: 0.1, duration: 10, isLooping: true)

        // Then
        assertProgress(sut.progress, playTime: 10.1, duration: 10, fractionPlayed: 1)
    }

    func test_givenNonLoopingPlayback_whenCompleted_thenCountsUnsampledTail() {
        // Given
        var sut = makeSUT()
        record([0, 9.8], on: &sut, duration: 10)

        // When
        sut.complete(duration: 10, isLooping: false)

        // Then
        assertProgress(sut.progress, playTime: 10, duration: 10, fractionPlayed: 1)
    }

    func test_givenNoSamples_whenNonLoopingPlaybackCompletes_thenCountsWholeVideo() {
        // Given
        var sut = makeSUT()

        // When
        sut.complete(duration: 10, isLooping: false)

        // Then
        assertProgress(sut.progress, playTime: 10, duration: 10, fractionPlayed: 1)
    }

    func test_givenNonLoopingPlayback_whenPlayheadMovesBackward_thenRebasesWithoutCountingJump() {
        // Given
        var sut = makeSUT()

        // When
        record([0, 5, 1, 2], on: &sut, duration: 10)

        // Then
        assertProgress(sut.progress, playTime: 6, duration: 10, fractionPlayed: 0.5)
    }

    func test_whenSeeking_thenExcludesSeekDistanceAndPreservesMaximumFraction() {
        // Given
        var sut = makeSUT()
        record([0, 2], on: &sut, duration: 10)

        // When
        sut.beginSeek()
        sut.record(playhead: 8, duration: 10, isLooping: false)
        sut.endSeek(at: 8, duration: 10)
        sut.record(playhead: 9, duration: 10, isLooping: false)

        // Then
        assertProgress(sut.progress, playTime: 3, duration: 10, fractionPlayed: 0.9)
    }

    func test_givenReplayedSection_whenRecorded_thenIncreasesPlayTimeWithoutInflatingFraction() {
        // Given
        var sut = makeSUT()
        record([0, 5], on: &sut, duration: 10)

        // When
        sut.beginSeek()
        sut.endSeek(at: 0, duration: 10)
        sut.record(playhead: 5, duration: 10, isLooping: false)

        // Then
        assertProgress(sut.progress, playTime: 10, duration: 10, fractionPlayed: 0.5)
    }

    private func makeSUT() -> BPKVideoPlayerProgressAccumulator {
        BPKVideoPlayerProgressAccumulator()
    }

    private func record(
        _ samples: [TimeInterval],
        on sut: inout BPKVideoPlayerProgressAccumulator,
        duration: TimeInterval,
        isLooping: Bool = false
    ) {
        samples.forEach {
            sut.record(playhead: $0, duration: duration, isLooping: isLooping)
        }
    }

    private func assertProgress(
        _ progress: BPKVideoPlayerProgress?,
        playTime: TimeInterval,
        duration: TimeInterval,
        fractionPlayed: Double,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard let progress else {
            return XCTFail("Expected playback progress", file: file, line: line)
        }
        XCTAssertEqual(progress.playTime, playTime, accuracy: 0.000_001, file: file, line: line)
        XCTAssertEqual(progress.duration, duration, accuracy: 0.000_001, file: file, line: line)
        XCTAssertEqual(progress.fractionPlayed, fractionPlayed, accuracy: 0.000_001, file: file, line: line)
    }
}
