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
    private(set) var progress: BPKVideoPlayerProgress?

    private var playTime: TimeInterval = 0
    private var duration: TimeInterval?
    private var furthestFractionPlayed: Double = 0
    private var lastPlayhead: TimeInterval?
    private var isAwaitingSeekCompletion = false

    mutating func updateDuration(_ candidate: TimeInterval?) {
        guard let duration = validDuration(candidate) else { return }

        self.duration = duration
        if let lastPlayhead {
            updateFurthestFraction(for: lastPlayhead)
        }
        refreshProgress()
    }

    mutating func recordSample(
        playhead candidate: TimeInterval,
        duration: TimeInterval?,
        isLooping: Bool
    ) {
        guard let playhead = validPlayhead(candidate), !isAwaitingSeekCompletion else { return }

        updateDuration(duration)

        guard let lastPlayhead else {
            self.lastPlayhead = playhead
            // Periodic observation may first run after playback has started.
            addPlayTime(playhead)
            updateFurthestFraction(for: playhead)
            refreshProgress()
            return
        }

        if playhead >= lastPlayhead {
            addPlayTime(playhead - lastPlayhead)
            updateFurthestFraction(for: playhead)
        } else if isLooping, let duration = self.duration {
            // A backwards playhead in looping playback crossed the end boundary.
            addPlayTime(max(duration - lastPlayhead, 0) + playhead)
            furthestFractionPlayed = 1
        }

        self.lastPlayhead = playhead
        refreshProgress()
    }

    mutating func recordCompletion(duration candidate: TimeInterval?, isLooping: Bool) {
        guard let duration = validDuration(candidate) else { return }
        updateDuration(duration)

        if !isLooping {
            // The completion notification can arrive before the final periodic sample.
            addPlayTime(max(duration - (lastPlayhead ?? 0), 0))
            lastPlayhead = duration
        }

        furthestFractionPlayed = 1
        refreshProgress()
    }

    mutating func beginRebase() {
        // Ignore observer samples emitted while AVPlayer is performing a seek.
        isAwaitingSeekCompletion = true
    }

    mutating func endRebase(at candidate: TimeInterval, duration: TimeInterval?) {
        defer { isAwaitingSeekCompletion = false }
        updateDuration(duration)
        lastPlayhead = validPlayhead(candidate)
    }

    private mutating func addPlayTime(_ delta: TimeInterval) {
        guard delta.isFinite, delta > 0 else { return }
        playTime += delta
    }

    private mutating func updateFurthestFraction(for playhead: TimeInterval) {
        guard let duration else { return }
        furthestFractionPlayed = max(
            furthestFractionPlayed,
            min(max(playhead / duration, 0), 1)
        )
    }

    private mutating func refreshProgress() {
        guard let duration else {
            progress = nil
            return
        }
        progress = BPKVideoPlayerProgress(
            playTime: playTime,
            duration: duration,
            fractionPlayed: furthestFractionPlayed
        )
    }

    private func validPlayhead(_ value: TimeInterval) -> TimeInterval? {
        value.isFinite && value >= 0 ? value : nil
    }

    private func validDuration(_ value: TimeInterval?) -> TimeInterval? {
        guard let value, value.isFinite, value > 0 else { return nil }
        return value
    }
}
