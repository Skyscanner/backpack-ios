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

public struct BottomSheetInsets {
    public let full: CGFloat?
    public let half: CGFloat?
    public let tip: CGFloat?
    
    public enum Constants {
        static let bottomSheetHeightInHalfPosition: CGFloat = 386.0
        static let bottomSheetHeightInTipPosition: CGFloat = 120.0
    }
    
    /// Default insets for the bottom sheet.
    public init() {
        self.init(
            full: nil,
            half: Constants.bottomSheetHeightInHalfPosition,
            tip: Constants.bottomSheetHeightInTipPosition
        )
    }
    
    /// Use this initializer to have full control over the heights and spacing of your bottom sheet
    /// - Parameters:
    ///   - full: A top inset from the safe area
    ///   - half: A bottom inset from the safe area
    ///   - tip:  A bottom inset from the safe area
    public init(full: CGFloat?, half: CGFloat?, tip: CGFloat?) {
        self.full = full
        self.half = half
        self.tip = tip
    }
}

extension BottomSheetInsets {
    /// The largest share of the window's safe-area height that the half and tip positions may cover,
    /// so the sheet never outgrows a short window, such as a phone in landscape.
    static let maximumPartialHeightFraction: CGFloat = 0.6

    var fullAnchor: FloatingPanelLayoutAnchoring {
        guard let full = full else {
            return FloatingPanelLayoutAnchor(
                absoluteInset: BPKSpacingNone,
                edge: .top,
                referenceGuide: .safeArea
            )
        }
        
        return FloatingPanelLayoutAnchor(absoluteInset: full, edge: .top, referenceGuide: .safeArea)
    }
    
    var halfAnchor: FloatingPanelLayoutAnchoring {
        halfAnchor(availableHeight: nil)
    }
    
    var tipAnchor: FloatingPanelLayoutAnchoring {
        tipAnchor(availableHeight: nil)
    }

    /// - Parameter availableHeight: The window's safe-area height, when known.
    func halfAnchor(availableHeight: CGFloat?) -> FloatingPanelLayoutAnchoring {
        let inset = half ?? Constants.bottomSheetHeightInHalfPosition
        return FloatingPanelLayoutAnchor(
            absoluteInset: Self.fitting(inset, into: availableHeight),
            edge: .bottom,
            referenceGuide: .safeArea
        )
    }

    /// - Parameter availableHeight: The window's safe-area height, when known.
    func tipAnchor(availableHeight: CGFloat?) -> FloatingPanelLayoutAnchoring {
        let inset = tip ?? Constants.bottomSheetHeightInTipPosition
        return FloatingPanelLayoutAnchor(
            absoluteInset: Self.fitting(inset, into: availableHeight),
            edge: .bottom,
            referenceGuide: .safeArea
        )
    }

    static func fitting(_ inset: CGFloat, into availableHeight: CGFloat?) -> CGFloat {
        guard let availableHeight, availableHeight > 0 else { return inset }
        return min(inset, availableHeight * maximumPartialHeightFraction)
    }
}
