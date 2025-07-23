/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2025 Skyscanner Ltd
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

/// A model that encapsulates blur styling options for SwiftUI views.
/// It allows for both standard and progressive (gradient-based) blurs.

public struct BPKBlur {
    /// The radius of the blur effect.
    let radius: CGFloat = 4
    
    public init() {}
    
}

public extension View {
    /// Applies a `BPKBlur` effect to the view.
    /// - Parameter blur: A `BPKBlur` configuration defining the type and style of the blur.
    /// - Returns: A modified view with the blur applied.
    func blur(_ blur: BPKBlur) -> some View {
        self.blur(radius: blur.radius, opaque: true)
    }
}
