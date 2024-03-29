/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

import FloatingPanel

/// Enum values for specifying BottomSheet position
@objc(BPKFloatingPanelPosition)
public enum BPKFloatingPanelPosition: Int {
    case full
    case half
    case tip
    case hidden
}

extension BPKFloatingPanelPosition {
    // create a BPKFloatingPanelPosition from a 3rd party FloatingPanelPosition
    init(floatingPanelPosition: FloatingPanelState) {
        switch floatingPanelPosition {
        case .full:
            self = .full
        case .half:
            self = .half
        case .tip:
            self = .tip
        case .hidden:
            self = .hidden
        default:
            self = .half
        }
    }

    var asFloatingPanelPosition: FloatingPanelState {
        switch self {
        case .full:
            return .full
        case .half:
            return .half
        case .tip:
            return .tip
        case .hidden:
            return .hidden
        }
    }
}
