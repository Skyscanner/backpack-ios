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

public struct BPKPoiMapMarker: View {
    public enum State {
        case `default`
        case focused
        case disabled
        
        var foregroundColor: BPKColor {
            switch self {
            case .default:
                return .surfaceDefaultColor
            case .focused:
                return .coreEcoColor
            case .disabled:
                return .statusSuccessSpotColor
            }
        }
        
        var backgroundColor: BPKColor {
            switch self {
            case .default:
                return .statusSuccessSpotColor
            case .focused:
                return .statusSuccessFillColor
            case .disabled:
                return .surfaceDefaultColor
            }
        }
    }
    
    private let state: State
    private let icon: BPKIcon
    
    public init(state: State, icon: BPKIcon) {
        self.state = state
        self.icon = icon
    }
    
    public var body: some View {
        if state == .disabled {
            ZStack {
                Color(state.backgroundColor)
                    .frame(width: 32, height: 40)
                    .clipShape(MarkerShape())
                    .overlay(
                        MarkerShape()
                            .stroke(Color(.statusSuccessSpotColor), lineWidth: 1)
                    )
                BPKIconView(icon)
                    .foregroundColor(state.foregroundColor)
                    .padding(.bottom, .md)
                
            }
            .shadow(.sm)
        } else {
            ZStack {
                Color(state.backgroundColor)
                    .frame(width: 26, height: 32)
                    .clipShape(MarkerShape())
                
                BPKIconView(icon)
                    .foregroundColor(state.foregroundColor)
                    .padding(.bottom, 6)
            }
            .shadow(.sm)
        }
    }
}

struct BPKPoiMapMarker_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKPoiMapMarker(state: .default, icon: .landmark)
            BPKPoiMapMarker(state: .focused, icon: .landmark)
            BPKPoiMapMarker(state: .disabled, icon: .landmark)
        }
    }
}
