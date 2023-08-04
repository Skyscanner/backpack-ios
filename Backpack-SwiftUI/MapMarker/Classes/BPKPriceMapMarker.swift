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
            case .default:
                return .label2
            case .focused:
                return .label1
            case .viewed:
                return .label2
            case .disabled:
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
                return .init(value: .white.withAlphaComponent(0.8))
                    .darkVariant(.init(value: .black.withAlphaComponent(0.8)))
            case .disabled:
                return .textDisabledColor
            }
        }
        
        var backgroundColor: BPKColor {
            switch self {
            case .default:
                return .coreAccentColor
            case .focused:
                return .surfaceDefaultColor
            case .viewed:
                return .coreAccentColor
            case .disabled:
                return .surfaceDefaultColor
            }
        }
    }
    
    private let state: State
    private let price: String
    
    public init(state: State, price: String) {
        self.state = state
        self.price = price
    }
    
    public var body: some View {
        content
            .clipShape(MarkerShape())
            .shadow(.sm)
    }
    
    @ViewBuilder
    private var content: some View {
        if case .focused = state {
            VStack(spacing: BPKSpacing.none) {
                BPKText(price, style: state.fontStyle)
                    .foregroundColor(state.foregroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: .xs))
                    .padding(.vertical, 4)
                    .padding(.horizontal, .md)
                    .overlay(
                        RoundedRectangle(cornerRadius: .xs)
                            .stroke(Color(.coreAccentColor), lineWidth: 4)
                    )
                    .background(state.backgroundColor)
                Color(.coreAccentColor)
                    .frame(width: 16, height: 6)
            }
        } else {
            BPKText(price, style: state.fontStyle)
                .foregroundColor(state.foregroundColor)
                .padding(.bottom, 6)
                .padding(.vertical, 4)
                .padding(.horizontal, .md)
                .background(state.backgroundColor)
        }
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
