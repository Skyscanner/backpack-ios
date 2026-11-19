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

import SwiftUI

/// The widest a column of text and controls should get before it's hard to read.
public enum BPKReadableContentWidth {
    /// Matches UIKit's readable content width at the default text size. A candidate for a design token.
    public static let maximum: CGFloat = 672
}

public extension View {
    /// Caps the view at a readable width and centres it, so content doesn't stretch across a wide
    /// window such as an iPad or an unfolded iPhone Duo. On a phone-sized window it changes nothing.
    ///
    /// - Parameter maximumWidth: The widest the content gets. Defaults to `BPKReadableContentWidth.maximum`.
    func bpkReadableContentWidth(_ maximumWidth: CGFloat = BPKReadableContentWidth.maximum) -> some View {
        frame(maxWidth: maximumWidth)
            .frame(maxWidth: .infinity)
    }
}
