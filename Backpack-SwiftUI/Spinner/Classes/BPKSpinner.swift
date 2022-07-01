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

struct LoadingCapsule: View {
    let size: BPKSpinner.Size
    
    var body: some View {
        Capsule()
            .offset(x: (size.width.value - size.capsuleWidth) / 2)
            .frame(width: size.capsuleWidth, height: size.capsuleHeight)
    }
}

public struct BPKSpinner: View {
    @State private var itemOpacities = [0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.65, 0.75, 0.85, 1]
    
    private let size: BPKSpinner.Size
    private let style: BPKSpinner.Style
    
    private let timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()
    
    public init(_ size: BPKSpinner.Size = .sm, style: BPKSpinner.Style = .textPrimary) {
        self.size = size
        self.style = style
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke()
                .frame(width: size.width, height: size.height)
                .opacity(0)
            
            ForEach((0..<itemOpacities.count), id: \.self) { index in
                LoadingCapsule(size: size)
                    .foregroundColor(style.foregroundColor)
                    .opacity(itemOpacities[index])
                    .rotationEffect(.degrees(Double(index * (360 / itemOpacities.count))))
            }
        }
        .onReceive(timer) { input in
            itemOpacities = itemOpacities.shiftedLeft(by: -1)
        }
    }
}

fileprivate extension Array {
    func shiftedLeft(by rawOffset: Int = 1) -> Array {
        let clampedAmount = rawOffset % count
        let offset = clampedAmount < 0 ? count + clampedAmount : clampedAmount
        return Array(self[offset ..< count] + self[0 ..< offset])
    }
}

struct BPKSpinner_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            BPKSpinner(.sm)
            BPKSpinner(.lg)
            BPKSpinner(.xl)
        }
    }
}
