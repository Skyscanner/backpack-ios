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

/// Horizontal placement shared by every `BPKBottomSheet` layout.
///
/// FloatingPanel's default pins the sheet to the safe area's left and right edges. On a phone-sized
/// window that stops the sheet short of a side safe area, such as the iPhone Duo's side rail, and on a
/// wide window it stretches the sheet edge to edge. Instead, the sheet fills the window's full width up
/// to `maximumWidth` and is centred beyond it, like a native sheet. The sheet's own content still
/// receives the safe-area insets, so it stays clear of the rail while the background runs under it.
enum BottomSheetHorizontalLayout {
    /// The widest the sheet gets: UIKit's readable content width at the default text size. Narrower
    /// windows, such as the iPhone Duo's inner display in portrait, keep a full-width sheet, as native
    /// sheets do.
    static let maximumWidth: CGFloat = 672

    static func constraints(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        // Just below required: it must win over anything inside the sheet, such as a label's
        // compression resistance, and only give way to the maximum width.
        let fillWidth = surfaceView.widthAnchor.constraint(equalTo: view.widthAnchor)
        fillWidth.priority = .init(UILayoutPriority.required.rawValue - 1)
        return [
            surfaceView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            surfaceView.widthAnchor.constraint(lessThanOrEqualToConstant: maximumWidth),
            fillWidth
        ]
    }
}
