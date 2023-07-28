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

public struct BPKProgressBar: View {
    public enum Size {
        case small, large
        
        var height: BPKSpacing {
            switch self {
            case .small:
                return BPKSpacing.md
            case .large:
                return BPKSpacing.base
            }
        }
    }
    
    let max: Int
    let stepped: Bool
    let size: Size
    let value: Float
    
    public init(max: Int, stepped: Bool, size: Size, value: Float) {
        self.max = max
        self.stepped = stepped
        self.size = size
        self.value = value
    }
    
    private var progress: Float {
        min(Swift.max(0, value), Float(max))
    }
    
    private var percentage: Float {
        progress / Float(max)
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Capsule()
                    .foregroundColor(BPKColor.surfaceHighlightColor)
                progressBarShape
                    .foregroundColor(BPKColor.coreAccentColor)
                    .frame(width: width(for: proxy))
                    .offset(x: offset(for: proxy))
                if stepped {
                    HStack {
                        Spacer()
                        ForEach(0..<max - 1, id: \.self) { _ in
                            Rectangle()
                                .foregroundColor(BPKColor.surfaceDefaultColor)
                                .frame(width: 2)
                            Spacer()
                        }
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
        }
        .frame(height: size.height)
        .animation(.easeInOut, value: value)
    }

    @ViewBuilder
    private var progressBarShape: some View {
        if stepped {
            /// iOS 16 adds support for leading and trailing semantics rather than left-right
            /// but XCode 15 is needed to use that feature.
            /// Update API to leading and trailing when XCode 15 is used in CI
            let corners: UIRectCorner = value == Float(max) ? .allCorners : [.topLeft, .bottomLeft]
            let cornerSize = size.height.value / 2
            Rectangle()
                .clipShape(
                    RoundedCustomCornersShape(
                        radius: cornerSize,
                        corners: corners
                    )
                )
        } else {
            Capsule()
        }
    }
    
    private func width(for proxy: GeometryProxy) -> CGFloat {
        if stepped {
            let stepWidth = proxy.size.width / CGFloat(max)
            return stepWidth * CGFloat(Int(value))
        }
        return proxy.size.width * CGFloat(percentage)
    }
    
    private func offset(for proxy: GeometryProxy) -> CGFloat {
        return -proxy.size.width / 2 + width(for: proxy) / 2
    }
}

struct BPKProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKProgressBar(max: 3, stepped: false, size: .small, value: 1.5)
            BPKProgressBar(max: 3, stepped: true, size: .small, value: 1.5)
            BPKProgressBar(max: 3, stepped: false, size: .large, value: 1.5)
            BPKProgressBar(max: 3, stepped: true, size: .large, value: 1.5)
        }
        .padding()
    }
}
