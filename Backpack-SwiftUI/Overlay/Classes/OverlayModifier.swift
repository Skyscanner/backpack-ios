/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

struct OverlayModifier: ViewModifier {
    let type: BPKOverlayType
    private let baseColor = Color(.textOnLightColor)
    
    func body(content: Content) -> some View {
        content
            .overlay(overlay)
    }
    
    @ViewBuilder
    private var overlay: some View {
        switch type {
        case .solid(let level):
            baseColor.opacity(level.opacity)
        case .linear(let level, let direction):
            LinearGradient(
                gradient: Gradient(colors: [baseColor.opacity(level.opacity), baseColor.opacity(0)]),
                startPoint: direction.startPoint,
                endPoint: direction.endPoint
            )
        case .vignette:
            RadialGradient(
                gradient: Gradient(colors: [baseColor.opacity(0), baseColor.opacity(BPKOverlayType.vignette.opacity)]),
                center: .center,
                startRadius: 0,
                endRadius: 50
            )
        }
    }
}

public extension View {
    func bpkOverlay(_ type: BPKOverlayType) -> some View {
        self.modifier(OverlayModifier(type: type))
    }
}
