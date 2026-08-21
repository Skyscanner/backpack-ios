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

protocol BPKVideoPlayerPeriodicTimeObserving {
    func addPeriodicTimeObserver(
        to player: AVPlayer,
        interval: CMTime,
        queue: DispatchQueue,
        using callback: @escaping (CMTime) -> Void
    ) -> Any

    func removePeriodicTimeObserver(_ token: Any, from player: AVPlayer)
}

struct BPKVideoPlayerPeriodicTimeObserver: BPKVideoPlayerPeriodicTimeObserving {
    func addPeriodicTimeObserver(
        to player: AVPlayer,
        interval: CMTime,
        queue: DispatchQueue,
        using callback: @escaping (CMTime) -> Void
    ) -> Any {
        player.addPeriodicTimeObserver(forInterval: interval, queue: queue, using: callback)
    }

    func removePeriodicTimeObserver(_ token: Any, from player: AVPlayer) {
        player.removeTimeObserver(token)
    }
}

typealias BPKVideoPlayerDurationProvider = (AVPlayerItem?) -> TimeInterval?

extension BPKVideoPlayerController {
    func startProgressObserving() {
        periodicTimeObserverToken = periodicTimeObserver.addPeriodicTimeObserver(
            to: player,
            interval: CMTime(seconds: 0.25, preferredTimescale: 600),
            queue: .main
        ) { [weak self] time in
            guard let self else { return }
            self.updateProgress {
                $0.record(
                    playhead: time.seconds,
                    duration: self.durationProvider(self.player.currentItem),
                    isLooping: self.loop
                )
            }
        }
    }

    func observeProgressCompletion(for item: AVPlayerItem?) {
        if let itemCompletionToken {
            notificationCenter.removeObserver(itemCompletionToken)
            self.itemCompletionToken = nil
        }
        guard let item else { return }

        itemCompletionToken = notificationCenter.addObserver(
            forName: AVPlayerItem.didPlayToEndTimeNotification,
            object: item,
            queue: .main
        ) { [weak self, weak item] _ in
            guard let self else { return }
            self.updateProgress {
                $0.complete(duration: self.durationProvider(item), isLooping: self.loop)
            }
        }
    }

    func stopProgressObserving() {
        if let periodicTimeObserverToken {
            periodicTimeObserver.removePeriodicTimeObserver(periodicTimeObserverToken, from: player)
        }
        if let itemCompletionToken {
            notificationCenter.removeObserver(itemCompletionToken)
        }
    }

    func prepareProgressForSeek() {
        updateProgress { $0.beginSeek() }
    }

    func finishProgressSeek() {
        updateProgress {
            $0.endSeek(
                at: player.currentTime().seconds,
                duration: durationProvider(player.currentItem)
            )
        }
    }

    func updateProgressDuration() {
        updateProgress { $0.setDuration(durationProvider(player.currentItem)) }
    }

    static func liveDuration(for item: AVPlayerItem?) -> TimeInterval? {
        guard let duration = item?.duration,
            duration.isNumeric,
            duration.seconds.isFinite,
            duration.seconds > 0 else {
            return nil
        }
        return duration.seconds
    }

    private func updateProgress(_ update: (inout BPKVideoPlayerProgressAccumulator) -> Void) {
        update(&progressAccumulator)
        progressSubject.send(progressAccumulator.progress)
    }
}
