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

/// A custom shape that creates a path with a flare at one end.
struct FlarePath: Shape {
    /// The height of the flare.
    let flareHeight: CGFloat
    /// The corner radius of the rounded rectangle.
    let cornerRadius: BPKSpacing
    /// The direction of the flare.
    let direction: BPKFlareDirection
    
    /// Creates a path with a flare at one end.
    func path(in rect: CGRect) -> Path {
        let size = rect.size
        return Path { path in
            let contentTop = direction == .top ? flareHeight : 0
            let contentBottom = direction == .top ? size.height : size.height - flareHeight
            
            let contentRect = CGRect(x: 0, y: contentTop, width: size.width, height: contentBottom - contentTop)
            path.addRoundedRect(
                in: contentRect,
                cornerSize: CGSize(width: cornerRadius.value, height: cornerRadius.value))
            appendFlare(to: &path, size: size, flareHeight: flareHeight)
        }
    }
    
    /// Appends a flare to the path.
    /// - Parameters:
    ///   - path: The path to append the flare to.
    ///   - size: The size of the bounding rectangle of the path.
    ///   - flareHeight: The height of the flare.
    private func appendFlare(to path: inout Path, size: CGSize, flareHeight: CGFloat) {
        let BPKFlareVectorHeight = 56.0 // The height of the original flare vector
        let BPKFlareVectorWidth = 230.0 // The width of the original flare vector
        
        // The scale factor to adjust the size of the flare
        let scale = direction.scaleFactor * (flareHeight / BPKFlareVectorHeight)
        
        let startPointX = (size.width - scale * BPKFlareVectorWidth) / 2.0
        let startPointY = direction == .top ? flareHeight : size.height - flareHeight
        
        let sp = CGPoint(x: startPointX, y: startPointY)
        path.move(to: CGPoint(x: sp.x, y: sp.y))
        
        let left = CGPoint(x: sp.x + 33.69 * scale, y: sp.y + 8.51 * scale)
        let curveLeft1 = CGPoint(x: sp.x + 14.66 * scale, y: sp.y + 0.41 * scale)
        let curveLeft2 = CGPoint(x: sp.x + 24.74 * scale, y: sp.y + 3.33 * scale)
        path.addCurve(to: left, control1: curveLeft1, control2: curveLeft2)
        
        path.addLine(to: CGPoint(x: sp.x + 101.74 * scale, y: sp.y + 47.86 * scale))
        
        let center = CGPoint(x: sp.x + 136.26 * scale, y: sp.y + 47.86 * scale)
        let curveCenter1 = CGPoint(x: sp.x + 112.37 * scale, y: sp.y + 54.04 * scale)
        let curveCenter2 = CGPoint(x: sp.x + 125.53 * scale, y: sp.y + 54.04 * scale)
        path.addCurve(to: center, control1: curveCenter1, control2: curveCenter2)
        
        path.addLine(to: CGPoint(x: sp.x + 204.41 * scale, y: sp.y + 8.52 * scale))
        
        let right = CGPoint(x: sp.x + 233.72 * scale, y: sp.y)
        let curveRight1 = CGPoint(x: sp.x + 213.32 * scale, y: sp.y + 3.35 * scale)
        let curveRight2 = CGPoint(x: sp.x + 223.4 * scale, y: sp.y + 0.3 * scale)
        path.addCurve(to: right, control1: curveRight1, control2: curveRight2)
    }
}

struct FlarePath_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Color(.coreAccentColor)
                .clipShape(FlarePath(flareHeight: 20, cornerRadius: .xxl, direction: .bottom))
            Color(.coreAccentColor)
                .clipShape(FlarePath(flareHeight: 50, cornerRadius: .none, direction: .top))
        }
        .padding()
    }
}
