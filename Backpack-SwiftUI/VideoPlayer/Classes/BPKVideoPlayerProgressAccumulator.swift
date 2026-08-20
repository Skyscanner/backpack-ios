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

import Foundation

/// Builds stable playback progress from periodic AVPlayer playhead samples.
///
/// AVPlayer exposes its current playhead, but the public progress API needs two
/// different measurements: cumulative time actually played and the furthest
/// fraction reached. This type keeps those measurements separate so replaying a
/// section increases `playTime` without reducing or inflating `fractionPlayed`.
/// It also handles loop boundaries, seeks, and the unsampled tail at completion.
struct BPKVideoPlayerProgressAccumulator {
    private var playTime: TimeInterval = 0
    private var duration: TimeInterval?
    private var furthestFractionPlayed: Double = 0
    private var lastPlayhead: TimeInterval?
    private var isSeeking = false

    var progress: BPKVideoPlayerProgress? {
        guard let duration else { return nil }
        return BPKVideoPlayerProgress(
            playTime: playTime,
            duration: duration,
            fractionPlayed: furthestFractionPlayed
        )
    }

    mutating func setDuration(_ candidate: TimeInterval?) {
        if let candidate, candidate.isFinite, candidate > 0 {
            duration = candidate
            updateFurthestFraction()
        }
    }

    mutating func record(
        playhead candidate: TimeInterval,
        duration: TimeInterval?,
        isLooping: Bool
    ) {
        guard candidate.isFinite, candidate >= 0, !isSeeking else { return }

        setDuration(duration)
        let completedLoop = isLooping && lastPlayhead.map { candidate < $0 } == true
        playTime += elapsedTime(to: candidate, isLooping: isLooping)
        lastPlayhead = candidate
        if completedLoop {
            furthestFractionPlayed = 1
        } else {
            updateFurthestFraction()
        }
    }

    mutating func complete(duration candidate: TimeInterval?, isLooping: Bool) {
        guard let candidate, candidate.isFinite, candidate > 0 else { return }
        duration = candidate

        if !isLooping {
            playTime += max(candidate - (lastPlayhead ?? 0), 0)
            lastPlayhead = candidate
        }

        furthestFractionPlayed = 1
    }

    mutating func beginSeek() {
        isSeeking = true
    }

    mutating func endSeek(at playhead: TimeInterval, duration: TimeInterval?) {
        setDuration(duration)
        lastPlayhead = playhead.isFinite && playhead >= 0 ? playhead : nil
        isSeeking = false
    }

    private func elapsedTime(to playhead: TimeInterval, isLooping: Bool) -> TimeInterval {
        guard let lastPlayhead else { return playhead }
        guard playhead < lastPlayhead else { return playhead - lastPlayhead }
        guard isLooping, let duration else { return 0 }

        return max(duration - lastPlayhead, 0) + playhead
    }

    private mutating func updateFurthestFraction() {
        guard let duration, let lastPlayhead else { return }

        furthestFractionPlayed = max(
            furthestFractionPlayed,
            min(lastPlayhead / duration, 1)
        )
    }
}
