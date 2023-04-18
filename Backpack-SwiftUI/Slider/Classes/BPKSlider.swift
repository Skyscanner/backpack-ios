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

public struct BPKSlider: View {
    @Binding private var currentValue: Float
    private let sliderBounds: ClosedRange<Float>
    private let step: Float

    private let sliderHeight: CGFloat = 4
    private let thumbSize: CGFloat = 20
    private var thumbAccessibilityLabel = ""
    
    public init(
        currentValue: Binding<Float>,
        sliderBounds: ClosedRange<Float>,
        step: Float = 1
    ) {
        self._currentValue = currentValue
        self.sliderBounds = sliderBounds
        self.step = step
    }
    
    public var body: some View {
        GeometryReader { geomentry in
            sliderView(sliderSize: geomentry.size)
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(height: thumbSize)
        .padding([.leading, .trailing], thumbSize / 2)
    }
    
    @ViewBuilder private func sliderView(sliderSize: CGSize) -> some View {
        ZStack {
            Capsule()
                .fill(Color(.lineColor))
                .frame(width: sliderSize.width, height: sliderHeight)
            SliderThumbView(
                size: thumbSize,
                offset: thumbOffset(sliderSize: sliderSize)
            ) { value in
                handleThumbDrag(value: value, sliderSize: sliderSize)
            }
            .accessibilityLabel(thumbAccessibilityLabel)
            .accessibility(value: Text("\(currentValue)"))
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment: increment()
                case .decrement: decrement()
                @unknown default: break
                }
            }
        }
    }
    
    func thumbAccessibility(label: String) -> BPKSlider {
        var result = self
        result.thumbAccessibilityLabel = label
        return result
    }
    
    private func increment() {
        currentValue = min(currentValue + step, sliderBounds.upperBound)
    }
    
    private func decrement() {
        currentValue = max(currentValue - step, sliderBounds.lowerBound)
    }
    
    private func handleThumbDrag(value: DragGesture.Value, sliderSize: CGSize) {
        let roundedValue = BPKSliderHelpers.calculateNewValueFromDrag(
            value: value,
            sliderSize: sliderSize,
            thumbSize: thumbSize,
            sliderBounds: sliderBounds,
            step: step
        )
        if roundedValue >= sliderBounds.lowerBound && roundedValue <= sliderBounds.upperBound {
            currentValue = roundedValue
        }
    }
    
    private func thumbOffset(sliderSize: CGSize) -> CGFloat {
        let percentage = BPKSliderHelpers.percentageOfValue(
            value: currentValue,
            sliderBounds: sliderBounds
        )
        return sliderSize.width * CGFloat(percentage) - (sliderSize.width / 2)
    }
}

struct BPKSlider_Previews: PreviewProvider {
    static var previews: some View {
        BPKSlider(currentValue: .constant(50), sliderBounds: 0...100)
    }
}
