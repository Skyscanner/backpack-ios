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

struct BPKStarView: View {
    enum StarType {
        case empty, half, full
        
        var iconName: BPKIcon {
            switch self {
            case .empty: return .starOutline
            case .half: return .starHalf
            case .full: return .star
            }
        }
        
        var color: BPKColor {
            switch self {
            case .empty: return .textDisabledColor
            case .half: return .statusWarningSpotColor
            case .full: return .statusWarningSpotColor
            }
        }
    }
    
    let type: StarType
    let size: BPKIcon.Size
    
    var body: some View {
        BPKIconView(type.iconName, size: size)
            .foregroundColor(type.color)
    }
}

struct BPKStarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                BPKText("Large", style: .heading3)
                BPKStarView(type: .empty, size: .large)
                BPKStarView(type: .half, size: .large)
                BPKStarView(type: .full, size: .large)
            }
            HStack {
                BPKText("Small", style: .heading3)
                BPKStarView(type: .empty, size: .small)
                BPKStarView(type: .half, size: .small)
                BPKStarView(type: .full, size: .small)
            }
        }
    }
}
