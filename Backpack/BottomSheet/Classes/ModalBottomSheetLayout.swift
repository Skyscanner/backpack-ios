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

import UIKit
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
            .half: insets.halfAnchor(availableHeight: availableHeight)
        ]
    }

    /// Fills a phone-sized window edge to edge and is centred at a capped width on wider windows.
    public func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        BottomSheetHorizontalLayout.constraints(surfaceView: surfaceView, in: view)
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
    private let availableHeight: CGFloat?
    
    public convenience init(insets: BottomSheetInsets) {
        self.init(insets: insets, availableHeight: nil)
    }

    /// - Parameter availableHeight: The window's safe-area height, when known, so the half position fits it.
    init(insets: BottomSheetInsets, availableHeight: CGFloat?) {
        self.insets = insets
        self.availableHeight = availableHeight
    }
}

private enum Constants {
    static let backdropAlpha: CGFloat = 0.3
}
