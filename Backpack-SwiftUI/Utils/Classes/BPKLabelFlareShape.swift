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

struct LabelFlareShape: Shape {
    private let flareSize: CGSize
    private let cornerRadius = BPKSpacing.sm
    
    init(flareHeight: CGFloat) {
        flareSize = CGSize(width: BPKSpacing.base.value, height: flareHeight)
    }
    
    func path(in rect: CGRect) -> Path {
        let size = rect.size
        return Path { path in
            path.addRoundedRect(
                in: CGRect(
                    origin: .zero,
                    size: CGSize(width: size.width, height: size.height - flareSize.height)
                ),
                cornerSize: CGSize(width: cornerRadius.value, height: cornerRadius.value))
            appendFlare(
                to: &path,
                startPoint: CGPoint(x: size.width / 2, y: size.height),
                flareSize: flareSize
            )
        }
    }
    
    private func appendFlare(to path: inout Path, startPoint: CGPoint, flareSize: CGSize) {
        let startPointY = startPoint.y - flareSize.height
        let centerPoint = startPoint.x
        path.move(to: CGPoint(x: centerPoint - flareSize.width / 2, y: startPointY))
        
        let courvePoint: CGFloat = 2
        path.addLine(to: CGPoint(x: centerPoint - courvePoint, y: startPoint.y - courvePoint / 2))
        
        let center = CGPoint(x: centerPoint + courvePoint, y: startPoint.y - courvePoint / 2)
        let curveCenter1 = CGPoint(x: centerPoint - courvePoint / 2, y: startPointY + flareSize.height)
        let curveCenter2 = CGPoint(x: centerPoint + courvePoint / 2, y: startPointY + flareSize.height)
        path.addCurve(to: center, control1: curveCenter1, control2: curveCenter2)
        
        path.addLine(to: CGPoint(x: centerPoint + flareSize.width / 2, y: startPointY))
    }
}

struct BPKPriceMapLabelFlareShape_Previews: PreviewProvider {
    static var previews: some View {
        Color(.coreAccentColor)
            .clipShape(LabelFlareShape(flareHeight: 6))
    }
}
