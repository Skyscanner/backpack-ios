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

public struct BPKPriceMapMarker: View {
    public enum State {
        case `default`
        case focused
        case viewed
        case disabled
        
        var fontStyle: BPKFontStyle {
            switch self {
            case .focused:
                return .label1
            default:
                return .label2
            }
        }
        
        var foregroundColor: BPKColor {
            switch self {
            case .default:
                return .textPrimaryInverseColor
            case .focused:
                return .coreAccentColor
            case .viewed:
                return .mapMarkerViewedForegroundColor
            case .disabled:
                return .textDisabledColor
            }
        }
        
        var backgroundColor: BPKColor {
            switch self {
            case .default, .viewed:
                return .coreAccentColor
            case .focused, .disabled:
                return .surfaceDefaultColor
            }
        }
        
        var flareColor: BPKColor {
            switch self {
            case .focused: return foregroundColor
            default: return backgroundColor
            }
        }
    }
    
    private let state: State
    private let price: String
    
    private let flareHeight: CGFloat = 6
    
    public init(state: State, price: String) {
        self.state = state
        self.price = price
    }
    
    public var body: some View {
        labelView
            .if(state == .focused) { label in
                label.overlay(
                    MarkerShape(flareHeight: flareHeight)
                        .stroke(Color(state.foregroundColor), lineWidth: BPKSpacing.sm.value)
                )
            }
            .clipShape(MarkerShape(flareHeight: flareHeight))
            .shadow(.sm)
    }
    
    private var labelView: some View {
        BPKText(price, style: state.fontStyle)
            .foregroundColor(state.foregroundColor)
            .padding(.vertical, .sm)
            .padding(.horizontal, .md)
            .background(state.backgroundColor)
            .padding(.bottom, flareHeight)
            .background(state.flareColor)
    }
}

struct BPKPriceMapMarker_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKPriceMapMarker(state: .default, price: "£200")
            BPKPriceMapMarker(state: .focused, price: "£200")
            BPKPriceMapMarker(state: .viewed, price: "£200")
            BPKPriceMapMarker(state: .disabled, price: "Sould out")
        }
    }
}
