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

/// Layout implementation where the BPKBottomSheet will remain persistent in the parent
/// ViewController. There is no overlay and the parent ViewController remains interactable
public final class PersistentBottomSheetLayout: FloatingPanelLayout {
    /// The position of the floating panel
    public let position: FloatingPanelPosition = .bottom
    
    /// Initial position of BPKBottomSheet
    public let initialState: FloatingPanelState = .half
    
    /// All supported positions of BPKBottomSheet
    public var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: insets.fullAnchor,
            .half: insets.halfAnchor(availableHeight: availableHeight),
            .tip: insets.tipAnchor(availableHeight: availableHeight)
        ]
    }

    /// Fills a phone-sized window edge to edge and is centred at a capped width on wider windows.
    public func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        BottomSheetHorizontalLayout.constraints(surfaceView: surfaceView, in: view)
    }
    
    /// Method to define the overlay in the parent view controller
    public func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0
    }
    
    private let insets: BottomSheetInsets
    private let availableHeight: CGFloat?
    
    public convenience init(insets: BottomSheetInsets) {
        self.init(insets: insets, availableHeight: nil)
    }

    /// - Parameter availableHeight: The window's safe-area height, when known, so the half and tip
    ///   positions fit it.
    init(insets: BottomSheetInsets, availableHeight: CGFloat?) {
        self.insets = insets
        self.availableHeight = availableHeight
    }
}
