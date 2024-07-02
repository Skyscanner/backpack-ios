/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

// Helper functions to apply the outline style
struct Outline: ViewModifier {
    let color: BPKColor
    let cornerRadius: BPKCornerRadius
    let lineWidth: CGFloat
    
    init(color: BPKColor, cornerRadius: BPKCornerRadius, lineWidth: CGFloat = 1.0) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth
    }
    
    func body(content: Content) -> some View {
        return content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(Color(color), lineWidth: lineWidth)
            )
    }
}

extension View {
    @ViewBuilder
    func outline(
        _ color: BPKColor?,
        cornerRadius: BPKCornerRadius,
        lineWidth: CGFloat = 1.0
    ) -> some View {
        if let color = color {
            let outline = Outline(
                color: color,
                cornerRadius: cornerRadius,
                lineWidth: lineWidth
            )
            self.modifier(outline)
        } else {
            self
        }
    }
}
