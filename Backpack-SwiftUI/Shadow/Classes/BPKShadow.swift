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

public struct BPKShadow {
    let color: BPKColor
    let radius: CGFloat
    let offset: Offset
    let opacity: Double
    
    struct Offset {
        let x: CGFloat
        let y: CGFloat
        
        static func y(_ y: CGFloat) -> Offset {
            Offset(x: 0, y: y)
        }
    }
}

extension View {
    /// This method is internal by design.
    /// It is not meant to be used by third-parties.
    @ViewBuilder
    func shadow(_ shadow: BPKShadow?) -> some View {
        if let shadow = shadow {
            self.shadow(shadow)
        } else {
            self
        }
    }
}

public extension View {
    func shadow(_ shadow: BPKShadow) -> some View {
        self.shadow(
            color: Color(shadow.color).opacity(shadow.opacity),
            radius: shadow.radius,
            x: shadow.offset.x,
            y: shadow.offset.y
        )
    }
}
