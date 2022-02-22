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

/// Layout implementation where the BPKBottomSheet will remain persistent in the parent
/// ViewController. There is no overlay and the parent ViewController remains interactable
public final class PersistentBottomSheetLayout: FloatingPanelLayout {
    /// Initial position of BPKBottomSheet
    public var initialPosition: FloatingPanelPosition {
        return .half
    }

    /// All supported positions of BPKBottomSheet
    public var supportedPositions: Set<FloatingPanelPosition> {
        return [.half, .full, .tip]
    }
    
    private let insets: BottomSheetInsets
    
    public init(insets: BottomSheetInsets) {
        self.insets = insets
    }

    /// Method to describe the height of BPKBottomSheet in each position
    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .half:
            return insets.half
        case .tip:
            return insets.tip
        default:
            return insets.full
        }
    }

    /// Method to define the overlay in the parent view controller
    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.0
    }
}

private enum Constants {
    static let bottomSheetHeightInHalfPosition: CGFloat = 386.0
    static let bottomSheetHeightInTipPosition: CGFloat = 120.0
}
