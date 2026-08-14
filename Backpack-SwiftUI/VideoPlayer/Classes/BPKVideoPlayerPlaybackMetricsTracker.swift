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
import Foundation

final class BPKVideoPlayerPlaybackMetricsTracker {
    private var accumulator = BPKVideoPlayerPlaybackMetricsAccumulator()
    private let subject = CurrentValueSubject<BPKVideoPlayerPlaybackMetrics?, Never>(nil)

    var metrics: BPKVideoPlayerPlaybackMetrics? {
        subject.value
    }

    var publisher: AnyPublisher<BPKVideoPlayerPlaybackMetrics, Never> {
        subject.compactMap { $0 }.eraseToAnyPublisher()
    }

    func updateDuration(_ duration: TimeInterval?) {
        accumulator.updateDuration(duration)
        publishIfChanged()
    }

    func recordSample(playhead: TimeInterval, duration: TimeInterval?, isLooping: Bool) {
        accumulator.recordSample(playhead: playhead, duration: duration, isLooping: isLooping)
        publishIfChanged()
    }

    func recordCompletion(duration: TimeInterval?, isLooping: Bool) {
        accumulator.recordCompletion(duration: duration, isLooping: isLooping)
        publishIfChanged()
    }

    func beginRebase() {
        accumulator.beginRebase()
    }

    func endRebase(at playhead: TimeInterval, duration: TimeInterval?) {
        accumulator.endRebase(at: playhead, duration: duration)
        publishIfChanged()
    }

    private func publishIfChanged() {
        guard accumulator.metrics != subject.value else { return }
        subject.send(accumulator.metrics)
    }
}
