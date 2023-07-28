//
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
import Backpack_SwiftUI

struct ProgressBarExampleView: View {
    @State var progress: Float = 1.5
    
    var body: some View {
        VStack {
            BPKSlider(value: $progress, sliderBounds: 0...3, step: 0.01)
            BPKProgressBar(max: 3, stepped: false, size: .small, value: $progress)
            BPKProgressBar(max: 3, stepped: true, size: .small, value: $progress)
            BPKProgressBar(max: 3, stepped: false, size: .large, value: $progress)
            BPKProgressBar(max: 3, stepped: true, size: .large, value: $progress)
        }
        .padding()
    }
}

private struct BPKProgressBar: View {
    enum Size {
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
    @Binding var value: Float
    
    init(max: Int, stepped: Bool, size: Size, value: Binding<Float>) {
        self.max = max
        self.stepped = stepped
        self.size = size
        self._value = value
    }

    private var progress: Float {
        min(Swift.max(0, value), Float(max))
    }

    private var percentage: Float {
        progress / Float(max)
    }
    
    public var body: some View {
        if stepped {
            steppedProgressBar
        } else {
            GeometryReader { proxy in
                ZStack {
                    Capsule()
                        .foregroundColor(BPKColor.surfaceHighlightColor)
                    Capsule()
                        .foregroundColor(BPKColor.coreAccentColor)
                        .frame(width: width(for: proxy))
                        .offset(x: offset(for: proxy))
                }
            }
            .frame(height: size.height)
            .animation(.easeInOut, value: value)
        }
    }
    
    private var steppedProgressBar: some View {
        GeometryReader { proxy in
            ZStack {
                Capsule()
                    .foregroundColor(BPKColor.surfaceHighlightColor)
                // only round corners on the leading edge
                Capsule()
                    .clipShape(<#T##S#>)
                    .foregroundColor(BPKColor.coreAccentColor)
                    .frame(width: width(for: proxy))
                    .offset(x: offset(for: proxy))
                HStack {
                    Spacer()
                    ForEach(0..<max - 1, id: \.self) { _ in
                        Rectangle()
                            .foregroundColor(BPKColor.lineColor)
                            .frame(width: 2)
                        Spacer()
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
        .frame(height: size.height)
        .animation(.easeInOut, value: value)
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

struct ProgressBarExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarExampleView()
    }
}
