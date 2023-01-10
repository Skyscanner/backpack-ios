// clang-format off
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

public struct BPKCornerRadius {
    public let value: CGFloat
    
    private init(value: CGFloat) {
        self.value = value
    }
}

public extension RoundedRectangle {
    init(cornerRadius: BPKCornerRadius, style: RoundedCornerStyle = .circular) {
        self.init(cornerRadius: cornerRadius.value, style: style)
    }
}

public extension BPKCornerRadius {
    
    /// The Skyscanner medium radius.
    static let md = BPKCornerRadius(value: 12)

    /// The Skyscanner small radius.
    static let sm = BPKCornerRadius(value: 8)

    /// The Skyscanner extra small radius.
    static let xs = BPKCornerRadius(value: 4)

    /// The Skyscanner large radius.
    static let lg = BPKCornerRadius(value: 24)
}