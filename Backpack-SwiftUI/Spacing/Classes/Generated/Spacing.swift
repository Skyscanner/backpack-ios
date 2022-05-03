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

public struct Spacing {
    public let value: CGFloat
    
    private init(value: CGFloat) {
        self.value = value
    }
}

public extension Spacing {
    
    /// The Skyscanner none spacing (0pt).
    static var none: Spacing { Spacing(value: 0) }

    /// The Skyscanner small spacing (4pt).
    static var sm: Spacing { Spacing(value: 4) }

    /// The Skyscanner icon text spacing (8pt).
    static var iconText: Spacing { Spacing(value: 8) }

    /// The Skyscanner medium spacing (8pt).
    static var md: Spacing { Spacing(value: 8) }

    /// The Skyscanner base spacing (16pt).
    static var base: Spacing { Spacing(value: 16) }

    /// The Skyscanner large spacing (24pt).
    static var lg: Spacing { Spacing(value: 24) }

    /// The Skyscanner extra large spacing (32pt).
    static var xl: Spacing { Spacing(value: 32) }

    /// The Skyscanner extra extra large spacing (40pt).
    static var xxl: Spacing { Spacing(value: 40) }
}

public extension View {
    func padding(_ spacing: Spacing) -> some View {
        padding(spacing.value)
    }

    func padding(_ edge: Edge.Set, _ spacing: Spacing) -> some View {
        padding(edge, spacing.value)
    }

    func frame(
        minWidth: Spacing? = nil,
        idealWidth: Spacing? = nil,
        maxWidth: Spacing? = nil,
        minHeight: Spacing? = nil,
        idealHeight: Spacing? = nil,
        maxHeight: Spacing? = nil,
        alignment: Alignment = .center
    ) -> some View {
        frame(
            minWidth: minWidth?.value,
            idealWidth: idealWidth?.value,
            maxWidth: maxWidth?.value,
            minHeight: minHeight?.value,
            idealHeight: idealHeight?.value,
            maxHeight: maxHeight?.value,
            alignment: alignment
        )
    }
    
    func frame(width: Spacing? = nil, height: Spacing? = nil, alignment: Alignment = .center) -> some View {
        frame(width: width?.value, height: height?.value, alignment: alignment)
    }
}

public extension Spacer {
    init(minLength: Spacing) {
        self.init(minLength: minLength.value)
    }
}
