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

struct BPKVideoPlayerProgressAccumulator {
    private(set) var progress: BPKVideoPlayerProgress?

    private var playTime: TimeInterval = 0
    private var duration: TimeInterval?
    private var maximumFractionPlayed: Double = 0
    private var previousPlayhead: TimeInterval?
    private var isRebasing = false

    mutating func updateDuration(_ candidate: TimeInterval?) {
        guard let duration = validDuration(candidate) else { return }

        self.duration = duration
        if let previousPlayhead {
            updateMaximumFraction(for: previousPlayhead)
        }
        refreshProgress()
    }

    mutating func recordSample(
        playhead candidate: TimeInterval,
        duration: TimeInterval?,
        isLooping: Bool
    ) {
        guard let playhead = validPlayhead(candidate), !isRebasing else { return }

        updateDuration(duration)

        guard let previousPlayhead else {
            self.previousPlayhead = playhead
            updateMaximumFraction(for: playhead)
            return
        }

        if playhead >= previousPlayhead {
            addPlayTime(playhead - previousPlayhead)
            updateMaximumFraction(for: playhead)
        } else if isLooping, let duration = self.duration {
            addPlayTime(max(duration - previousPlayhead, 0) + playhead)
            maximumFractionPlayed = 1
            refreshProgress()
        }

        self.previousPlayhead = playhead
    }

    mutating func recordCompletion(duration candidate: TimeInterval?, isLooping: Bool) {
        guard let duration = validDuration(candidate) else { return }
        updateDuration(duration)

        if !isLooping {
            if let previousPlayhead {
                addPlayTime(max(duration - previousPlayhead, 0))
            }
            previousPlayhead = duration
        }

        maximumFractionPlayed = 1
        refreshProgress()
    }

    mutating func beginRebase() {
        isRebasing = true
    }

    mutating func endRebase(at candidate: TimeInterval, duration: TimeInterval?) {
        defer { isRebasing = false }
        updateDuration(duration)
        previousPlayhead = validPlayhead(candidate)
    }

    private mutating func addPlayTime(_ delta: TimeInterval) {
        guard delta.isFinite, delta > 0 else { return }
        playTime += delta
        refreshProgress()
    }

    private mutating func updateMaximumFraction(for playhead: TimeInterval) {
        guard let duration else { return }
        maximumFractionPlayed = max(
            maximumFractionPlayed,
            min(max(playhead / duration, 0), 1)
        )
        refreshProgress()
    }

    private mutating func refreshProgress() {
        guard let duration else {
            progress = nil
            return
        }
        progress = BPKVideoPlayerProgress(
            playTime: playTime,
            duration: duration,
            fractionPlayed: maximumFractionPlayed
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
