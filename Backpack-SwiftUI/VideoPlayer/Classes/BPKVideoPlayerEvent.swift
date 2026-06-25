/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
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

public enum BPKVideoPlayerEvent {
    case loading
    case readyToPlay
    /// Fired when the first video frame is visible on screen — safe to hide poster/spinner.
    /// Unlike `readyToPlay` (which fires when the asset is decoded), this fires only after
    /// `AVPlayerLayer.isReadyForDisplay` becomes true, guaranteeing no black flash.
    case firstFrameRendered
    case playing
    case paused
    case buffering
    case ended
    case failed(Error)
}

extension BPKVideoPlayerEvent: Equatable {
    // Equality semantics for .failed are intentionally coarse — all failures compare equal.
    // Fine for state guards (e.g. event == .failed(...)), but consumers should not rely
    // on this for distinguishing error types; inspect the associated Error directly instead.
    public static func == (lhs: BPKVideoPlayerEvent, rhs: BPKVideoPlayerEvent) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
             (.readyToPlay, .readyToPlay),
             (.firstFrameRendered, .firstFrameRendered),
             (.playing, .playing),
             (.paused, .paused),
             (.buffering, .buffering),
             (.ended, .ended):
            return true
        case (.failed, .failed):
            return true
        default:
            return false
        }
    }
}
