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

// The fold APIs ship with the iOS 27.1 SDK (Swift 6.4). Older toolchains, such as the Xcode used on CI,
// don't see this extension.
#if compiler(>=6.4)
@available(iOS 27.1, *)
public extension UIView {
    /// The fold of a partially folded foldable, such as an iPhone Duo in book pose, in this view's
    /// coordinate space. `nil` when the device is closed, fully open, or not a foldable.
    ///
    /// Use it to keep controls, sheets and dialogs from straddling the fold.
    var bpkActiveFoldFrame: CGRect? {
        reservedRegions(kind: .division).first(where: \.isActive)?.frame
    }
}
#endif
