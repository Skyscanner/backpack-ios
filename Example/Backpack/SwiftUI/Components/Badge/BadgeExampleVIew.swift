//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

// swiftlint:disable all
struct BadgeExampleVIew: View {
    @State var changed: Bool = false
    @State var selectedRange: ClosedRange<Float> = -20...20
    @State var selectedValue: Float = 20
    
    var body: some View {
        VStack {
            BPKText("\(selectedRange.lowerBound), \(selectedRange.upperBound)")
            BPKSliderView(
                currentValue: $selectedRange,
                sliderBounds: -50...50
            )
            .trailingAccessibility(label: "Trailing")
            .leadingAccessibility(label: "Leading")
            .frame(width: 200)
            BPKSliderView(
                currentValue: $selectedRange,
                sliderBounds: -50...50
            )
            .trailingAccessibility(label: "Trailing")
            .leadingAccessibility(label: "Leading")
            
            BPKText("\(selectedValue)")
            BPKSSliderView(
                currentValue: $selectedValue,
                sliderBounds: -50...50
            )
            .frame(width: 200)
        }.padding()
    }
}

public struct BPKSSliderView: View {
    @Binding private var currentValue: Float
    private let sliderBounds: ClosedRange<Float>
    private let sliderHeight: CGFloat = 4
    private let step: Float
    private let thumbSize: CGFloat = 20
    private var trailingAccessibilityLabel = ""
    
    
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
                offset: trailingThumbOffset(sliderSize: sliderSize)
            ) { value in
                handleTrailingThumbDrag(value: value, sliderSize: sliderSize)
            }
            .accessibilityLabel(trailingAccessibilityLabel)
            .accessibility(value: Text("\(currentValue)"))
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment: incrementTrailing()
                case .decrement: decrementTrailing()
                @unknown default: break
                }
            }
        }
    }
    
    func trailingAccessibility(label: String) -> BPKSSliderView {
        var result = self
        result.trailingAccessibilityLabel = label
        return result
    }
    
    private func incrementTrailing() {
        currentValue = min(currentValue + Float(step), sliderBounds.upperBound)
    }
    
    private func decrementTrailing() {
        currentValue = max(currentValue - Float(step), sliderBounds.lowerBound)
    }
    
    private func handleTrailingThumbDrag(value: DragGesture.Value, sliderSize: CGSize) {
        let roundedValue = calculateNewValueFromDrag(value: value, sliderSize: sliderSize)
        if roundedValue >= sliderBounds.lowerBound && roundedValue <= sliderBounds.upperBound {
            currentValue = roundedValue
        }
    }
    
    private func trailingThumbOffset(sliderSize: CGSize) -> CGFloat {
        return (sliderSize.width * CGFloat(percentageOfValue(value: currentValue))) - (sliderSize.width / 2)
    }
    
    private func calculateNewValueFromDrag(value: DragGesture.Value, sliderSize: CGSize) -> Float {
        let adjustedThumbPosition = Float(value.location.x - thumbSize / 2 + sliderSize.width / 2)
        let percentageForPosition = adjustedThumbPosition / Float(sliderSize.width)
        let newValue = valueForPercentage(percentageForPosition)
        let roundedByStep = round(newValue / step) * step
        return roundedByStep
    }
    
    private func percentageOfValue(value: Float) -> Float {
        let percentage = (value - Float(sliderBounds.lowerBound)) / (Float(sliderBounds.upperBound) - Float(sliderBounds.lowerBound))
        return percentage
    }
    
    private func valueForPercentage(_ percentage: Float) -> Float {
        let value = Float(sliderBounds.lowerBound) + (percentage * (Float(sliderBounds.upperBound) - Float(sliderBounds.lowerBound)))
        return value
    }
}

public struct BPKSliderView: View {
    @Binding private var currentValue: ClosedRange<Float>
    private let sliderBounds: ClosedRange<Float>
    private let sliderHeight: CGFloat = 4
    private let step: Float
    private let thumbSize: CGFloat = 20
    private var trailingAccessibilityLabel = ""
    private var leadingAccessibilityLabel = ""
    
    public init(
        currentValue: Binding<ClosedRange<Float>>,
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
        .onAppear(perform: clampCurrentValueToBounds)
    }
    
    private func clampCurrentValueToBounds() {
        if currentValue.lowerBound < sliderBounds.lowerBound {
            $currentValue.wrappedValue = sliderBounds.lowerBound...$currentValue.wrappedValue.upperBound
        }
        if currentValue.upperBound > sliderBounds.upperBound {
            $currentValue.wrappedValue = $currentValue.wrappedValue.lowerBound...sliderBounds.upperBound
        }
    }
    
    @ViewBuilder private func sliderView(sliderSize: CGSize) -> some View {
        ZStack {
            Capsule()
                .fill(Color(.lineColor))
                .frame(width: sliderSize.width, height: sliderHeight)
            ZStack {
                Rectangle()
                    .fill(Color(.coreAccentColor))
                    .frame(width: fillLineWidth(sliderSize: sliderSize), height: sliderHeight)
                    .offset(x: fillLineOffset(sliderSize: sliderSize))
                SliderThumbView(
                    size: thumbSize,
                    offset: trailingThumbOffset(sliderSize: sliderSize)
                ) { value in
                    handleTrailingThumbDrag(value: value, sliderSize: sliderSize)
                }
                .accessibilityLabel(trailingAccessibilityLabel)
                .accessibility(value: Text("\(currentValue.upperBound)"))
                .accessibilityAdjustableAction { direction in
                    switch direction {
                    case .increment: incrementTrailing()
                    case .decrement: decrementTrailing()
                    @unknown default: break
                    }
                }
                SliderThumbView(
                    size: thumbSize,
                    offset: leadingThumbOffset(sliderSize: sliderSize)
                ) { value in
                    handleLeadingThumbDrag(value: value, sliderSize: sliderSize)
                }
                .accessibilityLabel(leadingAccessibilityLabel)
                .accessibility(value: Text("\(currentValue.lowerBound)"))
                .accessibilityAdjustableAction { direction in
                    switch direction {
                    case .increment: incrementLeading()
                    case .decrement: decrementLeading()
                    @unknown default: break
                    }
                }
            }
        }
    }
    
    func trailingAccessibility(label: String) -> BPKSliderView {
        var result = self
        result.trailingAccessibilityLabel = label
        return result
    }
    
    func leadingAccessibility(label: String) -> BPKSliderView {
        var result = self
        result.leadingAccessibilityLabel = label
        return result
    }
    
    private func incrementLeading() {
        let newValue = min($currentValue.wrappedValue.lowerBound + Float(step), currentValue.upperBound)
        $currentValue.wrappedValue = newValue...$currentValue.wrappedValue.upperBound
    }
    
    private func decrementLeading() {
        let newValue = max($currentValue.wrappedValue.lowerBound - Float(step), sliderBounds.lowerBound)
        $currentValue.wrappedValue = newValue...$currentValue.wrappedValue.upperBound
    }
    
    private func incrementTrailing() {
        let newValue = min($currentValue.wrappedValue.upperBound + Float(step), sliderBounds.upperBound)
        $currentValue.wrappedValue = $currentValue.wrappedValue.lowerBound...newValue
    }
    
    private func decrementTrailing() {
        let newValue = max($currentValue.wrappedValue.upperBound - Float(step), currentValue.lowerBound)
        $currentValue.wrappedValue = $currentValue.wrappedValue.lowerBound...newValue
    }
    
    private func calculateNewValueFromDrag(value: DragGesture.Value, sliderSize: CGSize) -> Float {
        let adjustedThumbPosition = Float(value.location.x - thumbSize / 2 + sliderSize.width / 2)
        let percentageForPosition = adjustedThumbPosition / Float(sliderSize.width)
        let newValue = valueForPercentage(percentageForPosition)
        let roundedByStep = round(newValue / step) * step
        return roundedByStep
    }
    
    private func handleTrailingThumbDrag(value: DragGesture.Value, sliderSize: CGSize) {
        let roundedValue = calculateNewValueFromDrag(value: value, sliderSize: sliderSize)
        if roundedValue >= currentValue.lowerBound && roundedValue <= sliderBounds.upperBound {
            $currentValue.wrappedValue = $currentValue.wrappedValue.lowerBound...roundedValue
        }
    }
    
    private func handleLeadingThumbDrag(value: DragGesture.Value, sliderSize: CGSize) {
        let roundedValue = calculateNewValueFromDrag(value: value, sliderSize: sliderSize)
        if roundedValue <= currentValue.upperBound && roundedValue >= sliderBounds.lowerBound {
            $currentValue.wrappedValue = roundedValue...$currentValue.wrappedValue.upperBound
        }
    }
    
    private func leadingThumbOffset(sliderSize: CGSize) -> CGFloat {
        let currentValueLowerBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.lowerBound))
        let offset = (sliderSize.width * CGFloat(currentValueLowerBoundPercentage)) - (sliderSize.width / 2)
        return offset
    }
    
    private func trailingThumbOffset(sliderSize: CGSize) -> CGFloat {
        let currentValueUpperBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.upperBound))
        let offset = (sliderSize.width * CGFloat(currentValueUpperBoundPercentage)) - (sliderSize.width / 2)
        return offset
    }
    
    private func fillLineOffset(sliderSize: CGSize) -> CGFloat {
        let currentValueLowerBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.lowerBound))
        let currentValueUpperBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.upperBound))
        let centerPercentagePoint = (currentValueLowerBoundPercentage + currentValueUpperBoundPercentage) / 2
        let offset = (sliderSize.width * CGFloat(centerPercentagePoint)) - (sliderSize.width / 2)
        return offset
    }
    
    private func valueForPercentage(_ percentage: Float) -> Float {
        let value = Float(sliderBounds.lowerBound) + (percentage * (Float(sliderBounds.upperBound) - Float(sliderBounds.lowerBound)))
        return value
    }
    
    private func percentageOfValue(value: Float) -> Float {
        let percentage = (value - Float(sliderBounds.lowerBound)) / (Float(sliderBounds.upperBound) - Float(sliderBounds.lowerBound))
        return percentage
    }
    
    private func fillLineWidth(sliderSize: CGSize) -> CGFloat {
        let currentValueLowerBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.lowerBound))
        let currentValueUpperBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.upperBound))
        let width = sliderSize.width * CGFloat(currentValueUpperBoundPercentage - currentValueLowerBoundPercentage)
        return width
    }
}

struct SliderThumbView: View {
    let size: CGFloat
    let offset: CGFloat
    let onDrag: (DragGesture.Value) -> Void
    
    var body: some View {
        Circle()
            .fill(Color(.coreAccentColor))
            .frame(width: size, height: size)
            .shadow(.sm)
            .offset(x: offset)
            .highPriorityGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in onDrag(value) }
            )
    }
}

struct BadgeExampleVIew_Previews: PreviewProvider {
    static var previews: some View {
        BadgeExampleVIew()
    }
}
