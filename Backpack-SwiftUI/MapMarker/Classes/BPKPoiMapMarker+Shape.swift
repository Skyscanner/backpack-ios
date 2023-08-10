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

extension BPKPoiMapMarker {
    struct MarkerShape: Shape {
        func path(in rect: CGRect) -> Path {
            let size = rect.size
            return Path { path in
                path.addRelativeArc(
                    center: CGPoint(x: size.width / 2, y: size.width / 2),
                    radius: size.width / 2,
                    startAngle: .degrees(30),
                    delta: .degrees(-240)
                )
                
                let courvePoint: CGFloat = 3
                path.addRelativeArc(
                    center: CGPoint(x: size.width / 2, y: size.height - courvePoint),
                    radius: courvePoint,
                    startAngle: .degrees(120),
                    delta: .degrees(-60)
                )
                
                path.closeSubpath()
            }
        }
    }
}

struct BPKPoiMapMarkerShape_Previews: PreviewProvider {
    static var previews: some View {
        Color(.coreAccentColor)
            .clipShape(BPKPoiMapMarker.MarkerShape())
            .frame(width: 32, height: 40)
    }
}
