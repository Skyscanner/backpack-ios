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

/// A view that displays a horizontal slider with a thumb that
/// can be dragged to select a value.
public struct BPKSlider: View {
    @Binding private var value: Float
    private let sliderBounds: ClosedRange<Float>
    private let step: Float
    private let onDragEnded: (Float) -> Void

    private let sliderHeight: CGFloat = 4
    private let thumbSize: CGFloat = 20
    private var thumbAccessibilityLabel = ""
    
    @Environment(\.layoutDirection) private var layoutDirection
    
    /// Creates a new instance of `BPKSlider`.
    ///
    /// If the value is outside the bounds of the slider, it will be clamped to the bounds.
    ///
    /// - Parameters:
    ///   - value: Binding of the value of the slider.
    ///   - sliderBounds: The bounds of the slider.
    ///   - step: The step size of the slider. Defaults to 1.
    ///   - onDragEnded: A closure that will be called when the user stops dragging the slider.
    public init(
        value: Binding<Float>,
        sliderBounds: ClosedRange<Float>,
        step: Float = 1,
        onDragEnded: @escaping (Float) -> Void = { _ in }
    ) {
        self._value = value
        self.sliderBounds = sliderBounds
        self.step = step
        self.onDragEnded = onDragEnded
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
            Rectangle()
                .fill(Color(.coreAccentColor))
                .frame(width: fillLineWidth(sliderSize: sliderSize), height: sliderHeight)
                .offset(x: fillLineOffset(sliderSize: sliderSize))
            thumbView(sliderSize: sliderSize)
        }
    }
    
    /// Sets the accessibility label for the thumb.
    public func thumbAccessibility(label: String) -> BPKSlider {
        var result = self
        result.thumbAccessibilityLabel = label
        return result
    }
    
    private func thumbView(sliderSize: CGSize) -> some View {
        SliderThumbView(
            size: thumbSize,
            offset: thumbOffset(sliderSize: sliderSize)
        ) { dragValue in
            handleThumbDrag(value: dragValue, sliderSize: sliderSize)
        } onDragEnded: {
            onDragEnded(value)
        }
        .accessibilityLabel(thumbAccessibilityLabel)
        .accessibility(value: Text("\(value)"))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment: increment()
            case .decrement: decrement()
            @unknown default: break
            }
        }
    }
    
    private func increment() {
        value = min(value + step, sliderBounds.upperBound)
        onDragEnded(value)
    }
    
    private func decrement() {
        value = max(value - step, sliderBounds.lowerBound)
        onDragEnded(value)
    }
    
    private func fillLineWidth(sliderSize: CGSize) -> CGFloat {
        let percentage = BPKSliderHelpers.percentageOfValue(
            value: value,
            sliderBounds: sliderBounds
        )
        return sliderSize.width * CGFloat(percentage)
    }

    private func fillLineOffset(sliderSize: CGSize) -> CGFloat {
        let percentage = BPKSliderHelpers.percentageOfValue(
            value: value,
            sliderBounds: sliderBounds
        )
        return (sliderSize.width * CGFloat(percentage) / 2) - (sliderSize.width / 2)
    }

    private func handleThumbDrag(value dragValue: DragGesture.Value, sliderSize: CGSize) {
        let roundedValue = BPKSliderHelpers.calculateNewValueFromDrag(
            xLocation: dragValue.location.x,
            sliderWidth: sliderSize.width,
            thumbSize: thumbSize,
            sliderBounds: sliderBounds,
            step: step,
            layoutDirection: layoutDirection
        )
        if roundedValue >= sliderBounds.lowerBound && roundedValue <= sliderBounds.upperBound {
            value = roundedValue
        }
    }
    
    private func thumbOffset(sliderSize: CGSize) -> CGFloat {
        let percentage = BPKSliderHelpers.percentageOfValue(
            value: value,
            sliderBounds: sliderBounds
        )
        return sliderSize.width * CGFloat(percentage) - (sliderSize.width / 2)
    }
}

struct BPKSlider_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKSlider(value: .constant(-25), sliderBounds: -50...50)
            BPKSlider(value: .constant(50), sliderBounds: 0...100)
            BPKSlider(value: .constant(75), sliderBounds: 0...100)
        }
    }
}
