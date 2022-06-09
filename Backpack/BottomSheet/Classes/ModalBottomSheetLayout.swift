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

/// Layout implementation where the BPKBottomSheet will be presented modaly. The parent ViewController
/// will not be interactable, there will be an overlay in the Parent ViewController,
/// and the BPKBottomShet can be dismissed
public final class ModalBottomSheetLayout: FloatingPanelLayout {
    public let position: FloatingPanelPosition = .bottom
    
    /// Initial position of BPKBottomSheet
    public let initialState: FloatingPanelState = .half
    
    /// All supported positions of BPKBottomSheet
    public var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: insets.fullAnchor,
            .half: insets.halfAnchor
        ]
    }
    
    /// Method to define the overlay in the parent view controller
    public func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
        case .full, .half:
            return Constants.backdropAlpha
        default:
            return 0.0
        }
    }
    
    private let insets: BottomSheetInsets
    
    public init(insets: BottomSheetInsets) {
        self.insets = insets
    }
}

private enum Constants {
    static let backdropAlpha: CGFloat = 0.3
}
