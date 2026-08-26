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

/// A normalized snapshot of cumulative video playback metrics.
public struct BPKVideoPlayerProgress: Equatable, Sendable {
    /// Cumulative active playback time, in seconds.
    public let playTime: TimeInterval

    /// The finite, positive media duration, in seconds.
    public let duration: TimeInterval

    /// The current playhead fraction, normalized to `0...1`.
    public let fractionPlayed: Double

    public init(
        playTime: TimeInterval,
        duration: TimeInterval,
        fractionPlayed: Double
    ) {
        self.playTime = playTime
        self.duration = duration
        self.fractionPlayed = fractionPlayed
    }
}
